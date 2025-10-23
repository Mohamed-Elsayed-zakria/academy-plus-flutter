import 'cart_item_model.dart';

class CartResponseModel {
  final bool success;
  final String message;
  final List<CartItemModel> data;

  CartResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    return CartResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => CartItemModel.fromJson(item))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class CartSummaryModel {
  final bool success;
  final String message;
  final CartSummaryData data;

  CartSummaryModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CartSummaryModel.fromJson(Map<String, dynamic> json) {
    return CartSummaryModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: CartSummaryData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class CartSummaryData {
  final List<CartItemModel> items;
  final double total;
  final double discountTotal;
  final double savings;
  final int itemCount;

  CartSummaryData({
    required this.items,
    required this.total,
    required this.discountTotal,
    required this.savings,
    required this.itemCount,
  });

  factory CartSummaryData.fromJson(Map<String, dynamic> json) {
    return CartSummaryData(
      items: (json['items'] as List<dynamic>?)
          ?.map((item) => CartItemModel.fromJson(item))
          .toList() ?? [],
      total: (json['total'] ?? 0).toDouble(),
      discountTotal: (json['discount_total'] ?? 0).toDouble(),
      savings: (json['savings'] ?? 0).toDouble(),
      itemCount: json['item_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'total': total,
      'discount_total': discountTotal,
      'savings': savings,
      'item_count': itemCount,
    };
  }
}
