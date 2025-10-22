import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/custom_toast.dart';
import '../../../../../core/utils/navigation_helper.dart';
import '../../../../../core/services/service_locator.dart';
import '../../manager/otp_cubit/otp_cubit.dart';
import '../../manager/otp_cubit/otp_state.dart';
import '../../manager/forgot_password_cubit/forgot_password_cubit.dart';
import '../../manager/forgot_password_cubit/forgot_password_state.dart';
import '../widgets/otp_screen/otp_screen_widgets.dart';

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

                    // OTP Illustration and Header Section
                    OtpHeaderWidget(phoneNumber: phoneNumber),
                    const SizedBox(height: 48),
                    
                    // OTP Input Section
                    BlocBuilder<OtpCubit, OtpState>(
                      builder: (context, otpState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OtpInputWidget(
                              pinController: pinController,
                              focusNode: focusNode,
                              phoneNumber: phoneNumber,
                            ),
                            
                            // Error message display
                            const OtpErrorWidget(),
                            
                            const SizedBox(height: 32),
                            
                            // Resend OTP Section
                            OtpResendWidget(
                              phoneNumber: phoneNumber,
                              isResetPassword: isResetPassword,
                              onResendOtp: onResendOtp,
                            ),
                            
                            const SizedBox(height: 32),
                            
                            // Verify Button
                            OtpButtonWidget(
                              pinController: pinController,
                              phoneNumber: phoneNumber,
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