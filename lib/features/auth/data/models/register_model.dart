class RegisterModel {
  final String name;
  final String phone;
  final String password;
  final String universityId;
  RegisterModel({
    required this.name,
    required this.phone,
    required this.password,
    required this.universityId,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': name,
      'phone_number': phone,
      'password': password,
      'university_id': universityId,
    };
  }
}
