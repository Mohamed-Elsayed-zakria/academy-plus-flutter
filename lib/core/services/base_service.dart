import '../errors/server_failures.dart';
import 'dio_service.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

class BaseServices {
  final dio = DioService.instance;
  
  ServerFailures returnDioException(Object e) {
    if (e is DioException) {
      log("Error [${e.response?.statusCode}] =====Response [${e.response}]");
      return ServerFailures.fromDioError(dioError: e);
    }
    return ServerFailures(errMessage: 'Something went wrong');
  }
}