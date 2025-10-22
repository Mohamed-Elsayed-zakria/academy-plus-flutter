import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/navigation_helper.dart';

class ResetPasswordDividerWidget extends StatelessWidget {
  const ResetPasswordDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Divider
        Row(
          children: [
            Expanded(
              child: Divider(
                color: AppColors.textTertiary.withValues(alpha: 0.3),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                AppLocalizations.or,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textTertiary,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            Expanded(
              child: Divider(
                color: AppColors.textTertiary.withValues(alpha: 0.3),
              ),
            ),
          ],
        ),

        const SizedBox(height: 32),

        // Back to Login Link
        Center(
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge,
              children: [
                TextSpan(
                  text: AppLocalizations.rememberPassword,
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                      NavigationHelper.off(
                        path: '/login',
                        context: context,
                      );
                    },
                    child: Text(
                      AppLocalizations.backToLogin,
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
        ),
      ],
    );
  }
}
