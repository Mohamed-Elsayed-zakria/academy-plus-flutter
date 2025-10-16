import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

class SetupLocator {
  static GetIt locator = GetIt.instance;
  void setup() {
    locator.registerLazySingleton(() => Dio());
  }
}