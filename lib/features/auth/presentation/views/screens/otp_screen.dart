import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/utils/navigation_helper.dart';

class OtpScreen extends StatefulWidget {
  final Map<String, dynamic>? extra;

  const OtpScreen({super.key, this.extra});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _pinController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isResetPassword = widget.extra?['isResetPassword'] == true;
    final phoneNumber = widget.extra?['phone'] ?? '';

    final defaultPinTheme = PinTheme(
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
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: AppColors.primary, width: 2),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: AppColors.primaryLight.withValues(alpha: 0.1),
        border: Border.all(color: AppColors.primary, width: 2),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              children: [
                const SizedBox(height: 60),

                // OTP Illustration and Header Section
                Center(
                  child: Column(
                    children: [
                      // OTP Illustration
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
                      // Title
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

                // OTP Input Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // OTP Input
                    Center(
                      child: Pinput(
                        controller: _pinController,
                        focusNode: _focusNode,
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        showCursor: true,
                        onCompleted: (pin) {
                          // Simulate OTP verification
                          if (pin == '123456') {
                            if (isResetPassword) {
                              // Navigate to reset password screen
                              NavigationHelper.off(
                                path: '/reset-password',
                                context: context,
                                data: {'phoneNumber': phoneNumber},
                              );
                            } else {
                              // Navigate to profile picture screen for registration
                              NavigationHelper.off(
                                path: '/profile-picture',
                                context: context,
                              );
                            }
                          } else {
                            // Invalid OTP - could show error in UI instead
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Resend Code Section
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: AppLocalizations.didntReceiveCode,
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  // Resend OTP logic
                                },
                                child: Text(
                                  AppLocalizations.resend,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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

                    const SizedBox(height: 32),

                    // Verify Button
                    CustomButton(
                      text: AppLocalizations.verify,
                      onPressed: () {
                        // Simulate OTP verification
                        if (isResetPassword) {
                          // Navigate to reset password screen
                          NavigationHelper.off(
                            path: '/reset-password',
                            context: context,
                            data: {'phoneNumber': phoneNumber},
                          );
                        } else {
                          // Navigate to profile picture screen for registration
                          NavigationHelper.off(
                            path: '/profile-picture',
                            context: context,
                          );
                        }
                      },
                      isOutlined: true,
                      width: double.infinity,
                      icon: const Icon(
                        Ionicons.checkmark_circle_outline,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
