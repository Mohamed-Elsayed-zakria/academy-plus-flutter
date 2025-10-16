import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/server_failures.dart';
import '../../../data/models/user_profile_model.dart';
import '../../../data/repository/profile_repo.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileRepo) : super(ProfileInitial());
  final ProfileRepo _profileRepo;

  Future<void> getUserProfile() async {
    emit(ProfileLoading());
    Either<Failures, UserProfileModel> result = await _profileRepo.getUserProfile();
    result.fold(
      (failures) => emit(ProfileError(error: failures.errMessage)),
      (profile) => emit(ProfileLoaded(profile: profile)),
    );
  }

  Future<void> updateUserProfile(UserProfileModel profile) async {
    emit(ProfileLoading());
    Either<Failures, UserProfileModel> result = await _profileRepo.updateUserProfile(profile);
    result.fold(
      (failures) => emit(ProfileError(error: failures.errMessage)),
      (updatedProfile) => emit(ProfileLoaded(profile: updatedProfile)),
    );
  }
}
