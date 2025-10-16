class UserProfileModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String studentId;
  final String university;
  final String? profileImageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.studentId,
    required this.university,
    this.profileImageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    // Extract university name from nested universities object
    String universityName = '';
    if (json['universities'] != null) {
      final universities = json['universities'];
      universityName = universities['name_ar']?.toString() ?? 
                     universities['name_en']?.toString() ?? 
                     universities['name']?.toString() ?? '';
    }
    
    return UserProfileModel(
      id: json['id']?.toString() ?? '',
      name: json['full_name']?.toString() ?? json['name']?.toString() ?? 'غير متوفر',
      email: json['email']?.toString() ?? 'غير متوفر', // Default value if not available
      phone: json['phone_number']?.toString() ?? json['phone']?.toString() ?? 'غير متوفر',
      studentId: json['student_id']?.toString() ?? json['studentId']?.toString() ?? json['id']?.toString() ?? 'غير متوفر', // Use ID as fallback
      university: universityName.isNotEmpty ? universityName : 'غير متوفر',
      profileImageUrl: json['profile_image']?.toString() ?? json['profile_image_url']?.toString(),
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at'].toString()) : null,
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': name,
      'email': email,
      'phone_number': phone,
      'student_id': studentId,
      'university': university,
      'profile_image_url': profileImageUrl,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  UserProfileModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? studentId,
    String? university,
    String? profileImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      studentId: studentId ?? this.studentId,
      university: university ?? this.university,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'UserProfileModel(id: $id, name: $name, email: $email, phone: $phone, studentId: $studentId, university: $university, profileImageUrl: $profileImageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserProfileModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.studentId == studentId &&
        other.university == university &&
        other.profileImageUrl == profileImageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        studentId.hashCode ^
        university.hashCode ^
        profileImageUrl.hashCode;
  }
}
