import '../../../../core/errors/server_failures.dart';
import '../../../../core/services/base_service.dart';
import 'package:dartz/dartz.dart';
import '../models/update_profile_model.dart';

abstract class ProfileRepo extends BaseServices {
  Future<Either<Failures, void>> updateProfile(UpdateProfileModel updateProfileModel);
}
