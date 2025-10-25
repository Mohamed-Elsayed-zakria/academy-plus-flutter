import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/cart_item_model.dart';
import '../../../data/models/coupon_model.dart';
import '../../../data/repository/cart_repo.dart';
import '../../../data/repository/coupon_repo.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this._cartRepo, this._couponRepo) : super(CartInitial());
  
  final CartRepo _cartRepo;
  final CouponRepo _couponRepo;

  // Controllers
  final TextEditingController couponController = TextEditingController();

  @override
  Future<void> close() {
    couponController.dispose();
    return super.close();
  }

  // Load cart items
  Future<void> loadCartItems() async {
    emit(CartLoading(
      cartItems: getCurrentCartItems(),
      isRefreshing: state is CartLoaded && (state as CartLoaded).isRefreshing,
    ));

    final result = await _cartRepo.getCartItems();
    result.fold(
      (failure) {
        emit(CartError(
          errorMessage: failure.errMessage,
          cartItems: getCurrentCartItems(),
        ));
      },
      (cartResponse) {
        if (cartResponse.data.isEmpty) {
          emit(CartEmpty(
            appliedCouponCode: getCurrentCouponCode(),
            appliedCoupon: getCurrentCoupon(),
            isCouponApplied: getCurrentCouponApplied(),
          ));
        } else {
          emit(CartLoaded(
            cartItems: cartResponse.data,
            appliedCouponCode: getCurrentCouponCode(),
            appliedCoupon: getCurrentCoupon(),
            isCouponApplied: getCurrentCouponApplied(),
          ));
        }
      },
    );
  }

  // Refresh cart items
  Future<void> refreshCartItems() async {
    if (state is CartLoaded) {
      emit((state as CartLoaded).copyWith(isRefreshing: true));
    }
    await loadCartItems();
  }

  // Remove item from cart
  Future<void> removeItemFromCart(String cartItemId) async {
    final result = await _cartRepo.removeItemFromCart(cartItemId);
    result.fold(
      (failure) {
        emit(CartOperationError(
          cartItems: getCurrentCartItems(),
          errorMessage: failure.errMessage,
          appliedCouponCode: getCurrentCouponCode(),
          appliedCoupon: getCurrentCoupon(),
          isCouponApplied: getCurrentCouponApplied(),
        ));
      },
      (response) {
        emit(CartItemRemovedSuccess(
          cartItems: getCurrentCartItems(),
          successMessage: 'Item removed from cart',
          appliedCouponCode: getCurrentCouponCode(),
          appliedCoupon: getCurrentCoupon(),
          isCouponApplied: getCurrentCouponApplied(),
        ));
        loadCartItems(); // Reload cart items
      },
    );
  }

  // Clear entire cart
  Future<void> clearCart() async {
    final result = await _cartRepo.clearCart();
    result.fold(
      (failure) {
        emit(CartOperationError(
          cartItems: getCurrentCartItems(),
          errorMessage: failure.errMessage,
          appliedCouponCode: getCurrentCouponCode(),
          appliedCoupon: getCurrentCoupon(),
          isCouponApplied: getCurrentCouponApplied(),
        ));
      },
      (response) {
        emit(CartClearedSuccess(
          successMessage: 'Cart cleared successfully',
          appliedCouponCode: getCurrentCouponCode(),
          appliedCoupon: getCurrentCoupon(),
          isCouponApplied: getCurrentCouponApplied(),
        ));
        loadCartItems(); // Reload cart items
      },
    );
  }

  // Apply coupon
  Future<void> applyCoupon() async {
    final couponCode = couponController.text.trim().toUpperCase();
    
    if (couponCode.isEmpty) {
      emit(CouponValidationError(
        cartItems: getCurrentCartItems(),
        errorMessage: 'Please enter coupon code',
        appliedCouponCode: getCurrentCouponCode(),
        appliedCoupon: getCurrentCoupon(),
        isCouponApplied: getCurrentCouponApplied(),
      ));
      return;
    }

    emit(CouponValidating(
      cartItems: getCurrentCartItems(),
      appliedCouponCode: getCurrentCouponCode(),
      appliedCoupon: getCurrentCoupon(),
      isCouponApplied: getCurrentCouponApplied(),
    ));

    final result = await _couponRepo.validateCoupon(couponCode);
    result.fold(
      (failure) {
        emit(CouponValidationError(
          cartItems: getCurrentCartItems(),
          errorMessage: failure.errMessage,
          appliedCouponCode: getCurrentCouponCode(),
          appliedCoupon: getCurrentCoupon(),
          isCouponApplied: getCurrentCouponApplied(),
        ));
      },
      (validationResponse) {
        if (validationResponse.success && validationResponse.data?.valid == true) {
          final coupon = validationResponse.data!.coupon!;
          emit(CouponAppliedSuccess(
            cartItems: getCurrentCartItems(),
            successMessage: 'Coupon applied successfully "${coupon.code}" (${coupon.discountDisplayText})',
            appliedCouponCode: couponCode,
            appliedCoupon: coupon,
          ));
        } else {
          emit(CouponValidationError(
            cartItems: getCurrentCartItems(),
            errorMessage: validationResponse.message,
            appliedCouponCode: getCurrentCouponCode(),
            appliedCoupon: getCurrentCoupon(),
            isCouponApplied: getCurrentCouponApplied(),
          ));
        }
      },
    );
  }

  // Remove coupon
  void removeCoupon() {
    couponController.clear();
    emit(CouponRemoved(
      cartItems: getCurrentCartItems(),
    ));
  }

  // Helper methods to get current state values
  List<CartItemModel> getCurrentCartItems() {
    if (state is CartLoaded) {
      return (state as CartLoaded).cartItems;
    } else if (state is CartError) {
      return (state as CartError).cartItems;
    } else if (state is CouponValidating) {
      return (state as CouponValidating).cartItems;
    } else if (state is CouponApplied) {
      return (state as CouponApplied).cartItems;
    } else if (state is CouponRemoved) {
      return (state as CouponRemoved).cartItems;
    } else if (state is CartItemRemovedSuccess) {
      return (state as CartItemRemovedSuccess).cartItems;
    } else if (state is CartOperationError) {
      return (state as CartOperationError).cartItems;
    } else if (state is CouponValidationError) {
      return (state as CouponValidationError).cartItems;
    } else if (state is CouponAppliedSuccess) {
      return (state as CouponAppliedSuccess).cartItems;
    }
    return [];
  }

  String? getCurrentCouponCode() {
    if (state is CartLoaded) {
      return (state as CartLoaded).appliedCouponCode;
    } else if (state is CartError) {
      return (state as CartError).appliedCouponCode;
    } else if (state is CouponValidating) {
      return (state as CouponValidating).appliedCouponCode;
    } else if (state is CouponApplied) {
      return (state as CouponApplied).appliedCouponCode;
    } else if (state is CartEmpty) {
      return (state as CartEmpty).appliedCouponCode;
    } else if (state is CartItemRemovedSuccess) {
      return (state as CartItemRemovedSuccess).appliedCouponCode;
    } else if (state is CartClearedSuccess) {
      return (state as CartClearedSuccess).appliedCouponCode;
    } else if (state is CartOperationError) {
      return (state as CartOperationError).appliedCouponCode;
    } else if (state is CouponValidationError) {
      return (state as CouponValidationError).appliedCouponCode;
    } else if (state is CouponAppliedSuccess) {
      return (state as CouponAppliedSuccess).appliedCouponCode;
    }
    return null;
  }

  CouponModel? getCurrentCoupon() {
    if (state is CartLoaded) {
      return (state as CartLoaded).appliedCoupon;
    } else if (state is CartError) {
      return (state as CartError).appliedCoupon;
    } else if (state is CouponValidating) {
      return (state as CouponValidating).appliedCoupon;
    } else if (state is CouponApplied) {
      return (state as CouponApplied).appliedCoupon;
    } else if (state is CartEmpty) {
      return (state as CartEmpty).appliedCoupon;
    } else if (state is CartItemRemovedSuccess) {
      return (state as CartItemRemovedSuccess).appliedCoupon;
    } else if (state is CartClearedSuccess) {
      return (state as CartClearedSuccess).appliedCoupon;
    } else if (state is CartOperationError) {
      return (state as CartOperationError).appliedCoupon;
    } else if (state is CouponValidationError) {
      return (state as CouponValidationError).appliedCoupon;
    } else if (state is CouponAppliedSuccess) {
      return (state as CouponAppliedSuccess).appliedCoupon;
    }
    return null;
  }

  bool getCurrentCouponApplied() {
    if (state is CartLoaded) {
      return (state as CartLoaded).isCouponApplied;
    } else if (state is CartError) {
      return (state as CartError).isCouponApplied;
    } else if (state is CouponValidating) {
      return (state as CouponValidating).isCouponApplied;
    } else if (state is CouponApplied) {
      return true;
    } else if (state is CartEmpty) {
      return (state as CartEmpty).isCouponApplied;
    } else if (state is CartItemRemovedSuccess) {
      return (state as CartItemRemovedSuccess).isCouponApplied;
    } else if (state is CartClearedSuccess) {
      return (state as CartClearedSuccess).isCouponApplied;
    } else if (state is CartOperationError) {
      return (state as CartOperationError).isCouponApplied;
    } else if (state is CouponValidationError) {
      return (state as CouponValidationError).isCouponApplied;
    } else if (state is CouponAppliedSuccess) {
      return true;
    }
    return false;
  }


  // Calculate totals
  double get originalTotal {
    return getCurrentCartItems().fold<double>(
      0,
      (sum, item) => sum + item.price,
    );
  }

  double get discountAmount {
    return getCurrentCartItems().fold<double>(
      0,
      (sum, item) => sum + item.discountAmount,
    );
  }

  double get subtotal {
    return originalTotal - discountAmount;
  }

  double get couponDiscountAmount {
    final coupon = getCurrentCoupon();
    if (coupon != null) {
      if (coupon.isPercentage) {
        return subtotal * (coupon.discountValue / 100);
      } else if (coupon.isFixed) {
        return coupon.discountValue;
      }
    }
    return 0.0;
  }

  double get total {
    return subtotal - couponDiscountAmount;
  }
}
