import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../data/models/coupon_model.dart';
import '../../manager/cart_cubit/cart_cubit.dart';
import '../../manager/cart_cubit/cart_state.dart';

class CartCheckoutSectionWidget extends StatelessWidget {
  const CartCheckoutSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cartCubit = context.read<CartCubit>();
        
        final originalTotal = cartCubit.originalTotal;
        final discountAmount = cartCubit.discountAmount;
        final subtotal = cartCubit.subtotal;
        final couponDiscountAmount = cartCubit.couponDiscountAmount;
        final total = cartCubit.total;

        // Get coupon info
        CouponModel? appliedCoupon;
        
        if (state is CouponApplied) {
          appliedCoupon = state.appliedCoupon;
        } else if (state is CouponAppliedSuccess) {
          appliedCoupon = state.appliedCoupon;
        } else if (state is CartLoaded) {
          appliedCoupon = state.appliedCoupon;
        } else if (state is CartError) {
          appliedCoupon = state.appliedCoupon;
        } else if (state is CartEmpty) {
          appliedCoupon = state.appliedCoupon;
        } else if (state is CartItemRemovedSuccess) {
          appliedCoupon = state.appliedCoupon;
        } else if (state is CartClearedSuccess) {
          appliedCoupon = state.appliedCoupon;
        } else if (state is CartOperationError) {
          appliedCoupon = state.appliedCoupon;
        } else if (state is CouponValidationError) {
          appliedCoupon = state.appliedCoupon;
        }

        final isCouponApplied = appliedCoupon != null;

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Price breakdown
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.originalTotal,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    '\$${originalTotal.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.discountAmount,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.accent,
                    ),
                  ),
                  Text(
                    '-\$${discountAmount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.subtotal,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    '\$${subtotal.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              
              // Coupon discount row (only show if coupon is applied)
              if (isCouponApplied) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${AppLocalizations.couponDiscountLabel} (${appliedCoupon.code})',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.accent,
                      ),
                    ),
                    Text(
                      '-\$${couponDiscountAmount.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
              
              Divider(color: AppColors.border),
              const SizedBox(height: 12),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.total,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80), // Extra space for FloatingActionButton
            ],
          ),
        );
      },
    );
  }
}
