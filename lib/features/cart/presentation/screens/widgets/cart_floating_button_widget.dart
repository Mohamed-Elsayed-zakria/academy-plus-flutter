import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../manager/cart_cubit/cart_cubit.dart';
import '../../manager/cart_cubit/cart_state.dart';

class CartFloatingButtonWidget extends StatelessWidget {
  const CartFloatingButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cartCubit = context.read<CartCubit>();
        final cartItems = cartCubit.getCurrentCartItems();
        final isLoading = state is CartLoading;
        
        if (cartItems.isEmpty || isLoading) {
          return const SizedBox.shrink();
        }

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: FloatingActionButton.extended(
            onPressed: () => _proceedToCheckout(context),
            backgroundColor: AppColors.primary,
            icon: Icon(
              Icons.payment,
              color: Colors.white,
              size: 24,
            ),
            label: Text(
              AppLocalizations.proceedToCheckout,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  }

  void _proceedToCheckout(BuildContext context) {
    // Add haptic feedback
    HapticFeedback.lightImpact();
    
    // Navigate to checkout screen
    // You can add navigation logic here
  }
}
