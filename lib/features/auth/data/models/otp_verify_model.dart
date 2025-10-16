class OtpVerifyModel {
  final String phoneNumber;
  final String otpCode;

  OtpVerifyModel({
    required this.phoneNumber,
    required this.otpCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone_number': phoneNumber,
      'otp': otpCode,
    };
  }
}
