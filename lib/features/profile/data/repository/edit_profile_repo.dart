import '../../../../core/errors/server_failures.dart';
import '../../../../core/services/base_service.dart';
import 'package:dartz/dartz.dart';
import 'dart:io';
import '../models/user_profile_model.dart';

abstract class EditProfileRepo extends BaseServices {
  Future<Either<Failures, UserProfileModel>> updateUserProfile(String name, File? profileImage);
}
