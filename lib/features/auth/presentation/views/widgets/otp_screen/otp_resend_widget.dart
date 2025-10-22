import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../manager/otp_cubit/otp_cubit.dart';
import '../../../manager/otp_cubit/otp_state.dart';
import '../../../manager/forgot_password_cubit/forgot_password_cubit.dart';
import '../../../manager/forgot_password_cubit/forgot_password_state.dart';

class OtpResendWidget extends StatelessWidget {
  final String phoneNumber;
  final bool isResetPassword;
  final Function(String phoneNumber)? onResendOtp;
  
  const OtpResendWidget({
    super.key,
    required this.phoneNumber,
    this.isResetPassword = false,
    this.onResendOtp,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<OtpCubit, OtpState>(
        builder: (context, otpState) {
          return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
            builder: (context, forgotPasswordState) {
              final isResendingOtp = otpState is OtpRequestLoading;
              final isResendingForgotPassword = forgotPasswordState is ForgotPasswordLoading;
              final isResending = isResendingOtp || isResendingForgotPassword;
          
              return RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: AppLocalizations.didntReceiveCode,
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: isResending ? null : () {
                          // Call custom resend handler or default behavior
                          if (onResendOtp != null) {
                            onResendOtp!(phoneNumber);
                          } else if (isResetPassword) {
                            // For forgot password, use ForgotPasswordCubit
                            final forgotPasswordCubit = context.read<ForgotPasswordCubit>();
                            
                            // Extract dial code and phone number from full phone number
                            String dialCode = '+20'; // Default for Egypt
                            String phone = phoneNumber;
                            
                            // Try to extract dial code (common patterns)
                            if (phoneNumber.startsWith('+20')) {
                              dialCode = '+20';
                              phone = phoneNumber.substring(3);
                            } else if (phoneNumber.startsWith('+1')) {
                              dialCode = '+1';
                              phone = phoneNumber.substring(2);
                            } else if (phoneNumber.startsWith('+966')) {
                              dialCode = '+966';
                              phone = phoneNumber.substring(4);
                            }
                            
                            forgotPasswordCubit.updatePhone(phone);
                            forgotPasswordCubit.updateDialCode(dialCode);
                            forgotPasswordCubit.sendOtp();
                          } else {
                            // For normal OTP (registration/login), use OtpCubit
                            context.read<OtpCubit>().requestOtp(phoneNumber);
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isResending)
                              const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                                ),
                              ),
                            if (isResending)
                              const SizedBox(width: 8),
                            Text(
                              isResending ? 'جاري الإرسال...' : AppLocalizations.resend,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: isResending ? AppColors.textSecondary : AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
