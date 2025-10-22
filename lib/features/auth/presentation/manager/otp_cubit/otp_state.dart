abstract class OtpState {}

final class OtpInitial extends OtpState {
  final String otpCode;
  final String phoneNumber;
  final bool hasAttemptedSubmit;

  OtpInitial({
    this.otpCode = '',
    this.phoneNumber = '',
    this.hasAttemptedSubmit = false,
  });

  OtpInitial copyWith({
    String? otpCode,
    String? phoneNumber,
    bool? hasAttemptedSubmit,
  }) {
    return OtpInitial(
      otpCode: otpCode ?? this.otpCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      hasAttemptedSubmit: hasAttemptedSubmit ?? this.hasAttemptedSubmit,
    );
  }
}

// OTP Request States
final class OtpRequestLoading extends OtpState {
  final String otpCode;
  final String phoneNumber;
  final bool hasAttemptedSubmit;

  OtpRequestLoading({
    required this.otpCode,
    required this.phoneNumber,
    required this.hasAttemptedSubmit,
  });
}

final class OtpRequestSuccess extends OtpState {
  final String otpCode;
  final String phoneNumber;
  final bool hasAttemptedSubmit;

  OtpRequestSuccess({
    required this.otpCode,
    required this.phoneNumber,
    required this.hasAttemptedSubmit,
  });
}

final class OtpRequestError extends OtpState {
  final String error;
  final String otpCode;
  final String phoneNumber;
  final bool hasAttemptedSubmit;

  OtpRequestError({
    required this.error,
    required this.otpCode,
    required this.phoneNumber,
    required this.hasAttemptedSubmit,
  });
}

// OTP Verify States
final class OtpVerifyLoading extends OtpState {
  final String otpCode;
  final String phoneNumber;
  final bool hasAttemptedSubmit;

  OtpVerifyLoading({
    required this.otpCode,
    required this.phoneNumber,
    required this.hasAttemptedSubmit,
  });
}

final class OtpVerifySuccess extends OtpState {
  final String otpCode;
  final String phoneNumber;
  final bool hasAttemptedSubmit;

  OtpVerifySuccess({
    required this.otpCode,
    required this.phoneNumber,
    required this.hasAttemptedSubmit,
  });
}

final class OtpVerifyError extends OtpState {
  final String error;
  final String otpCode;
  final String phoneNumber;
  final bool hasAttemptedSubmit;

  OtpVerifyError({
    required this.error,
    required this.otpCode,
    required this.phoneNumber,
    required this.hasAttemptedSubmit,
  });
}
