class CouponModel {
  final String id;
  final String code;
  final double discountValue;
  final int maxUses;
  final int usedCount;
  final String createdAt;
  final String updatedAt;
  final String discountType;
  final int usagePerUser;
  final int cooldownHours;
  final bool allowMultipleUsage;

  CouponModel({
    required this.id,
    required this.code,
    required this.discountValue,
    required this.maxUses,
    required this.usedCount,
    required this.createdAt,
    required this.updatedAt,
    required this.discountType,
    required this.usagePerUser,
    required this.cooldownHours,
    required this.allowMultipleUsage,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      discountValue: (json['discount_value'] ?? 0).toDouble(),
      maxUses: json['max_uses'] ?? 0,
      usedCount: json['used_count'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      discountType: json['discount_type'] ?? 'percentage',
      usagePerUser: json['usage_per_user'] ?? 1,
      cooldownHours: json['cooldown_hours'] ?? 0,
      allowMultipleUsage: json['allow_multiple_usage'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'discount_value': discountValue,
      'max_uses': maxUses,
      'used_count': usedCount,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'discount_type': discountType,
      'usage_per_user': usagePerUser,
      'cooldown_hours': cooldownHours,
      'allow_multiple_usage': allowMultipleUsage,
    };
  }

  // Helper methods
  bool get isPercentage => discountType == 'percentage';
  bool get isFixed => discountType == 'fixed';
  
  String get discountDisplayText {
    if (isPercentage) {
      return '${discountValue.toStringAsFixed(0)}%';
    } else {
      return '\$${discountValue.toStringAsFixed(2)}';
    }
  }

  bool get isAvailable => usedCount < maxUses;
}
