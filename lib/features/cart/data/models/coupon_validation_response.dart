import 'coupon_model.dart';

class CouponValidationResponse {
  final bool success;
  final String message;
  final CouponValidationData? data;

  CouponValidationResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory CouponValidationResponse.fromJson(Map<String, dynamic> json) {
    return CouponValidationResponse(
      success: json['success'] ?? false,
      message: json['message'] is String 
          ? json['message'] 
          : (json['message']?['nameEn'] ?? 'Unknown error'),
      data: json['data'] != null ? CouponValidationData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class CouponValidationData {
  final bool valid;
  final CouponModel? coupon;

  CouponValidationData({
    required this.valid,
    this.coupon,
  });

  factory CouponValidationData.fromJson(Map<String, dynamic> json) {
    return CouponValidationData(
      valid: json['valid'] ?? false,
      coupon: json['coupon'] != null ? CouponModel.fromJson(json['coupon']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'valid': valid,
      'coupon': coupon?.toJson(),
    };
  }
}
