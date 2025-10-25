import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/utils/navigation_helper.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'empty_cart_illustration.dart';


class CartEmptyWidget extends StatelessWidget {
  const CartEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
}
