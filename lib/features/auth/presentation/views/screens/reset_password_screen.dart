import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/custom_toast.dart';
import '../../../../../core/utils/navigation_helper.dart';
import '../../../../../core/services/service_locator.dart';
import '../../manager/reset_password_cubit/reset_password_cubit.dart';
import '../../manager/reset_password_cubit/reset_password_state.dart';
import '../widgets/reset_password_screen/reset_password_screen_widgets.dart';

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
                    const ResetPasswordHeaderWidget(),
                    const SizedBox(height: 48),
                    
                    // Reset Password Form Section
                    BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                      builder: (context, resetPasswordState) {
                        return Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Form Header
                              const ResetPasswordFormHeaderWidget(),

                              const SizedBox(height: 32),

                              // Phone Number Display
                              ResetPasswordPhoneDisplayWidget(phoneNumber: phoneNumber),

                              const SizedBox(height: 24),

                              // Password Fields
                              ResetPasswordFormWidget(
                                passwordController: passwordController,
                                confirmPasswordController: confirmPasswordController,
                              ),

                              // Error message display
                              const ResetPasswordErrorWidget(),

                              const SizedBox(height: 32),

                              // Reset Password Button
                              ResetPasswordButtonWidget(
                                passwordController: passwordController,
                                confirmPasswordController: confirmPasswordController,
                                phoneNumber: phoneNumber,
                                otpCode: otpCode,
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 32),

                    // Divider and Back to Login
                    const ResetPasswordDividerWidget(),

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