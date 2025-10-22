import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/navigation_helper.dart';

class LoginRegisterLinkWidget extends StatelessWidget {
  const LoginRegisterLinkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyLarge,
          children: [
            TextSpan(
              text: AppLocalizations.dontHaveAccount,
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
            WidgetSpan(
              child: GestureDetector(
                onTap: () => NavigationHelper.off(
                  path: '/register',
                  context: context,
                ),
                child: Text(
                  AppLocalizations.register,
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
