import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/localization/app_localizations.dart';

class ResetPasswordPhoneDisplayWidget extends StatelessWidget {
  final String phoneNumber;
  
  const ResetPasswordPhoneDisplayWidget({
    super.key,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.success.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Ionicons.checkmark_circle_outline,
            color: AppColors.success,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              AppLocalizations.otpVerifiedFor.replaceAll('{phone}', phoneNumber),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
