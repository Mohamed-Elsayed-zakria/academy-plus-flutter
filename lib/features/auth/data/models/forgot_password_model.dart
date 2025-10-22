class ForgotPasswordModel {
  final String phoneNumber;

  ForgotPasswordModel({
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone_number': phoneNumber,
    };
  }

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordModel(
      phoneNumber: json['phone_number'] ?? '',
    );
  }
}
