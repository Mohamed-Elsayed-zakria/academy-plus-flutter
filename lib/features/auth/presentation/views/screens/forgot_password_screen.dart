import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_phone_input.dart';
import '../../../../../core/widgets/custom_toast.dart';
import '../../../../../core/utils/navigation_helper.dart';
import '../../../../../core/services/service_locator.dart';
import '../../manager/cubit/forgot_password_cubit.dart';
import '../../manager/cubit/forgot_password_state.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Create controller for phone field
    final phoneController = TextEditingController();

    return BlocProvider(
      create: (context) => SetupLocator.locator<ForgotPasswordCubit>(),
      child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            // Navigate to OTP verification screen
            final fullPhoneNumber = '${state.selectedDialCode}${state.phone}';
            NavigationHelper.off(
              path: '/otp',
              context: context,
              data: {
                'phoneNumber': fullPhoneNumber,
                'isResetPassword': true,
              },
            );
          } else if (state is ForgotPasswordError) {
            // Show error toast
            CustomToast.showError(
              context,
              message: state.error,
            );
          }
        },
        child: Scaffold(
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
                    BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                      builder: (context, forgotPasswordState) {
                        return Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Phone Number Field
                              CustomPhoneInput(
                                label: AppLocalizations.phoneNumber,
                                hintText: AppLocalizations.phoneNumber,
                                controller: phoneController,
                                initialCountryCode: 'EG',
                                onCountryChanged: (countryCode, dialCode) {
                                  context.read<ForgotPasswordCubit>().updateDialCode(dialCode);
                                },
                                validator: (value) {
                                  return context.read<ForgotPasswordCubit>().validatePhone(value);
                                },
                              ),

                              const SizedBox(height: 32),

                              // Send OTP Button
                              BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                                builder: (context, state) {
                                  final isLoading = state is ForgotPasswordLoading;

                                  return CustomButton(
                                    text: isLoading ? AppLocalizations.sending : AppLocalizations.sendOtp,
                                    onPressed: isLoading ? null : () {
                                      // Update cubit with current form values
                                      context.read<ForgotPasswordCubit>().updatePhone(phoneController.text);
                                      
                                      // Send OTP
                                      context.read<ForgotPasswordCubit>().sendOtp();
                                    },
                                    isOutlined: true,
                                    width: double.infinity,
                                    icon: isLoading 
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
                                  );
                                },
                              ),
                            ],
                          ),
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
