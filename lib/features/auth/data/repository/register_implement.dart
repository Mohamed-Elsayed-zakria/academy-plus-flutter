import '../../../../core/constants/api_end_point.dart';
import '../../../../core/errors/server_failures.dart';
import '../models/register_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'register_repo.dart';

class RegisterImplement extends RegisterRepo {
  @override
  Future<Either<Failures, void>> register({
    required RegisterModel loginModel,
  }) async {
    try {
      const url = "${APIEndPoint.url}${APIEndPoint.register}";
      
      // Create FormData for file upload
      final formData = FormData.fromMap(loginModel.toFormData());
      
      final response = await dio.post(url, data: formData);
      
      if (response.statusCode == 201) {
        // TODO: Handle successful registration response
        // Store token and user data if needed
        return right(null);
      } else {
        return left(ServerFailures(errMessage: 'Registration failed'));
      }
    } catch (e) {
      return left(returnDioException(e));
    }
  }
}
