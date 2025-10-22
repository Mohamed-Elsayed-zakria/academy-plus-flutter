import '../../../../core/constants/api_end_point.dart';
import '../../../../core/errors/server_failures.dart';
import '../models/register_model.dart';
import '../models/login_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'register_repo.dart';

class RegisterImplement extends RegisterRepo {
  @override
  Future<Either<Failures, LoginResponseModel>> register({
    required RegisterModel loginModel,
  }) async {
    try {
      const url = "${APIEndPoint.url}${APIEndPoint.register}";
      final formData = FormData.fromMap(loginModel.toFormData());
      final response = await dio.post(url, data: formData);
      if (response.statusCode == 201) {
        // Parse the response to extract token and user data
        final loginResponse = LoginResponseModel.fromJson(response.data);
        return right(loginResponse);
      } else {
        return left(ServerFailures(errMessage: 'Registration failed'));
      }
    } catch (e) {
      return left(returnDioException(e));
    }
  }
}
