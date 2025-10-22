class ResetPasswordModel {
  final String phoneNumber;
  final String otp;
  final String newPassword;

  ResetPasswordModel({
    required this.phoneNumber,
    required this.otp,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone_number': phoneNumber,
      'otp': otp,
      'new_password': newPassword,
    };
  }

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(
      phoneNumber: json['phone_number'] ?? '',
      otp: json['otp'] ?? '',
      newPassword: json['new_password'] ?? '',
    );
  }
}
