import 'package:dio/dio.dart';

/// Base failure class to hold error messages
class Failures {
  final String errMessage;
  Failures({required this.errMessage});
}

/// Handles local (non-server) failures
class LocalFailures extends Failures {
  LocalFailures({required super.errMessage});

  factory LocalFailures.errorMessage({String? error}) {
    switch (error) {
      case null:
        return LocalFailures(errMessage: 'Something went wrong');
      default:
        return LocalFailures(errMessage: error);
    }
  }
}

/// Handles server (API) failures
class ServerFailures extends Failures {
  ServerFailures({required super.errMessage});

  factory ServerFailures.fromDioError({
    required DioException dioError,
  }) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailures(errMessage: 'Connection timeout with API server');
      case DioExceptionType.sendTimeout:
        return ServerFailures(errMessage: 'Send timeout with API server');
      case DioExceptionType.receiveTimeout:
        return ServerFailures(errMessage: 'Receive timeout with API server');
      case DioExceptionType.badCertificate:
        return ServerFailures(errMessage: 'Bad certificate');
      case DioExceptionType.badResponse:
        return ServerFailures.fromResponse(
          statusCode: dioError.response?.statusCode ?? 0,
          response: dioError.response?.data,
        );
      case DioExceptionType.cancel:
        return ServerFailures(
          errMessage: 'Request to API server was cancelled',
        );
      case DioExceptionType.connectionError:
        return ServerFailures(errMessage: 'Connection error with API server');
      case DioExceptionType.unknown:
        if (dioError.message?.contains('SocketException') ?? false) {
          return ServerFailures(errMessage: 'No internet connection');
        }
        return ServerFailures(errMessage: 'Something went wrong');
    }
  }

  /// Parses the response body from the server and extracts the appropriate message
  factory ServerFailures.fromResponse({
    required int statusCode,
    required dynamic response,
  }) {
    try {
      // Function to extract message correctly from backend structure
      String extractMessage(dynamic msg) {
        if (msg is Map<String, dynamic>) {
          // Prefer English if available, fallback to Arabic
          return msg['nameEn'] ?? msg['nameAr'] ?? 'Something went wrong';
        } else if (msg is String) {
          return msg;
        } else {
          return 'Something went wrong';
        }
      }

      switch (statusCode) {
        case 400:
        case 401:
        case 403:
        case 404:
        case 429:
        case 500:
          return ServerFailures(
            errMessage: extractMessage(response?['message']),
          );
        default:
          return ServerFailures(errMessage: 'Something went wrong');
      }
    } catch (e) {
      return ServerFailures(errMessage: 'Something went wrong');
    }
  }
}
