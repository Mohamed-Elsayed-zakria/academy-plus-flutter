import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import '../../../../../core/errors/server_failures.dart';
import '../../../../../core/services/auth_service.dart';
import '../../../../../core/services/auth_manager.dart';
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

  Future<void> updateUserProfileWithImage(String name, File? profileImage) async {
    emit(ProfileLoading());
    Either<Failures, UserProfileModel> result = await _profileRepo.updateUserProfileWithImage(name, profileImage);
    result.fold(
      (failures) => emit(ProfileError(error: failures.errMessage)),
      (updatedProfile) => emit(ProfileLoaded(profile: updatedProfile)),
    );
  }

  Future<void> logout() async {
    emit(ProfileLoading());
    
    try {
      // Clear local session only (no API call needed)
      await _clearLocalSession();
      // Emit success state
      emit(ProfileLogoutSuccess());
    } catch (e) {
      emit(ProfileError(error: 'خطأ في تسجيل الخروج'));
    }
  }

  // Helper method to clear local session
  Future<void> _clearLocalSession() async {
    try {
      // Clear data from SharedPreferences
      await AuthService.logout();
      // Clear data from AuthManager
      AuthManager.clearUserData();
      // Verify that logout was successful
      final isStillLoggedIn = await AuthService.isLoggedIn();
      print('🔍 Verification - isLoggedIn: $isStillLoggedIn');
      
      print('✅ Local session cleared successfully');
    } catch (e) {
      print('❌ Error clearing local session: $e');
    }
  }
}
