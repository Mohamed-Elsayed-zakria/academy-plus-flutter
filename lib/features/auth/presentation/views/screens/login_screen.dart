import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/custom_phone_input.dart';
import '../../../../../core/widgets/custom_toast.dart';
import '../../../../../core/utils/navigation_helper.dart';
import '../../../../../core/services/service_locator.dart';
import '../../manager/cubit/login_cubit.dart';
import '../../manager/cubit/login_state.dart';
import '../../manager/cubit/otp_cubit.dart';
import '../../manager/cubit/otp_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Create controllers for form fields
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SetupLocator.locator<LoginCubit>()),
        BlocProvider(create: (context) => SetupLocator.locator<OtpCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                // Check if phone is verified
                if (state.loginResponse.user.phoneVerified) {
                  // Phone is verified, navigate to main screen
                  NavigationHelper.off(
                    path: '/main',
                    context: context,
                  );
                  CustomToast.showSuccess(
                    context,
                    message: 'مرحباً بك!',
                  );
                } else {
                  // Phone not verified, request OTP and navigate to OTP screen
                  final fullPhoneNumber = '${state.selectedDialCode}${state.phone}';
                  context.read<OtpCubit>().requestOtp(fullPhoneNumber);
                }
              } else if (state is LoginError) {
                // Show error toast
                CustomToast.showError(
                  context,
                  message: state.error,
                );
              }
            },
          ),
          BlocListener<OtpCubit, OtpState>(
            listener: (context, state) {
              if (state is OtpRequestSuccess) {
                // Navigate to OTP screen for phone verification
                final loginCubit = context.read<LoginCubit>();
                final loginState = loginCubit.state as LoginSuccess;
                final fullPhoneNumber = '${loginState.selectedDialCode}${loginState.phone}';
                NavigationHelper.to(
                  path: '/otp',
                  context: context,
                  data: {
                    'phoneNumber': fullPhoneNumber,
                    'isResetPassword': false,
                    'extraData': {
                      'isLoginVerification': true,
                      'phoneNumber': fullPhoneNumber,
                    },
                  },
                );
              } else if (state is OtpRequestError) {
                // Show error toast
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

                    // App Logo and Header Section
                    Center(
                      child: Column(
                        children: [
                          // App Logo
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withValues(alpha: 0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Ionicons.school_outline,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Welcome Text
                          Text(
                            AppLocalizations.appName,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),
                    // Login Form Section
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, loginState) {
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
                                  context.read<LoginCubit>().updateDialCode(dialCode);
                                },
                                validator: (value) {
                                  return context.read<LoginCubit>().validatePhone(value);
                                },
                              ),

                              const SizedBox(height: 20),

                              // Password Field
                              CustomTextField(
                                label: AppLocalizations.password,
                                hintText: AppLocalizations.password,
                                controller: passwordController,
                                isPassword: true,
                                prefixIcon: const Icon(Ionicons.lock_closed_outline),
                                validator: (value) {
                                  return context.read<LoginCubit>().validatePassword(value);
                                },
                              ),
                              const SizedBox(height: 16),
                              // Forgot Password Link
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    NavigationHelper.to(
                                      path: '/forgot-password',
                                      context: context,
                                    );
                                  },
                                  child: Text(
                                    AppLocalizations.forgotPassword,
                                    style: Theme.of(context).textTheme.bodyMedium
                                        ?.copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ),

                              // Error message display
                              BlocBuilder<LoginCubit, LoginState>(
                                builder: (context, state) {
                                  if (state is LoginError) {
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

                              // Login Button
                              BlocBuilder<LoginCubit, LoginState>(
                                builder: (context, state) {
                                  final isLoading = state is LoginLoading;
                                  final hasError = state is LoginError;

                                  return CustomButton(
                                    text: isLoading 
                                        ? 'جاري تسجيل الدخول...' 
                                        : hasError 
                                            ? 'إعادة المحاولة' 
                                            : AppLocalizations.login,
                                    onPressed: isLoading ? null : () {
                                      // Update cubit with current form values
                                      context.read<LoginCubit>().updatePhone(phoneController.text);
                                      context.read<LoginCubit>().updatePassword(passwordController.text);
                                      
                                      // Login user
                                      context.read<LoginCubit>().login();
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
                                            hasError ? Ionicons.refresh_outline : Ionicons.enter_outline,
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

                    const SizedBox(height: 32),

                    // Divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.textTertiary.withValues(alpha: 0.3),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            AppLocalizations.or,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textTertiary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.textTertiary.withValues(alpha: 0.3),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Register Link
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: [
                            TextSpan(
                              text: AppLocalizations.dontHaveAccount,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () => NavigationHelper.off(
                                  path: '/register',
                                  context: context,
                                ),
                                child: Text(
                                  AppLocalizations.register,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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