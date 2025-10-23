import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/utils/navigation_helper.dart';
import '../../../../core/widgets/custom_toast.dart';
import '../../../../core/services/service_locator.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/repository/cart_repo.dart';
import 'widgets/empty_cart_illustration.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Cart data from API
  List<CartItemModel> cartItems = [];
  bool isLoading = true;
  bool isRefreshing = false;
  String? errorMessage;
  
  // Cart repository
  final CartRepo _cartRepo = SetupLocator.locator<CartRepo>();

  // Coupon code state
  final TextEditingController _couponController = TextEditingController();
  String? _appliedCouponCode;
  Map<String, dynamic>? _appliedCouponData;
  bool _isCouponApplied = false;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  // Load cart items from API
  Future<void> _loadCartItems() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final result = await _cartRepo.getCartItems();
    result.fold(
      (failure) {
        setState(() {
          isLoading = false;
          errorMessage = failure.errMessage;
        });
        CustomToast.showError(context, message: failure.errMessage);
      },
      (cartResponse) {
        setState(() {
          isLoading = false;
          cartItems = cartResponse.data;
        });
      },
    );
  }

  // Refresh cart items
  Future<void> _refreshCartItems() async {
    setState(() {
      isRefreshing = true;
    });

    await _loadCartItems();
    
    setState(() {
      isRefreshing = false;
    });
  }

  // Remove item from cart
  Future<void> _removeItemFromCart(String cartItemId) async {
    final result = await _cartRepo.removeItemFromCart(cartItemId);
    result.fold(
      (failure) {
        CustomToast.showError(context, message: failure.errMessage);
      },
      (response) {
        CustomToast.showSuccess(context, message: 'Item removed from cart');
        _loadCartItems(); // Reload cart items
      },
    );
  }

  // Clear entire cart
  Future<void> _clearCart() async {
    final result = await _cartRepo.clearCart();
    result.fold(
      (failure) {
        CustomToast.showError(context, message: failure.errMessage);
      },
      (response) {
        CustomToast.showSuccess(context, message: 'Cart cleared successfully');
        _loadCartItems(); // Reload cart items
      },
    );
  }

  // Mock coupon codes - replace with actual API call
  final Map<String, Map<String, dynamic>> _validCoupons = {
    'WELCOME10': {
      'name': AppLocalizations.welcomeCoupon,
      'type': 'percentage',
      'value': 10.0,
    },
    'STUDENT20': {
      'name': AppLocalizations.studentDiscount,
      'type': 'percentage',
      'value': 20.0,
    },
    'SAVE50': {
      'name': AppLocalizations.save50,
      'type': 'fixed',
      'value': 50.0,
    },
    'FIRST15': {
      'name': AppLocalizations.firstOrderDiscount,
      'type': 'percentage',
      'value': 15.0,
    },
    'NEWUSER': {
      'name': AppLocalizations.newUser,
      'type': 'fixed',
      'value': 25.0,
    },
  };

  void _applyCoupon() {
    final couponCode = _couponController.text.trim().toUpperCase();
    
    if (couponCode.isEmpty) {
      CustomToast.showError(
        context,
        message: AppLocalizations.pleaseEnterCoupon,
      );
      return;
    }

    if (_validCoupons.containsKey(couponCode)) {
      final couponData = _validCoupons[couponCode]!;
      setState(() {
        _appliedCouponCode = couponCode;
        _appliedCouponData = couponData;
        _isCouponApplied = true;
      });
      
      CustomToast.showSuccess(
        context,
        message: '${AppLocalizations.couponAppliedSuccess} "${couponData['name']}" (${couponData['type'] == 'percentage' ? '${couponData['value']}%' : '\$${couponData['value']}'})',
      );
    } else {
      CustomToast.showError(
        context,
        message: AppLocalizations.invalidCoupon,
      );
    }
  }

  void _removeCoupon() {
    setState(() {
      _appliedCouponCode = null;
      _appliedCouponData = null;
      _isCouponApplied = false;
      _couponController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalizations.cart),
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          if (cartItems.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete_outline, color: AppColors.error),
              onPressed: _showClearCartDialog,
            ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: cartItems.isNotEmpty && !isLoading ? Container(
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
          onPressed: _proceedToCheckout,
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
      ) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return _buildLoadingState();
    }
    
    if (errorMessage != null) {
      return _buildErrorState();
    }
    
    if (cartItems.isEmpty) {
      return _buildEmptyCart();
    }
    
    return _buildCartContent();
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading cart items...'),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading cart',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage ?? 'Something went wrong',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Retry',
              onPressed: _loadCartItems,
              isGradient: true,
              width: double.infinity,
              icon: Icon(Icons.refresh, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty cart illustration using the provided SVG
            EmptyCartIllustration(),
            const SizedBox(height: 32),
            
            // Empty cart title
            Text(
              AppLocalizations.emptyCartTitle,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            
            // Empty cart description
            Text(
              AppLocalizations.emptyCartDescription,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            
            // Browse courses button
            CustomButton(
              text: AppLocalizations.browseCourses,
              onPressed: () {
                NavigationHelper.back(context);
              },
              isGradient: true,
              width: double.infinity,
              icon: Icon(Icons.explore_outlined, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartContent() {
    return Column(
      children: [
        // Cart items list
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refreshCartItems,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return _buildCartItem(item, index);
              },
            ),
          ),
        ),
        
        // Coupon section
        _buildCouponSection(),
        
        // Total and checkout section
        _buildCheckoutSection(),
      ],
    );
  }

  Widget _buildCartItem(CartItemModel item, int index) {
    final discountedPrice = item.finalPrice;
    final originalPrice = item.price;
    final discountPercentage = item.discountPercentage;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Course image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: item.imageUrl != null ? Image.network(
                  item.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _getItemIcon(item.itemType),
                        color: Colors.white,
                        size: 32,
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceGrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      ),
                    );
                  },
                ) : Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getItemIcon(item.itemType),
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // Course details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Item title (Arabic)
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  
                  // Instructor/Type
                  Text(
                    item.instructor.isNotEmpty ? item.instructor : _getItemTypeLabel(item.itemType),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Price section
                  Row(
                    children: [
                      // Final price
                      Text(
                        '\$${discountedPrice.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      
                      // Original price (crossed out) - only show if there's a discount
                      if (discountPercentage > 0) ...[
                        Text(
                          '\$${originalPrice.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        
                        // Discount badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '-${discountPercentage.toStringAsFixed(0)}%',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.accent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            
            // Remove button
            IconButton(
              icon: Icon(
                Icons.delete_outline,
                color: AppColors.error,
                size: 20,
              ),
              onPressed: () => _removeItemFromCart(item.id),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.local_offer_outlined,
                color: AppColors.accent,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.couponCode,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          if (!_isCouponApplied) ...[
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: _couponController,
                    hintText: AppLocalizations.enterCouponCode,
                    textDirection: TextDirection.ltr,
                  ),
                ),
                const SizedBox(width: 8),
                CustomButton(
                  text: AppLocalizations.apply,
                  onPressed: _applyCoupon,
                  width: 100,
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
                      '${AppLocalizations.couponApplied}: ${_appliedCouponData?['name'] ?? _appliedCouponCode}',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _removeCoupon,
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
    );
  }

  Widget _buildCheckoutSection() {
    final originalTotal = cartItems.fold<double>(
      0,
      (sum, item) => sum + item.price,
    );
    final discountAmount = cartItems.fold<double>(
      0,
      (sum, item) => sum + item.discountAmount,
    );
    final subtotal = originalTotal - discountAmount;
    
    // Calculate coupon discount
    double couponDiscountAmount = 0.0;
    if (_isCouponApplied && _appliedCouponData != null) {
      final couponType = _appliedCouponData!['type'] as String;
      final couponValue = _appliedCouponData!['value'] as double;
      
      if (couponType == 'percentage') {
        // Percentage discount
        couponDiscountAmount = subtotal * (couponValue / 100);
      } else if (couponType == 'fixed') {
        // Fixed amount discount
        couponDiscountAmount = couponValue;
      }
    }
    
    final total = subtotal - couponDiscountAmount;

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
          if (_isCouponApplied) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${AppLocalizations.couponDiscountLabel} (${_appliedCouponData?['name'] ?? _appliedCouponCode})',
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
  }

  // Helper methods
  IconData _getItemIcon(String itemType) {
    switch (itemType) {
      case 'course':
        return Icons.book;
      case 'assignment':
        return Icons.assignment;
      case 'quiz':
        return Icons.quiz;
      default:
        return Icons.shopping_cart;
    }
  }

  String _getItemTypeLabel(String itemType) {
    switch (itemType) {
      case 'course':
        return 'Course';
      case 'assignment':
        return 'Assignment';
      case 'quiz':
        return 'Quiz';
      default:
        return 'Item';
    }
  }

  void _showClearCartDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(AppLocalizations.clearCartTitle),
        content: Text(AppLocalizations.clearCartMessage),
        actions: [
          TextButton(
            onPressed: () => NavigationHelper.back(context),
            child: Text(AppLocalizations.cancel),
          ),
          TextButton(
            onPressed: () {
              NavigationHelper.back(context);
              _clearCart();
            },
            child: Text(AppLocalizations.delete, style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  void _proceedToCheckout() {
    // Add haptic feedback
    HapticFeedback.lightImpact();
    
    // Navigate to checkout screen
    // You can add navigation logic here
  }
}