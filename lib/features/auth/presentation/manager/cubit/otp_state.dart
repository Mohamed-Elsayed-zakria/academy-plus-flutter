abstract class OtpState {}

final class OtpInitial extends OtpState {}

// OTP Request States
final class OtpRequestLoading extends OtpState {}
final class OtpRequestSuccess extends OtpState {}
final class OtpRequestError extends OtpState {
  final String error;
  OtpRequestError({required this.error});
}

// OTP Verify States
final class OtpVerifyLoading extends OtpState {}
final class OtpVerifySuccess extends OtpState {}
final class OtpVerifyError extends OtpState {
  final String error;
  OtpVerifyError({required this.error});
}
