import 'dart:io';

class RegisterModel {
  final String name;
  final String phone;
  final String password;
  final String universityId;
  final File? profileImage;

  RegisterModel({
    required this.name,
    required this.phone,
    required this.password,
    required this.universityId,
    this.profileImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': name,
      'phone_number': phone,
      'password': password,
      'university_id': universityId,
    };
  }

  Map<String, dynamic> toFormData() {
    final Map<String, dynamic> formData = {
      'full_name': name,
      'phone_number': phone,
      'password': password,
      'university_id': universityId,
    };
    
    if (profileImage != null) {
      formData['profile_image'] = profileImage!;
    }
    
    return formData;
  }
}
