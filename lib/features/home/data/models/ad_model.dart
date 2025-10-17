import 'package:equatable/equatable.dart';

class AdModel extends Equatable {
  final String id;
  final String universityId;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AdModel({
    required this.id,
    required this.universityId,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: json['id']?.toString() ?? '',
      universityId: json['university_id']?.toString() ?? '',
      imageUrl: json['image_url']?.toString() ?? '',
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'university_id': universityId,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  AdModel copyWith({
    String? id,
    String? universityId,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AdModel(
      id: id ?? this.id,
      universityId: universityId ?? this.universityId,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        universityId,
        imageUrl,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() {
    return 'AdModel(id: $id, universityId: $universityId, imageUrl: $imageUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
