import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/utils/navigation_helper.dart';
import '../widgets/empty_cart_illustration.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Mock cart data - replace with actual cart state management
  List<Map<String, dynamic>> cartItems = [
    {
      'id': '1',
      'title': 'البرمجة المتقدمة',
      'titleEn': 'Advanced Programming',
      'instructor': 'Dr. Sarah Johnson',
      'price': 299.99,
      'discount': 20,
      'image': 'assets/images/course1.jpg',
      'quantity': 1,
    },
    {
      'id': '2',
      'title': 'تعلم الذكاء الاصطناعي',
      'titleEn': 'AI Learning',
      'instructor': 'Prof. Ahmed Ali',
      'price': 199.99,
      'discount': 15,
      'image': 'assets/images/course2.jpg',
      'quantity': 1,
    },
  ];

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
              onPressed: _clearCart,
            ),
        ],
      ),
      body: cartItems.isEmpty ? _buildEmptyCart() : _buildCartContent(),
      floatingActionButton: cartItems.isNotEmpty ? Container(
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
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return _buildCartItem(item, index);
            },
          ),
        ),
        
        // Total and checkout section
        _buildCheckoutSection(),
      ],
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item, int index) {
    final discountedPrice = item['price'] - (item['price'] * item['discount'] / 100);
    
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
            // Course image placeholder
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.play_circle_outline,
                color: Colors.white,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            
            // Course details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Course title (Arabic)
                  Text(
                    item['title'],
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  
                  // Instructor
                  Text(
                    item['instructor'],
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Price section
                  Row(
                    children: [
                      // Discounted price
                      Text(
                        '\$${discountedPrice.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      
                      // Original price (crossed out)
                      Text(
                        '\$${item['price'].toStringAsFixed(2)}',
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
                          '-${item['discount']}%',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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
              onPressed: () => _removeItem(index),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutSection() {
    final originalTotal = cartItems.fold<double>(
      0,
      (sum, item) => sum + item['price'],
    );
    final discountAmount = cartItems.fold<double>(
      0,
      (sum, item) => sum + (item['price'] * item['discount'] / 100),
    );
    final subtotal = originalTotal - discountAmount;
    // Tax removed - no tax calculation
    final total = subtotal; // Total equals subtotal without tax

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
          const SizedBox(height: 12),
          
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

  void _removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  void _clearCart() {
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
              setState(() {
                cartItems.clear();
              });
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
