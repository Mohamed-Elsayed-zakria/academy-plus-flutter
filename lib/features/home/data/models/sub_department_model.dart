import 'package:equatable/equatable.dart';

class SubDepartmentModel extends Equatable {
  final String id;
  final String nameAr;
  final String nameEn;
  final String departmentId;
  final String logo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int coursesCount;

  const SubDepartmentModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.departmentId,
    required this.logo,
    required this.createdAt,
    required this.updatedAt,
    required this.coursesCount,
  });

  factory SubDepartmentModel.fromJson(Map<String, dynamic> json) {
    return SubDepartmentModel(
      id: json['id']?.toString() ?? '',
      nameAr: json['name_ar']?.toString() ?? '',
      nameEn: json['name_en']?.toString() ?? '',
      departmentId: json['department_id']?.toString() ?? '',
      logo: json['logo']?.toString() ?? '',
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? '') ?? DateTime.now(),
      coursesCount: json['courses_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
      'department_id': departmentId,
      'logo': logo,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'courses_count': coursesCount,
    };
  }

  SubDepartmentModel copyWith({
    String? id,
    String? nameAr,
    String? nameEn,
    String? departmentId,
    String? logo,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? coursesCount,
  }) {
    return SubDepartmentModel(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      departmentId: departmentId ?? this.departmentId,
      logo: logo ?? this.logo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      coursesCount: coursesCount ?? this.coursesCount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        nameAr,
        nameEn,
        departmentId,
        logo,
        createdAt,
        updatedAt,
        coursesCount,
      ];

  @override
  String toString() {
    return 'SubDepartmentModel(id: $id, nameAr: $nameAr, nameEn: $nameEn, departmentId: $departmentId, logo: $logo, createdAt: $createdAt, updatedAt: $updatedAt, coursesCount: $coursesCount)';
  }
}
