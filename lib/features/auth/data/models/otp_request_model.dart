class OtpRequestModel {
  final String phoneNumber;

  OtpRequestModel({
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone_number': phoneNumber,
    };
  }
}
