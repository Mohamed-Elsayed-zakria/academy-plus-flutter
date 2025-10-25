import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../data/models/coupon_model.dart';
import '../../manager/cart_cubit/cart_cubit.dart';
import '../../manager/cart_cubit/cart_state.dart';

class CartCouponSectionWidget extends StatefulWidget {
  const CartCouponSectionWidget({super.key});

  @override
  State<CartCouponSectionWidget> createState() => _CartCouponSectionWidgetState();
}

class _CartCouponSectionWidgetState extends State<CartCouponSectionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cartCubit = context.read<CartCubit>();
        final isValidatingCoupon = state is CouponValidating;
        
        // Auto-expand if coupon is applied or being validated
        if ((state is CouponApplied || state is CouponAppliedSuccess || state is CouponValidating) && !_isExpanded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _toggleExpansion();
          });
        }
        final isCouponApplied = state is CouponApplied || 
                               state is CouponAppliedSuccess ||
                               (state is CartLoaded && state.isCouponApplied) ||
                               (state is CartError && state.isCouponApplied) ||
                               (state is CartEmpty && state.isCouponApplied) ||
                               (state is CartItemRemovedSuccess && state.isCouponApplied) ||
                               (state is CartClearedSuccess && state.isCouponApplied) ||
                               (state is CartOperationError && state.isCouponApplied) ||
                               (state is CouponValidationError && state.isCouponApplied);
        
        CouponModel? appliedCoupon;
        String? appliedCouponCode;
        
        if (state is CouponApplied) {
          appliedCoupon = state.appliedCoupon;
          appliedCouponCode = state.appliedCouponCode;
        } else if (state is CouponAppliedSuccess) {
          appliedCoupon = state.appliedCoupon;
          appliedCouponCode = state.appliedCouponCode;
        } else if (state is CartLoaded) {
          appliedCoupon = state.appliedCoupon;
          appliedCouponCode = state.appliedCouponCode;
        } else if (state is CartError) {
          appliedCoupon = state.appliedCoupon;
          appliedCouponCode = state.appliedCouponCode;
        } else if (state is CartEmpty) {
          appliedCoupon = state.appliedCoupon;
          appliedCouponCode = state.appliedCouponCode;
        } else if (state is CartItemRemovedSuccess) {
          appliedCoupon = state.appliedCoupon;
          appliedCouponCode = state.appliedCouponCode;
        } else if (state is CartClearedSuccess) {
          appliedCoupon = state.appliedCoupon;
          appliedCouponCode = state.appliedCouponCode;
        } else if (state is CartOperationError) {
          appliedCoupon = state.appliedCoupon;
          appliedCouponCode = state.appliedCouponCode;
        } else if (state is CouponValidationError) {
          appliedCoupon = state.appliedCoupon;
          appliedCouponCode = state.appliedCouponCode;
        }

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.border,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              // Header with toggle button
              InkWell(
                onTap: _toggleExpansion,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_offer_outlined,
                        color: AppColors.accent,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          isCouponApplied 
                              ? '${AppLocalizations.couponCode} - ${appliedCoupon?.code ?? appliedCouponCode}'
                              : 'هل لديك كوبون خصم؟',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      AnimatedRotation(
                        turns: _isExpanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Expandable content
              SizeTransition(
                sizeFactor: _expandAnimation,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isCouponApplied) ...[
                        Row(
                          children: [
                            Expanded(
                              child: AbsorbPointer(
                                absorbing: isValidatingCoupon,
                                child: CustomTextField(
                                  controller: cartCubit.couponController,
                                  hintText: AppLocalizations.enterCouponCode,
                                  textDirection: TextDirection.ltr,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 100,
                              child: isValidatingCoupon
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Center(
                                        child: SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                                          ),
                                        ),
                                      ),
                                    )
                                  : CustomButton(
                                      text: AppLocalizations.apply,
                                      onPressed: () => cartCubit.applyCoupon(),
                                      width: 100,
                                    ),
                            ),
                          ],
                        ),
                      ] else ...[
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.accent,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: AppColors.accent,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '${AppLocalizations.couponApplied}: ${appliedCoupon?.code ?? appliedCouponCode} (${appliedCoupon?.discountDisplayText ?? ''})',
                                  style: TextStyle(
                                    color: AppColors.accent,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: cartCubit.removeCoupon,
                                child: Text(
                                  AppLocalizations.remove,
                                  style: TextStyle(
                                    color: AppColors.error,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
