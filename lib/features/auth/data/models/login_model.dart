class LoginModel {
  final String phoneNumber;
  final String password;

  LoginModel({
    required this.phoneNumber,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone_number': phoneNumber,
      'password': password,
    };
  }
}

class LoginResponseModel {
  final String token;
  final UserModel user;

  LoginResponseModel({
    required this.token,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['data']['token'],
      user: UserModel.fromJson(json['data']['user']),
    );
  }
}

class UserModel {
  final String id;
  final String fullName;
  final String phoneNumber;
  final bool phoneVerified;
  final String role;
  final String? universityId;

  UserModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.phoneVerified,
    required this.role,
    this.universityId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['full_name'],
      phoneNumber: json['phone_number'],
      phoneVerified: json['phone_verified'] ?? false,
      role: json['role'] ?? 'Student',
      universityId: json['university_id'],
    );
  }
}
