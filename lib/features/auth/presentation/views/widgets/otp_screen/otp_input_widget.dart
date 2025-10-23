import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/widgets/custom_toast.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../manager/otp_cubit/otp_cubit.dart';

class OtpInputWidget extends StatelessWidget {
  final TextEditingController pinController;
  final FocusNode focusNode;
  final String phoneNumber;
  
  const OtpInputWidget({
    super.key,
    required this.pinController,
    required this.focusNode,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Pinput(
          controller: pinController,
          focusNode: focusNode,
          length: 6,
          defaultPinTheme: PinTheme(
            width: 60,
            height: 60,
            textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primaryLight, width: 2),
            ),
          ),
          focusedPinTheme: PinTheme(
            width: 60,
            height: 60,
            textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary, width: 2),
            ),
          ),
          submittedPinTheme: PinTheme(
            width: 60,
            height: 60,
            textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary, width: 2),
            ),
          ),
          showCursor: true,
          keyboardType: TextInputType.number,
          inputFormatters: [],
          onChanged: (value) {
            context.read<OtpCubit>().updateOtpCode(value);
          },
          onCompleted: (pin) {
            // Verify OTP when completed
            if (pin.length == 6) {
              context.read<OtpCubit>().verifyOtp(phoneNumber, pin);
            } else {
              CustomToast.showError(
                context,
                message: AppLocalizations.invalidVerificationCode,
              );
            }
          },
        ),
      ),
    );
  }
}
