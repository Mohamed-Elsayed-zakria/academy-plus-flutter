class EditProfileModel {
  final String name;
  final String? profileImagePath;

  EditProfileModel({
    required this.name,
    this.profileImagePath,
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> json) {
    return EditProfileModel(
      name: json['name']?.toString() ?? '',
      profileImagePath: json['profileImagePath']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profileImagePath': profileImagePath,
    };
  }

  EditProfileModel copyWith({
    String? name,
    String? profileImagePath,
  }) {
    return EditProfileModel(
      name: name ?? this.name,
      profileImagePath: profileImagePath ?? this.profileImagePath,
    );
  }

  @override
  String toString() {
    return 'EditProfileModel(name: $name, profileImagePath: $profileImagePath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EditProfileModel &&
        other.name == name &&
        other.profileImagePath == profileImagePath;
  }

  @override
  int get hashCode {
    return name.hashCode ^ profileImagePath.hashCode;
  }
}
