import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/custom_toast.dart';
import '../../../../../core/utils/navigation_helper.dart';
import '../../../../../core/services/service_locator.dart';
import '../../manager/login_cubit/login_cubit.dart';
import '../../manager/login_cubit/login_state.dart';
import '../../manager/otp_cubit/otp_cubit.dart';
import '../../manager/otp_cubit/otp_state.dart';
import '../widgets/login_screen/login_screen_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    const LoginHeaderWidget(),
                    const SizedBox(height: 48),
                    
                    // Login Form Section
                    const LoginFormWidget(),

                    // Error message display
                    const LoginErrorWidget(),

                    const SizedBox(height: 32),

                    // Login Button
                    const LoginButtonWidget(),

                    const SizedBox(height: 32),

                    // Divider
                    const LoginDividerWidget(),

                    const SizedBox(height: 32),

                    // Register Link
                    const LoginRegisterLinkWidget(),

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