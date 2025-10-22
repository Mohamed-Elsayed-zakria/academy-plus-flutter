import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/custom_toast.dart';
import '../../../../../core/utils/navigation_helper.dart';
import '../../../../../core/services/service_locator.dart';
import '../../manager/forgot_password_cubit/forgot_password_cubit.dart';
import '../../manager/forgot_password_cubit/forgot_password_state.dart';
import '../widgets/forgot_password_screen/forgot_password_screen_widgets.dart';

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
                    const ForgotPasswordHeaderWidget(),
                    const SizedBox(height: 48),
                    
                    // Reset Password Form Section
                    ForgotPasswordFormWidget(phoneController: phoneController),

                    const SizedBox(height: 32),

                    // Send OTP Button
                    ForgotPasswordButtonWidget(phoneController: phoneController),

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
