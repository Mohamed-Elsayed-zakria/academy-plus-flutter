import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_phone_input.dart';
import '../../../../../core/utils/navigation_helper.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _sendOTP() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // Navigate to OTP verification screen
      NavigationHelper.off(
        path: '/otp',
        context: context,
        data: {
          'phone': _phoneController.text,
          'isResetPassword': true,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              children: [
                const SizedBox(height: 60),

                // Forgot Password Illustration and Header Section
                Center(
                  child: Column(
                    children: [
                      // Forgot Password Illustration
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
                          'assets/images/Forgot password-amico.svg',
                          width: 240,
                          height: 240,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Title
                      Text(
                        AppLocalizations.forgotPassword,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppLocalizations.enterPhoneReset,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                
                // Reset Password Form Section
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Phone Number Field
                      CustomPhoneInput(
                        label: AppLocalizations.phoneNumber,
                        hintText: AppLocalizations.phoneNumber,
                        controller: _phoneController,
                        initialCountryCode: 'EG',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.pleaseEnterPhone;
                          }
                          if (value.length < 10) {
                            return AppLocalizations.pleaseEnterValidPhone;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 32),

                      // Send OTP Button
                      CustomButton(
                        text: _isLoading ? AppLocalizations.sending : AppLocalizations.sendOtp,
                        onPressed: _isLoading ? null : () => _sendOTP(),
                        isOutlined: true,
                        width: double.infinity,
                        icon: _isLoading 
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                                ),
                              )
                            : const Icon(
                                Ionicons.chatbubble_outline,
                                color: AppColors.primary,
                                size: 22,
                              ),
                      ),
                    ],
                  ),
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
