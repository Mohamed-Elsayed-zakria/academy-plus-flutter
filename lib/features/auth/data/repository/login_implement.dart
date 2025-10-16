import '../../../../core/constants/api_end_point.dart';
import '../../../../core/errors/server_failures.dart';
import '../models/login_model.dart';
import 'package:dartz/dartz.dart';
import 'login_repo.dart';

class LoginImplement extends LoginRepo {
  @override
  Future<Either<Failures, LoginResponseModel>> login(LoginModel loginModel) async {
    try {
      const url = "${APIEndPoint.url}${APIEndPoint.login}";
      final requestData = loginModel.toJson();

      print('Login Request:');
      print('URL: $url');
      print('Data: $requestData');

      final response = await dio.post(url, data: requestData);

      print('Login Response:');
      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final loginResponse = LoginResponseModel.fromJson(response.data);
        return right(loginResponse);
      } else {
        return left(ServerFailures(errMessage: 'Login failed'));
      }
    } catch (e) {
      print('Login Error: $e');
      return left(returnDioException(e));
    }
  }
}
