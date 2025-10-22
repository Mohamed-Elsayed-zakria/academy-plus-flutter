import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/localization/app_localizations.dart';

class OtpHeaderWidget extends StatelessWidget {
  final String phoneNumber;
  
  const OtpHeaderWidget({
    super.key,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: SvgPicture.asset(
              'assets/images/Enter OTP-amico.svg',
              width: 240,
              height: 240,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.verifyOtp,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.enterOtp,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primaryLight.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Text(
              AppLocalizations.phoneNumberDisplay.replaceAll('{phone}', phoneNumber),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
