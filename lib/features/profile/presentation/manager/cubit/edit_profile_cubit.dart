import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import '../../../../../core/errors/server_failures.dart';
import '../../../data/models/user_profile_model.dart';
import '../../../data/repository/edit_profile_repo.dart';
import '../../../data/repository/profile_implement.dart';
import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this._editProfileRepo) : super(EditProfileInitial());
  final EditProfileRepo _editProfileRepo;
  
  // Add profile implement for loading current data
  final ProfileImplement _profileImplement = ProfileImplement();

  Future<void> loadCurrentProfile() async {
    emit(EditProfileLoading());
    Either<Failures, UserProfileModel> result = await _profileImplement.getUserProfile();
    result.fold(
      (failures) => emit(EditProfileError(error: failures.errMessage)),
      (profile) => emit(EditProfileLoaded(profile: profile)),
    );
  }

  Future<void> updateUserProfile(String name, File? profileImage) async {
    emit(EditProfileLoading());
    Either<Failures, UserProfileModel> result = await _editProfileRepo.updateUserProfile(name, profileImage);
    result.fold(
      (failures) => emit(EditProfileError(error: failures.errMessage)),
      (updatedProfile) => emit(EditProfileSuccess(profile: updatedProfile)),
    );
  }
}
