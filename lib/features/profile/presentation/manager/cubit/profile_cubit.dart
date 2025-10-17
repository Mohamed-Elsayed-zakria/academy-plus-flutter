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
      print('🔄 ProfileCubit.logout() - Starting logout process...');
      
      // Clear local session only (no API call needed)
      await _clearLocalSession();
      
      // Emit success state
      emit(ProfileLogoutSuccess());
      
      print('✅ ProfileCubit.logout() - Logout completed successfully');
    } catch (e) {
      print('❌ ProfileCubit.logout() - Error: $e');
      emit(ProfileError(error: 'خطأ في تسجيل الخروج'));
    }
  }

  // Helper method to clear local session
  Future<void> _clearLocalSession() async {
    try {
      print('🔄 Starting to clear local session...');
      
      // Clear data from SharedPreferences
      await AuthService.logout();
      print('✅ SharedPreferences cleared');
      
      // Clear data from AuthManager
      AuthManager.clearUserData();
      print('✅ AuthManager cleared');
      
      // Verify that logout was successful
      final isStillLoggedIn = await AuthService.isLoggedIn();
      print('🔍 Verification - isLoggedIn: $isStillLoggedIn');
      
      print('✅ Local session cleared successfully');
    } catch (e) {
      print('❌ Error clearing local session: $e');
    }
  }
}
