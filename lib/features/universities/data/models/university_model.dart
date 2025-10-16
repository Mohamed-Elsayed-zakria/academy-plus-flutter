class UniversityModel {
  final String id;
  final String nameAr;
  final String nameEn;
  final String? logo;

  UniversityModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    this.logo,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      id: json['id'].toString(),
      nameAr: json['name_ar'] ?? '',
      nameEn: json['name_en'] ?? '',
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
      'logo': logo,
    };
  }

  @override
  String toString() {
    return 'UniversityModel(id: $id, nameAr: $nameAr, nameEn: $nameEn, logo: $logo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UniversityModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
