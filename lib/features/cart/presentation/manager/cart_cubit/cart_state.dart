import '../../../data/models/cart_item_model.dart';
import '../../../data/models/coupon_model.dart';

abstract class CartState {}

final class CartInitial extends CartState {
  final List<CartItemModel> cartItems;
  final bool isLoading;
  final bool isRefreshing;
  final String? errorMessage;
  final String? appliedCouponCode;
  final CouponModel? appliedCoupon;
  final bool isCouponApplied;
  final bool isValidatingCoupon;

  CartInitial({
    this.cartItems = const [],
    this.isLoading = true,
    this.isRefreshing = false,
    this.errorMessage,
    this.appliedCouponCode,
    this.appliedCoupon,
    this.isCouponApplied = false,
    this.isValidatingCoupon = false,
  });

  CartInitial copyWith({
    List<CartItemModel>? cartItems,
    bool? isLoading,
    bool? isRefreshing,
    String? errorMessage,
    String? appliedCouponCode,
    CouponModel? appliedCoupon,
    bool? isCouponApplied,
    bool? isValidatingCoupon,
  }) {
    return CartInitial(
      cartItems: cartItems ?? this.cartItems,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      errorMessage: errorMessage ?? this.errorMessage,
      appliedCouponCode: appliedCouponCode ?? this.appliedCouponCode,
      appliedCoupon: appliedCoupon ?? this.appliedCoupon,
      isCouponApplied: isCouponApplied ?? this.isCouponApplied,
      isValidatingCoupon: isValidatingCoupon ?? this.isValidatingCoupon,
    );
  }
}

final class CartLoading extends CartState {
  final List<CartItemModel> cartItems;
  final bool isRefreshing;
  final String? errorMessage;
  final String? appliedCouponCode;
  final CouponModel? appliedCoupon;
  final bool isCouponApplied;
  final bool isValidatingCoupon;

  CartLoading({
    required this.cartItems,
    this.isRefreshing = false,
    this.errorMessage,
    this.appliedCouponCode,
    this.appliedCoupon,
    this.isCouponApplied = false,
    this.isValidatingCoupon = false,
  });
}

final class CartLoaded extends CartState {
  final List<CartItemModel> cartItems;
  final bool isRefreshing;
  final String? errorMessage;
  final String? appliedCouponCode;
  final CouponModel? appliedCoupon;
  final bool isCouponApplied;
  final bool isValidatingCoupon;

  CartLoaded({
    required this.cartItems,
    this.isRefreshing = false,
    this.errorMessage,
    this.appliedCouponCode,
    this.appliedCoupon,
    this.isCouponApplied = false,
    this.isValidatingCoupon = false,
  });

  CartLoaded copyWith({
    List<CartItemModel>? cartItems,
    bool? isRefreshing,
    String? errorMessage,
    String? appliedCouponCode,
    CouponModel? appliedCoupon,
    bool? isCouponApplied,
    bool? isValidatingCoupon,
  }) {
    return CartLoaded(
      cartItems: cartItems ?? this.cartItems,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      errorMessage: errorMessage ?? this.errorMessage,
      appliedCouponCode: appliedCouponCode ?? this.appliedCouponCode,
      appliedCoupon: appliedCoupon ?? this.appliedCoupon,
      isCouponApplied: isCouponApplied ?? this.isCouponApplied,
      isValidatingCoupon: isValidatingCoupon ?? this.isValidatingCoupon,
    );
  }
}

final class CartError extends CartState {
  final String errorMessage;
  final List<CartItemModel> cartItems;
  final bool isRefreshing;
  final String? appliedCouponCode;
  final CouponModel? appliedCoupon;
  final bool isCouponApplied;
  final bool isValidatingCoupon;

  CartError({
    required this.errorMessage,
    this.cartItems = const [],
    this.isRefreshing = false,
    this.appliedCouponCode,
    this.appliedCoupon,
    this.isCouponApplied = false,
    this.isValidatingCoupon = false,
  });
}

final class CartEmpty extends CartState {
  final String? appliedCouponCode;
  final CouponModel? appliedCoupon;
  final bool isCouponApplied;
  final bool isValidatingCoupon;

  CartEmpty({
    this.appliedCouponCode,
    this.appliedCoupon,
    this.isCouponApplied = false,
    this.isValidatingCoupon = false,
  });
}

final class CouponValidating extends CartState {
  final List<CartItemModel> cartItems;
  final bool isRefreshing;
  final String? errorMessage;
  final String? appliedCouponCode;
  final CouponModel? appliedCoupon;
  final bool isCouponApplied;

  CouponValidating({
    required this.cartItems,
    this.isRefreshing = false,
    this.errorMessage,
    this.appliedCouponCode,
    this.appliedCoupon,
    this.isCouponApplied = false,
  });
}

final class CouponApplied extends CartState {
  final List<CartItemModel> cartItems;
  final bool isRefreshing;
  final String? errorMessage;
  final String appliedCouponCode;
  final CouponModel appliedCoupon;
  final bool isValidatingCoupon;

  CouponApplied({
    required this.cartItems,
    this.isRefreshing = false,
    this.errorMessage,
    required this.appliedCouponCode,
    required this.appliedCoupon,
    this.isValidatingCoupon = false,
  });
}

final class CouponRemoved extends CartState {
  final List<CartItemModel> cartItems;
  final bool isRefreshing;
  final String? errorMessage;
  final bool isValidatingCoupon;

  CouponRemoved({
    required this.cartItems,
    this.isRefreshing = false,
    this.errorMessage,
    this.isValidatingCoupon = false,
  });
}

// New states for handling success and error messages
final class CartItemRemovedSuccess extends CartState {
  final List<CartItemModel> cartItems;
  final String successMessage;
  final String? appliedCouponCode;
  final CouponModel? appliedCoupon;
  final bool isCouponApplied;

  CartItemRemovedSuccess({
    required this.cartItems,
    required this.successMessage,
    this.appliedCouponCode,
    this.appliedCoupon,
    this.isCouponApplied = false,
  });
}

final class CartClearedSuccess extends CartState {
  final String successMessage;
  final String? appliedCouponCode;
  final CouponModel? appliedCoupon;
  final bool isCouponApplied;

  CartClearedSuccess({
    required this.successMessage,
    this.appliedCouponCode,
    this.appliedCoupon,
    this.isCouponApplied = false,
  });
}

final class CouponValidationError extends CartState {
  final List<CartItemModel> cartItems;
  final String errorMessage;
  final String? appliedCouponCode;
  final CouponModel? appliedCoupon;
  final bool isCouponApplied;

  CouponValidationError({
    required this.cartItems,
    required this.errorMessage,
    this.appliedCouponCode,
    this.appliedCoupon,
    this.isCouponApplied = false,
  });
}

final class CouponAppliedSuccess extends CartState {
  final List<CartItemModel> cartItems;
  final String successMessage;
  final String appliedCouponCode;
  final CouponModel appliedCoupon;

  CouponAppliedSuccess({
    required this.cartItems,
    required this.successMessage,
    required this.appliedCouponCode,
    required this.appliedCoupon,
  });
}

final class CartOperationError extends CartState {
  final List<CartItemModel> cartItems;
  final String errorMessage;
  final String? appliedCouponCode;
  final CouponModel? appliedCoupon;
  final bool isCouponApplied;

  CartOperationError({
    required this.cartItems,
    required this.errorMessage,
    this.appliedCouponCode,
    this.appliedCoupon,
    this.isCouponApplied = false,
  });
}