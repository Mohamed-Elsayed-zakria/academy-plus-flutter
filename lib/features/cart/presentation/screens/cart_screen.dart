import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/navigation_helper.dart';
import '../../../../core/widgets/custom_toast.dart';
import '../manager/cart_cubit/cart_cubit.dart';
import '../manager/cart_cubit/cart_state.dart';
import 'widgets/cart_screen_widgets.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SetupLocator.locator<CartCubit>()..loadCartItems(),
      child: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          // Handle success and error messages
          if (state is CartItemRemovedSuccess) {
            CustomToast.showSuccess(context, message: state.successMessage);
          } else if (state is CartClearedSuccess) {
            CustomToast.showSuccess(context, message: state.successMessage);
          } else if (state is CouponAppliedSuccess) {
            CustomToast.showSuccess(context, message: state.successMessage);
          } else if (state is CartOperationError) {
            CustomToast.showError(context, message: state.errorMessage);
          } else if (state is CouponValidationError) {
            CustomToast.showError(context, message: state.errorMessage);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                final cartCubit = context.read<CartCubit>();
                final cartItems = cartCubit.getCurrentCartItems();
                
                return CartHeaderWidget(
                  showClearButton: cartItems.isNotEmpty,
                  onClearCart: () => _showClearCartDialog(context, cartCubit),
                );
              },
            ),
          ),
          body: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              final cartCubit = context.read<CartCubit>();
              
              if (state is CartLoading) {
                return const CartLoadingWidget();
              }
              
              if (state is CartError) {
                return CartErrorWidget(
                  errorMessage: state.errorMessage,
                  onRetry: () => cartCubit.loadCartItems(),
                );
              }
              
              if (state is CartEmpty) {
                return const CartEmptyWidget();
              }
              
              if (state is CartLoaded || state is CouponApplied || state is CouponRemoved || state is CouponValidating || state is CouponAppliedSuccess || state is CouponValidationError || state is CartItemRemovedSuccess || state is CartClearedSuccess || state is CartOperationError) {
                final cartItems = cartCubit.getCurrentCartItems();
                
                return Column(
                  children: [
                    // Cart items list
                    Expanded(
                      child: CartItemsListWidget(
                        cartItems: cartItems,
                        onRefresh: () => cartCubit.refreshCartItems(),
                        onRemoveItem: (cartItemId) => cartCubit.removeItemFromCart(cartItemId),
                      ),
                    ),
                    
                    // Coupon section
                    const CartCouponSectionWidget(),
                    
                    // Total and checkout section
                    const CartCheckoutSectionWidget(),
                  ],
                );
              }
              
              // Default fallback
              return const CartLoadingWidget();
            },
          ),
          floatingActionButton: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return const CartFloatingButtonWidget();
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

  void _showClearCartDialog(BuildContext context, CartCubit cartCubit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Clear Cart'),
        content: Text('Are you sure you want to clear all items from your cart?'),
        actions: [
          TextButton(
            onPressed: () => NavigationHelper.back(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              NavigationHelper.back(context);
              cartCubit.clearCart();
            },
            child: Text('Clear', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}