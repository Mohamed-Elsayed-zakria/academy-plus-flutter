import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/server_failures.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../data/models/forgot_password_model.dart';
import '../../../data/repository/otp_repo.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final OtpRepo _otpRepo;

  ForgotPasswordCubit(this._otpRepo) : super(ForgotPasswordInitial());

  // Update form fields
  void updatePhone(String phone) {
    if (state is ForgotPasswordInitial) {
      final currentState = state as ForgotPasswordInitial;
      emit(currentState.copyWith(phone: phone));
    }
  }

  void updateDialCode(String dialCode) {
    if (state is ForgotPasswordInitial) {
      final currentState = state as ForgotPasswordInitial;
      emit(currentState.copyWith(selectedDialCode: dialCode));
    }
  }

  void setAttemptedSubmit(bool attempted) {
    if (state is ForgotPasswordInitial) {
      final currentState = state as ForgotPasswordInitial;
      emit(currentState.copyWith(hasAttemptedSubmit: attempted));
    }
  }

  // Validation methods
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.pleaseEnterPhone;
    }
    if (value.length < 10) {
      return AppLocalizations.pleaseEnterValidPhone;
    }
    return null;
  }

  // Check if form is valid
  bool isFormValid() {
    if (state is ForgotPasswordInitial) {
      final currentState = state as ForgotPasswordInitial;
      return validatePhone(currentState.phone) == null;
    }
    return false;
  }

  Future<void> sendOtp() async {
    if (state is! ForgotPasswordInitial) return;
    
    final currentState = state as ForgotPasswordInitial;
    
    // Set attempted submit to true
    emit(currentState.copyWith(hasAttemptedSubmit: true));
    
    // Check if form is valid
    if (!isFormValid()) {
      return;
    }

    // Emit loading state
    emit(ForgotPasswordLoading(
      phone: currentState.phone,
      selectedDialCode: currentState.selectedDialCode,
      hasAttemptedSubmit: true,
    ));

    // Prepare phone number with country code
    final fullPhoneNumber = '${currentState.selectedDialCode}${currentState.phone}';

    // Request password reset OTP
    Either<Failures, void> result = await _otpRepo.forgotPassword(
      ForgotPasswordModel(phoneNumber: fullPhoneNumber),
    );

    result.fold(
      (failures) => emit(ForgotPasswordError(
        error: failures.errMessage,
        phone: currentState.phone,
        selectedDialCode: currentState.selectedDialCode,
        hasAttemptedSubmit: true,
      )),
      (_) => emit(ForgotPasswordSuccess(
        phone: currentState.phone,
        selectedDialCode: currentState.selectedDialCode,
        hasAttemptedSubmit: true,
      )),
    );
  }
}
