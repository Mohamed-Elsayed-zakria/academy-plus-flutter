import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/custom_toast.dart';
import '../../../../../core/utils/navigation_helper.dart';
import '../../../../../core/services/service_locator.dart';
import '../../manager/cubit/reset_password_cubit.dart';
import '../../manager/cubit/reset_password_state.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String phoneNumber;
  final String otpCode;

  const ResetPasswordScreen({
    super.key,
    required this.phoneNumber,
    required this.otpCode,
  });

  @override
  Widget build(BuildContext context) {
    // Create controllers for form fields
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return BlocProvider(
      create: (context) => SetupLocator.locator<ResetPasswordCubit>(),
      child: BlocListener<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            // Show success message
            CustomToast.showSuccess(
              context,
              message: 'تم إعادة تعيين كلمة المرور بنجاح!',
            );
            
            // Navigate to login screen
            NavigationHelper.off(
              path: '/login',
              context: context,
            );
          } else if (state is ResetPasswordError) {
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
                              Ionicons.key_outline,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Welcome Text
                          Text(
                            AppLocalizations.createNewPassword,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            AppLocalizations.enterNewPasswordBelow,
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
                    BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                      builder: (context, resetPasswordState) {
                        return Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header
                              Center(
                                child: Column(
                                  children: [
                                    Text(
                                      AppLocalizations.resetPassword,
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textPrimary,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      AppLocalizations.createStrongPassword,
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: AppColors.textSecondary,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 32),

                              // Phone Number Display
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.success.withValues(alpha: 0.3),
                                    width: 2,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Ionicons.checkmark_circle_outline,
                                      color: AppColors.success,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.otpVerifiedFor.replaceAll('{phone}', phoneNumber),
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: AppColors.success,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 24),

                              // New Password Field
                              CustomTextField(
                                label: AppLocalizations.newPassword,
                                hintText: AppLocalizations.newPassword,
                                controller: passwordController,
                                isPassword: true,
                                prefixIcon: const Icon(Ionicons.lock_closed_outline),
                                validator: (value) {
                                  return context.read<ResetPasswordCubit>().validatePassword(value);
                                },
                              ),

                              const SizedBox(height: 20),

                              // Confirm Password Field
                              CustomTextField(
                                label: AppLocalizations.confirmNewPassword,
                                hintText: AppLocalizations.confirmNewPassword,
                                controller: confirmPasswordController,
                                isPassword: true,
                                prefixIcon: const Icon(Ionicons.lock_closed_outline),
                                validator: (value) {
                                  return context.read<ResetPasswordCubit>().validateConfirmPassword(value, passwordController.text);
                                },
                              ),

                              // Error message display
                              BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                                builder: (context, state) {
                                  if (state is ResetPasswordError) {
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

                              // Reset Password Button
                              BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                                builder: (context, state) {
                                  final isLoading = state is ResetPasswordLoading;
                                  final hasError = state is ResetPasswordError;

                                  return CustomButton(
                                    text: isLoading 
                                        ? AppLocalizations.resetting 
                                        : hasError 
                                            ? 'إعادة المحاولة' 
                                            : AppLocalizations.resetPasswordButton,
                                    onPressed: isLoading ? null : () {
                                      // Update cubit with current form values
                                      context.read<ResetPasswordCubit>().updatePassword(passwordController.text);
                                      context.read<ResetPasswordCubit>().updateConfirmPassword(confirmPasswordController.text);
                                      
                                      // Reset password
                                      context.read<ResetPasswordCubit>().resetPassword(phoneNumber, otpCode);
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
                                        : Icon(
                                            hasError ? Ionicons.refresh_outline : Ionicons.checkmark_outline,
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

                    // Back to Login Link
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: [
                            TextSpan(
                              text: AppLocalizations.rememberPassword,
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  NavigationHelper.off(
                                    path: '/login',
                                    context: context,
                                  );
                                },
                                child: Text(
                                  AppLocalizations.backToLogin,
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