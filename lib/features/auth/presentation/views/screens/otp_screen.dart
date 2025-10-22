import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_toast.dart';
import '../../../../../core/utils/navigation_helper.dart';
import '../../../../../core/services/service_locator.dart';
import '../../manager/cubit/otp_cubit.dart';
import '../../manager/cubit/otp_state.dart';
import '../../manager/cubit/forgot_password_cubit.dart';
import '../../manager/cubit/forgot_password_state.dart';

class OtpScreen extends StatelessWidget {
  final String phoneNumber;
  final bool isResetPassword;
  final Function(String phoneNumber)? onOtpVerified;
  final Function(String phoneNumber)? onResendOtp;
  final Map<String, dynamic>? extraData;

  const OtpScreen({
    super.key,
    required this.phoneNumber,
    this.isResetPassword = false,
    this.onOtpVerified,
    this.onResendOtp,
    this.extraData,
  });

  @override
  Widget build(BuildContext context) {
    // Create controllers for form fields
    final pinController = TextEditingController();
    final focusNode = FocusNode();

    return MultiBlocProvider(
      providers: [
        BlocProvider<OtpCubit>(
          create: (context) => SetupLocator.locator<OtpCubit>()..updatePhoneNumber(phoneNumber),
        ),
        BlocProvider<ForgotPasswordCubit>(
          create: (context) => SetupLocator.locator<ForgotPasswordCubit>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<OtpCubit, OtpState>(
        listener: (context, state) {
          if (state is OtpVerifySuccess) {
            // Call the custom verification handler
            if (onOtpVerified != null) {
              onOtpVerified!(phoneNumber);
            } else {
              // Check if this is login verification
              if (extraData?['isLoginVerification'] == true) {
                // Navigate to main screen after successful login verification
                NavigationHelper.off(
                  path: '/main',
                  context: context,
                );
                CustomToast.showSuccess(
                  context,
                  message: 'تم التحقق من رقم الهاتف بنجاح!',
                );
              } else if (isResetPassword) {
                // Get the OTP code from the current state
                final otpCode = state.otpCode;
                NavigationHelper.off(
                  path: '/reset-password',
                  context: context,
                  data: {
                    'phoneNumber': phoneNumber,
                    'otpCode': otpCode,
                  },
                );
              } else {
                // Navigate to profile picture screen for registration
                NavigationHelper.off(
                  path: '/profile-picture',
                  context: context,
                  data: extraData,
                );
              }
            }
          } else if (state is OtpVerifyError) {
            // Show error toast
            CustomToast.showError(
              context,
              message: state.error,
            );
          } else if (state is OtpRequestSuccess) {
            // Show success message for resend
            CustomToast.showSuccess(
              context,
              message: 'تم إرسال رمز التحقق مرة أخرى',
            );
          } else if (state is OtpRequestError) {
            // Show error toast for resend
            CustomToast.showError(
              context,
              message: state.error,
            );
          }
        },
          ),
          BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
            listener: (context, state) {
              if (state is ForgotPasswordSuccess) {
                // Show success message for resend
                CustomToast.showSuccess(
                  context,
                  message: 'تم إرسال رمز التحقق مرة أخرى',
                );
              } else if (state is ForgotPasswordError) {
                // Show error toast for resend
                CustomToast.showError(
                  context,
                  message: state.error,
                );
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    Center(
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),
                    BlocBuilder<OtpCubit, OtpState>(
                      builder: (context, otpState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
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
                                        message: 'رمز التحقق غير صحيح',
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                            
                            // Error message display
                            BlocBuilder<OtpCubit, OtpState>(
                              builder: (context, state) {
                                if (state is OtpVerifyError) {
                                  return Container(
                                    margin: const EdgeInsets.only(top: 16),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: AppColors.error.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: AppColors.error.withValues(alpha: 0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Ionicons.warning_outline,
                                          color: AppColors.error,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            state.error,
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: AppColors.error,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                            
                            const SizedBox(height: 32),
                            Center(
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
                            ),
                            const SizedBox(height: 32),
                            BlocBuilder<OtpCubit, OtpState>(
                              builder: (context, state) {
                                final isLoading = state is OtpVerifyLoading;
                                final hasError = state is OtpVerifyError;
                                
                                return CustomButton(
                                  text: isLoading 
                                      ? 'جاري التحقق...' 
                                      : hasError 
                                          ? 'إعادة المحاولة' 
                                          : AppLocalizations.verify,
                                  onPressed: isLoading ? null : () {
                                    final otpCode = pinController.text.trim();
                                    
                                    if (otpCode.length == 6) {
                                      context.read<OtpCubit>().verifyOtp(phoneNumber, otpCode);
                                    } else {
                                      CustomToast.showError(
                                        context,
                                        message: 'يرجى إدخال رمز التحقق كاملاً (6 أرقام)',
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
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}