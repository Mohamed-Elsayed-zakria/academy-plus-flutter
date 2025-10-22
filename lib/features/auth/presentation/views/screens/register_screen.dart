import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/custom_toast.dart';
import '../../../../../core/utils/navigation_helper.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../universities/presentation/manager/cubit/universities_cubit.dart';
import '../../manager/register_cubit/register_cubit.dart';
import '../../manager/register_cubit/register_state.dart';
import '../../manager/otp_cubit/otp_cubit.dart';
import '../../manager/otp_cubit/otp_state.dart';
import '../widgets/register_screen/register_screen_widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SetupLocator.locator<UniversitiesCubit>()..getUniversities()),
        BlocProvider(create: (context) => SetupLocator.locator<RegisterCubit>()),
        BlocProvider(create: (context) => SetupLocator.locator<OtpCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccess) {
                final registerCubit = context.read<RegisterCubit>();
                final currentState = registerCubit.state as RegisterSuccess;
                final fullPhoneNumber = '${currentState.selectedDialCode}${currentState.phone}';
                // Request OTP after successful registration
                context.read<OtpCubit>().requestOtp(fullPhoneNumber);
              } else if (state is RegisterError) {
                // Show error toast
                CustomToast.showError(context, message: state.error);
              }
            },
          ),
          BlocListener<OtpCubit, OtpState>(
            listener: (context, state) {
              if (state is OtpRequestSuccess) {
                final registerCubit = context.read<RegisterCubit>();
                final currentState = registerCubit.state as RegisterSuccess;
                final fullPhoneNumber = '${currentState.selectedDialCode}${currentState.phone}';
                // Navigate to OTP screen after successful OTP request
                NavigationHelper.to(
                  path: '/otp',
                  context: context,
                  data: {
                    'phoneNumber': fullPhoneNumber,
                    'isResetPassword': false,
                    'extraData': {
                      'name': currentState.name,
                      'phone': fullPhoneNumber,
                      'password': currentState.password,
                      'universityId': currentState.selectedUniversity?.id ?? 0,
                    },
                  },
                );
              } else if (state is OtpRequestError) {
                // Show error toast
                CustomToast.showError(context, message: state.error);
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
                    const RegisterHeaderWidget(),
                    const SizedBox(height: 48),
                    
                    // Register Form Section
                    const RegisterFormWidget(),

                    // Error message display
                    const RegisterErrorWidget(),

                    const SizedBox(height: 32),

                    // Register Button
                    const RegisterButtonWidget(),

                    const SizedBox(height: 32),

                    // Divider
                    const RegisterDividerWidget(),

                    const SizedBox(height: 32),

                    // Login Link
                    const RegisterLoginLinkWidget(),

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
