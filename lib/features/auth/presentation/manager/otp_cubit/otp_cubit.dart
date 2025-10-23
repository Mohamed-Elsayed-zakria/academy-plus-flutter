import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/server_failures.dart';
import '../../../../../core/services/auth_service.dart';
import '../../../../../core/services/auth_manager.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../data/models/otp_request_model.dart';
import '../../../data/models/otp_verify_model.dart';
import '../../../data/models/login_model.dart';
import '../../../data/repository/otp_repo.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this._otpRepo) : super(OtpInitial());
  final OtpRepo _otpRepo;

  // Update form fields
  void updateOtpCode(String otpCode) {
    if (state is OtpInitial) {
      final currentState = state as OtpInitial;
      emit(currentState.copyWith(otpCode: otpCode));
    } else if (state is OtpRequestSuccess) {
      // Allow updating OTP code from OtpRequestSuccess state
      final currentState = state as OtpRequestSuccess;
      emit(OtpInitial(
        otpCode: otpCode,
        phoneNumber: currentState.phoneNumber,
        hasAttemptedSubmit: false,
      ));
    } else if (state is OtpRequestError) {
      // Allow updating OTP code from OtpRequestError state
      final currentState = state as OtpRequestError;
      emit(OtpInitial(
        otpCode: otpCode,
        phoneNumber: currentState.phoneNumber,
        hasAttemptedSubmit: false,
      ));
    } else if (state is OtpVerifyError) {
      // Allow updating OTP code from OtpVerifyError state
      final currentState = state as OtpVerifyError;
      emit(OtpInitial(
        otpCode: otpCode,
        phoneNumber: currentState.phoneNumber,
        hasAttemptedSubmit: false,
      ));
    }
  }

  void updatePhoneNumber(String phoneNumber) {
    if (state is OtpInitial) {
      final currentState = state as OtpInitial;
      emit(currentState.copyWith(phoneNumber: phoneNumber));
    }
  }

  void setAttemptedSubmit(bool attempted) {
    if (state is OtpInitial) {
      final currentState = state as OtpInitial;
      emit(currentState.copyWith(hasAttemptedSubmit: attempted));
    }
  }

  // Validation methods
  String? validateOtpCode(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.pleaseEnterVerificationCode;
    }
    if (value.length != 6) {
      return AppLocalizations.verificationCodeMustBe6Digits;
    }
    return null;
  }

  // Check if form is valid
  bool isOtpValid() {
    if (state is OtpInitial) {
      final currentState = state as OtpInitial;
      return validateOtpCode(currentState.otpCode) == null;
    }
    return false;
  }

  // Reset state to initial for retry
  void resetToInitial() {
    if (state is OtpInitial) {
      final currentState = state as OtpInitial;
      emit(currentState.copyWith(
        otpCode: '',
        hasAttemptedSubmit: false,
      ));
    } else {
      emit(OtpInitial());
    }
  }

  // Cancel OTP process and clear all data
  Future<void> cancelOtpProcess() async {
    // Clear all authentication data
    await AuthService.logout();
    
    // Reset OTP state to initial
    emit(OtpInitial());
  }

  Future<void> requestOtp(String phoneNumber) async {
    // Allow retry from OtpRequestError and OtpVerifyError states
    if (state is! OtpInitial && state is! OtpRequestError && state is! OtpVerifyError) return;
    
    OtpInitial currentState;
    if (state is OtpInitial) {
      currentState = state as OtpInitial;
    } else if (state is OtpRequestError) {
      // If coming from OtpRequestError, create new initial state
      currentState = OtpInitial(
        otpCode: '',
        phoneNumber: phoneNumber,
        hasAttemptedSubmit: false,
      );
    } else {
      // If coming from OtpVerifyError, create new initial state
      currentState = OtpInitial(
        otpCode: '',
        phoneNumber: phoneNumber,
        hasAttemptedSubmit: false,
      );
    }
    
    // Update phone number
    emit(currentState.copyWith(phoneNumber: phoneNumber));

    // Emit loading state
    emit(OtpRequestLoading(
      otpCode: currentState.otpCode,
      phoneNumber: phoneNumber,
      hasAttemptedSubmit: currentState.hasAttemptedSubmit,
    ));

    Either<Failures, void> result = await _otpRepo.requestOtp(
      OtpRequestModel(phoneNumber: phoneNumber),
    );

    result.fold(
      (failures) => emit(OtpRequestError(
        error: failures.errMessage,
        otpCode: currentState.otpCode,
        phoneNumber: phoneNumber,
        hasAttemptedSubmit: currentState.hasAttemptedSubmit,
      )),
      (_) => emit(OtpRequestSuccess(
        otpCode: currentState.otpCode,
        phoneNumber: phoneNumber,
        hasAttemptedSubmit: currentState.hasAttemptedSubmit,
      )),
    );
  }

  Future<void> verifyOtp(String phoneNumber, String otpCode) async {
    // Allow retry from OtpVerifyError, OtpRequestSuccess, and OtpRequestError states
    if (state is! OtpInitial && state is! OtpVerifyError && state is! OtpRequestSuccess && state is! OtpRequestError) return;
    
    OtpInitial currentState;
    if (state is OtpInitial) {
      currentState = state as OtpInitial;
    } else if (state is OtpRequestSuccess) {
      // If coming from OtpRequestSuccess, use the existing state data
      currentState = OtpInitial(
        otpCode: '',
        phoneNumber: phoneNumber,
        hasAttemptedSubmit: false,
      );
    } else if (state is OtpRequestError) {
      // If coming from OtpRequestError, create new initial state
      currentState = OtpInitial(
        otpCode: '',
        phoneNumber: phoneNumber,
        hasAttemptedSubmit: false,
      );
    } else {
      // If coming from OtpVerifyError, create new initial state
      currentState = OtpInitial(
        otpCode: '',
        phoneNumber: phoneNumber,
        hasAttemptedSubmit: false,
      );
    }
    
    // Set attempted submit to true
    emit(currentState.copyWith(hasAttemptedSubmit: true));
    
    // Update form fields
    emit(currentState.copyWith(
      otpCode: otpCode,
      phoneNumber: phoneNumber,
      hasAttemptedSubmit: true,
    ));

    // Check if form is valid
    if (validateOtpCode(otpCode) != null) {
      return;
    }

    // Emit loading state
    emit(OtpVerifyLoading(
      otpCode: otpCode,
      phoneNumber: phoneNumber,
      hasAttemptedSubmit: true,
    ));

    Either<Failures, void> result = await _otpRepo.verifyOtp(
      OtpVerifyModel(phoneNumber: phoneNumber, otpCode: otpCode),
    );

    result.fold(
      (failures) => emit(OtpVerifyError(
        error: failures.errMessage,
        otpCode: otpCode,
        phoneNumber: phoneNumber,
        hasAttemptedSubmit: true,
      )),
      (_) async {
        // Update phone verification status in SharedPreferences
        await AuthService.updatePhoneVerificationStatus(true);
        
        // Update AuthManager's current user data
        final currentUser = AuthManager.currentUser;
        if (currentUser != null) {
          final updatedUser = UserModel(
            id: currentUser.id,
            fullName: currentUser.fullName,
            phoneNumber: currentUser.phoneNumber,
            phoneVerified: true,
            role: currentUser.role,
            universityId: currentUser.universityId,
          );
          
          // Update AuthManager with verified user
          AuthManager.updateUserData(LoginResponseModel(
            token: AuthManager.currentToken!,
            user: updatedUser,
          ));
        }
        
        emit(OtpVerifySuccess(
          otpCode: otpCode,
          phoneNumber: phoneNumber,
          hasAttemptedSubmit: true,
        ));
      },
    );
  }
}
