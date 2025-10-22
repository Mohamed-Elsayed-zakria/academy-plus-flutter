import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/navigation_helper.dart';

class RegisterLoginLinkWidget extends StatelessWidget {
  const RegisterLoginLinkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyLarge,
          children: [
            TextSpan(
              text: AppLocalizations.alreadyHaveAccount,
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
            WidgetSpan(
              child: GestureDetector(
                onTap: () => NavigationHelper.off(
                  path: '/login',
                  context: context,
                ),
                child: Text(
                  AppLocalizations.login,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
