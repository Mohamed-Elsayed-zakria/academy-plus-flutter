import '../../../../core/errors/server_failures.dart';
import '../../../../core/services/base_service.dart';
import 'package:dartz/dartz.dart';
import '../models/login_model.dart';

abstract class LoginRepo extends BaseServices {
  Future<Either<Failures, LoginResponseModel>> login(LoginModel loginModel);
}
