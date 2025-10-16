import '../errors/server_failures.dart';
import 'service_locator.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

class BaseServices {
  final dio = SetupLocator.locator<Dio>();
  ServerFailures returnDioException(Object e) {
    if (e is DioException) {
      log("Error [${e.response?.statusCode}] =====Response [${e.response}]");
      return ServerFailures.fromDioError(dioError: e);
    }
    return ServerFailures(errMessage: 'Something went wrong');
  }
}