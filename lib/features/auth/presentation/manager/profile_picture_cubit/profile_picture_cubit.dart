import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/server_failures.dart';
import '../../../data/models/update_profile_model.dart';
import '../../../data/repository/profile_repo.dart';
import 'profile_picture_state.dart';

class ProfilePictureCubit extends Cubit<ProfilePictureState> {
  final ProfileRepo _profileRepo;

  ProfilePictureCubit(this._profileRepo) : super(ProfilePictureInitial());

  // Update profile image
  void updateProfileImage(File? imageFile) {
    if (state is ProfilePictureInitial) {
      final currentState = state as ProfilePictureInitial;
      emit(currentState.copyWith(profileImage: imageFile));
    }
  }

  // Update profile
  Future<void> updateProfile({String? fullName}) async {
    if (state is! ProfilePictureInitial) return;

    final currentState = state as ProfilePictureInitial;

    // Emit loading state
    emit(ProfilePictureLoading(
      profileImage: currentState.profileImage,
    ));

    // Update profile
    Either<Failures, void> result = await _profileRepo.updateProfile(
      UpdateProfileModel(
        fullName: fullName,
        profileImage: currentState.profileImage,
      ),
    );

    result.fold(
      (failures) => emit(ProfilePictureError(
        error: failures.errMessage,
        profileImage: currentState.profileImage,
      )),
      (_) => emit(ProfilePictureSuccess(
        profileImage: currentState.profileImage,
      )),
    );
  }
}
