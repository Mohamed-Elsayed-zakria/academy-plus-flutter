import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';

class CartHeaderWidget extends StatelessWidget {
  final VoidCallback? onClearCart;
  final bool showClearButton;

  const CartHeaderWidget({
    super.key,
    this.onClearCart,
    this.showClearButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(AppLocalizations.cart),
      backgroundColor: AppColors.surface,
      elevation: 0,
      actions: [
        if (showClearButton)
          IconButton(
            icon: Icon(Icons.delete_outline, color: AppColors.error),
            onPressed: onClearCart,
          ),
      ],
    );
  }
}
