import '../../../../core/errors/server_failures.dart';
import '../../../../core/services/base_service.dart';
import 'package:dartz/dartz.dart';
import 'dart:io';
import '../models/user_profile_model.dart';

abstract class ProfileRepo extends BaseServices {
  Future<Either<Failures, UserProfileModel>> getUserProfile();
  Future<Either<Failures, UserProfileModel>> updateUserProfile(UserProfileModel profile);
  Future<Either<Failures, UserProfileModel>> updateUserProfileWithImage(String name, File? profileImage);
  Future<Either<Failures, bool>> logout();
}
