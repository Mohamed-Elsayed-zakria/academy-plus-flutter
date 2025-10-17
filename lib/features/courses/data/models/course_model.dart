import 'package:equatable/equatable.dart';

class CourseModel extends Equatable {
  final String id;
  final String titleAr;
  final String titleEn;
  final String instructorName;
  final double price;
  final double discountPrice;
  final String subDepartmentId;
  final String coverImage;
  final String introVideo;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SubDepartmentInfo? subDepartment;

  const CourseModel({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.instructorName,
    required this.price,
    required this.discountPrice,
    required this.subDepartmentId,
    required this.coverImage,
    required this.introVideo,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    this.subDepartment,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id']?.toString() ?? '',
      titleAr: json['title_ar']?.toString() ?? '',
      titleEn: json['title_en']?.toString() ?? '',
      instructorName: json['instructor_name']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPrice: (json['discount_price'] as num?)?.toDouble() ?? 0.0,
      subDepartmentId: json['sub_department_id']?.toString() ?? '',
      coverImage: json['cover_image']?.toString() ?? '',
      introVideo: json['intro_video']?.toString() ?? '',
      description: json['description']?.toString(),
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? '') ?? DateTime.now(),
      subDepartment: json['sub_departments'] != null
          ? SubDepartmentInfo.fromJson(json['sub_departments'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title_ar': titleAr,
      'title_en': titleEn,
      'instructor_name': instructorName,
      'price': price,
      'discount_price': discountPrice,
      'sub_department_id': subDepartmentId,
      'cover_image': coverImage,
      'intro_video': introVideo,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'sub_departments': subDepartment?.toJson(),
    };
  }

  CourseModel copyWith({
    String? id,
    String? titleAr,
    String? titleEn,
    String? instructorName,
    double? price,
    double? discountPrice,
    String? subDepartmentId,
    String? coverImage,
    String? introVideo,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    SubDepartmentInfo? subDepartment,
  }) {
    return CourseModel(
      id: id ?? this.id,
      titleAr: titleAr ?? this.titleAr,
      titleEn: titleEn ?? this.titleEn,
      instructorName: instructorName ?? this.instructorName,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      subDepartmentId: subDepartmentId ?? this.subDepartmentId,
      coverImage: coverImage ?? this.coverImage,
      introVideo: introVideo ?? this.introVideo,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      subDepartment: subDepartment ?? this.subDepartment,
    );
  }

  @override
  List<Object?> get props => [
        id,
        titleAr,
        titleEn,
        instructorName,
        price,
        discountPrice,
        subDepartmentId,
        coverImage,
        introVideo,
        description,
        createdAt,
        updatedAt,
        subDepartment,
      ];

  @override
  String toString() {
    return 'CourseModel(id: $id, titleAr: $titleAr, titleEn: $titleEn, instructorName: $instructorName, price: $price, discountPrice: $discountPrice, subDepartmentId: $subDepartmentId, coverImage: $coverImage, introVideo: $introVideo, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, subDepartment: $subDepartment)';
  }
}

class SubDepartmentInfo extends Equatable {
  final String id;
  final String logo;
  final String nameAr;
  final String nameEn;
  final DepartmentInfo? department;

  const SubDepartmentInfo({
    required this.id,
    required this.logo,
    required this.nameAr,
    required this.nameEn,
    this.department,
  });

  factory SubDepartmentInfo.fromJson(Map<String, dynamic> json) {
    return SubDepartmentInfo(
      id: json['id']?.toString() ?? '',
      logo: json['logo']?.toString() ?? '',
      nameAr: json['name_ar']?.toString() ?? '',
      nameEn: json['name_en']?.toString() ?? '',
      department: json['departments'] != null
          ? DepartmentInfo.fromJson(json['departments'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo': logo,
      'name_ar': nameAr,
      'name_en': nameEn,
      'departments': department?.toJson(),
    };
  }

  @override
  List<Object?> get props => [id, logo, nameAr, nameEn, department];
}

class DepartmentInfo extends Equatable {
  final String id;
  final String logo;
  final String nameAr;
  final String nameEn;
  final UniversityInfo? university;
  final String universityId;

  const DepartmentInfo({
    required this.id,
    required this.logo,
    required this.nameAr,
    required this.nameEn,
    this.university,
    required this.universityId,
  });

  factory DepartmentInfo.fromJson(Map<String, dynamic> json) {
    return DepartmentInfo(
      id: json['id']?.toString() ?? '',
      logo: json['logo']?.toString() ?? '',
      nameAr: json['name_ar']?.toString() ?? '',
      nameEn: json['name_en']?.toString() ?? '',
      university: json['universities'] != null
          ? UniversityInfo.fromJson(json['universities'])
          : null,
      universityId: json['university_id']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo': logo,
      'name_ar': nameAr,
      'name_en': nameEn,
      'universities': university?.toJson(),
      'university_id': universityId,
    };
  }

  @override
  List<Object?> get props => [id, logo, nameAr, nameEn, university, universityId];
}

class UniversityInfo extends Equatable {
  final String id;
  final String logo;
  final String nameAr;
  final String nameEn;

  const UniversityInfo({
    required this.id,
    required this.logo,
    required this.nameAr,
    required this.nameEn,
  });

  factory UniversityInfo.fromJson(Map<String, dynamic> json) {
    return UniversityInfo(
      id: json['id']?.toString() ?? '',
      logo: json['logo']?.toString() ?? '',
      nameAr: json['name_ar']?.toString() ?? '',
      nameEn: json['name_en']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo': logo,
      'name_ar': nameAr,
      'name_en': nameEn,
    };
  }

  @override
  List<Object?> get props => [id, logo, nameAr, nameEn];
}
