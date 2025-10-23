import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_toast.dart';
import '../../../manager/otp_cubit/otp_cubit.dart';
import '../../../manager/otp_cubit/otp_state.dart';

class OtpButtonWidget extends StatelessWidget {
  final TextEditingController pinController;
  final String phoneNumber;
  
  const OtpButtonWidget({
    super.key,
    required this.pinController,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpCubit, OtpState>(
      builder: (context, state) {
        final isLoading = state is OtpVerifyLoading;
        final hasError = state is OtpVerifyError;
        
        return CustomButton(
          text: isLoading 
              ? AppLocalizations.verifying
              : hasError 
                  ? AppLocalizations.retry
                  : AppLocalizations.verify,
          onPressed: isLoading ? null : () {
            final otpCode = pinController.text.trim();
            
            if (otpCode.length == 6) {
              context.read<OtpCubit>().verifyOtp(phoneNumber, otpCode);
            } else {
              CustomToast.showError(
                context,
                message: AppLocalizations.pleaseEnterCompleteOtp,
              );
            }
          },
          isOutlined: true,
          width: double.infinity,
          icon: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                )
              : Icon(
                  hasError ? Ionicons.refresh_outline : Ionicons.checkmark_circle_outline,
                  color: AppColors.primary,
                  size: 20,
                ),
        );
      },
    );
  }
}
