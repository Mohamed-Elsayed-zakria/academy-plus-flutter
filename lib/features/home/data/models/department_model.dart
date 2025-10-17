import 'package:equatable/equatable.dart';

class UniversityModel extends Equatable {
  final String id;
  final String logo;
  final String nameAr;
  final String nameEn;

  const UniversityModel({
    required this.id,
    required this.logo,
    required this.nameAr,
    required this.nameEn,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
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

class DepartmentModel extends Equatable {
  final String id;
  final String nameAr;
  final String nameEn;
  final String universityId;
  final String logo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UniversityModel university;
  final int subDepartmentsCount;

  const DepartmentModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.universityId,
    required this.logo,
    required this.createdAt,
    required this.updatedAt,
    required this.university,
    required this.subDepartmentsCount,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id']?.toString() ?? '',
      nameAr: json['name_ar']?.toString() ?? '',
      nameEn: json['name_en']?.toString() ?? '',
      universityId: json['university_id']?.toString() ?? '',
      logo: json['logo']?.toString() ?? '',
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? '') ?? DateTime.now(),
      university: UniversityModel.fromJson(json['universities'] ?? {}),
      subDepartmentsCount: json['sub_departments_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
      'university_id': universityId,
      'logo': logo,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'universities': university.toJson(),
      'sub_departments_count': subDepartmentsCount,
    };
  }

  DepartmentModel copyWith({
    String? id,
    String? nameAr,
    String? nameEn,
    String? universityId,
    String? logo,
    DateTime? createdAt,
    DateTime? updatedAt,
    UniversityModel? university,
    int? subDepartmentsCount,
  }) {
    return DepartmentModel(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      universityId: universityId ?? this.universityId,
      logo: logo ?? this.logo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      university: university ?? this.university,
      subDepartmentsCount: subDepartmentsCount ?? this.subDepartmentsCount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        nameAr,
        nameEn,
        universityId,
        logo,
        createdAt,
        updatedAt,
        university,
        subDepartmentsCount,
      ];

  @override
  String toString() {
    return 'DepartmentModel(id: $id, nameAr: $nameAr, nameEn: $nameEn, universityId: $universityId, logo: $logo, createdAt: $createdAt, updatedAt: $updatedAt, university: $university, subDepartmentsCount: $subDepartmentsCount)';
  }
}
