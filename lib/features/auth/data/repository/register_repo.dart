import '../../../../core/errors/server_failures.dart';
import '../../../../core/services/base_service.dart';
import 'package:dartz/dartz.dart';

import '../models/register_model.dart';
import '../models/login_model.dart';

abstract class RegisterRepo extends BaseServices {
  Future<Either<Failures, LoginResponseModel>> register({required RegisterModel loginModel});
}
