import 'dart:io';

class UpdateProfileModel {
  final String? fullName;
  final File? profileImage;

  UpdateProfileModel({
    this.fullName,
    this.profileImage,
  });

  Map<String, dynamic> toJson() {
    return {
      if (fullName != null) 'full_name': fullName,
    };
  }

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileModel(
      fullName: json['full_name'],
    );
  }
}
