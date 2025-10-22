import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/server_failures.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../data/models/reset_password_model.dart';
import '../../../data/repository/otp_repo.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final OtpRepo _otpRepo;

  ResetPasswordCubit(this._otpRepo) : super(ResetPasswordInitial());

  // Update form fields
  void updatePassword(String password) {
    if (state is ResetPasswordInitial) {
      final currentState = state as ResetPasswordInitial;
      emit(currentState.copyWith(password: password));
    }
  }

  void updateConfirmPassword(String confirmPassword) {
    if (state is ResetPasswordInitial) {
      final currentState = state as ResetPasswordInitial;
      emit(currentState.copyWith(confirmPassword: confirmPassword));
    }
  }

  void setAttemptedSubmit(bool attempted) {
    if (state is ResetPasswordInitial) {
      final currentState = state as ResetPasswordInitial;
      emit(currentState.copyWith(hasAttemptedSubmit: attempted));
    }
  }

  // Validation methods
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.pleaseEnterNewPassword;
    }
    if (value.length < 6) {
      return AppLocalizations.passwordMustBeAtLeast6;
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.pleaseConfirmNewPassword;
    }
    if (value != password) {
      return AppLocalizations.passwordsDoNotMatch;
    }
    return null;
  }

  // Check if form is valid
  bool isFormValid() {
    if (state is ResetPasswordInitial) {
      final currentState = state as ResetPasswordInitial;
      return validatePassword(currentState.password) == null &&
          validateConfirmPassword(currentState.confirmPassword, currentState.password) == null;
    }
    return false;
  }

  Future<void> resetPassword(String phoneNumber, String otpCode) async {
    // Allow retry from ResetPasswordError state
    if (state is! ResetPasswordInitial && state is! ResetPasswordError) return;
    
    ResetPasswordInitial currentState;
    if (state is ResetPasswordInitial) {
      currentState = state as ResetPasswordInitial;
    } else {
      // If coming from ResetPasswordError, create new initial state
      final errorState = state as ResetPasswordError;
      currentState = ResetPasswordInitial(
        password: errorState.password,
        confirmPassword: errorState.confirmPassword,
        hasAttemptedSubmit: false,
      );
    }
    
    // Set attempted submit to true
    emit(currentState.copyWith(hasAttemptedSubmit: true));
    
    // Check if form is valid
    if (!isFormValid()) {
      return;
    }

    // Emit loading state
    emit(ResetPasswordLoading(
      password: currentState.password,
      confirmPassword: currentState.confirmPassword,
      hasAttemptedSubmit: true,
    ));

    // Reset password
    Either<Failures, void> result = await _otpRepo.resetPassword(
      ResetPasswordModel(
        phoneNumber: phoneNumber,
        otp: otpCode,
        newPassword: currentState.password,
      ),
    );

    result.fold(
      (failures) => emit(ResetPasswordError(
        error: failures.errMessage,
        password: currentState.password,
        confirmPassword: currentState.confirmPassword,
        hasAttemptedSubmit: true,
      )),
      (_) => emit(ResetPasswordSuccess(
        password: currentState.password,
        confirmPassword: currentState.confirmPassword,
        hasAttemptedSubmit: true,
      )),
    );
  }
}
