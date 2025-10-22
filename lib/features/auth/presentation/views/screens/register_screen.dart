import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/custom_phone_input.dart';
import '../../../../../core/widgets/university_selector_widget.dart';
import '../../../../../core/widgets/custom_toast.dart';
import '../../../../../core/utils/navigation_helper.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../universities/presentation/manager/cubit/universities_cubit.dart';
import '../../../../universities/presentation/manager/cubit/universities_state.dart';
import '../../manager/cubit/register_cubit.dart';
import '../../manager/cubit/register_state.dart';
import '../../manager/cubit/otp_cubit.dart';
import '../../manager/cubit/otp_state.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Create controllers for form fields
    final nameController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final phoneController = TextEditingController();
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
                                  color: AppColors.primary.withValues(
                                    alpha: 0.3,
                                  ),
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
                    // Register Form Section
                    BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (context, registerState) {
                        return Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Full Name Field
                              CustomTextField(
                                label: AppLocalizations.fullName,
                                hintText: AppLocalizations.fullName,
                                controller: nameController,
                                prefixIcon: const Icon(Ionicons.person_outline),
                                validator: (value) {
                                  return context.read<RegisterCubit>().validateName(value);
                                },
                              ),

                              const SizedBox(height: 20),

                              // Password Field
                              CustomTextField(
                                label: AppLocalizations.password,
                                hintText: AppLocalizations.password,
                                controller: passwordController,
                                isPassword: true,
                                prefixIcon: const Icon(
                                  Ionicons.lock_closed_outline,
                                ),
                                validator: (value) {
                                  return context.read<RegisterCubit>().validatePassword(value);
                                },
                              ),

                              const SizedBox(height: 20),

                              // Confirm Password Field
                              CustomTextField(
                                label: AppLocalizations.confirmPassword,
                                hintText: AppLocalizations.confirmPassword,
                                controller: confirmPasswordController,
                                isPassword: true,
                                prefixIcon: const Icon(
                                  Ionicons.lock_closed_outline,
                                ),
                                validator: (value) {
                                  return context.read<RegisterCubit>().validateConfirmPassword(value, passwordController.text);
                                },
                              ),

                              const SizedBox(height: 20),

                              // Phone Number Field
                              BlocBuilder<RegisterCubit, RegisterState>(
                                builder: (context, state) {
                                  return CustomPhoneInput(
                                    label: AppLocalizations.phoneNumber,
                                    hintText: AppLocalizations.phoneNumber,
                                    controller: phoneController,
                                    initialCountryCode: 'EG',
                                    onCountryChanged: (countryCode, dialCode) {
                                      context.read<RegisterCubit>().updateDialCode(dialCode);
                                    },
                                    validator: (value) {
                                      return context.read<RegisterCubit>().validatePhone(value);
                                    },
                                  );
                                },
                              ),

                              const SizedBox(height: 20),

                              // University Selection
                              BlocBuilder<UniversitiesCubit, UniversitiesState>(
                                builder: (context, universitiesState) {
                                  return BlocBuilder<RegisterCubit, RegisterState>(
                                    builder: (context, registerState) {
                                      final currentState = registerState is RegisterInitial ? registerState : RegisterInitial();
                                      return UniversitySelectorWidget(
                                        selectedUniversity: currentState.selectedUniversity,
                                        onUniversitySelected: (university) {
                                          context.read<RegisterCubit>().updateSelectedUniversity(university);
                                        },
                                        onTap: () {
                                          // Universities are already loaded automatically
                                        },
                                        label: AppLocalizations.selectUniversity,
                                        universities: universitiesState is UniversitiesSuccess
                                            ? universitiesState.universities
                                            : [],
                                        isLoading: universitiesState is UniversitiesLoading,
                                        hasError: currentState.hasAttemptedSubmit && currentState.selectedUniversity == null,
                                        errorText: currentState.hasAttemptedSubmit && currentState.selectedUniversity == null
                                            ? 'Please select your university'
                                            : null,
                                      );
                                    },
                                  );
                                },
                              ),

                              // Error message display
                              BlocBuilder<RegisterCubit, RegisterState>(
                                builder: (context, state) {
                                  if (state is RegisterError) {
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

                              // Register Button
                              BlocBuilder<RegisterCubit, RegisterState>(
                                builder: (context, state) {
                                  final isLoading = state is RegisterLoading;
                                  final hasError = state is RegisterError;

                                  return CustomButton(
                                    text: isLoading
                                        ? 'جاري إنشاء الحساب...'
                                        : hasError
                                            ? 'إعادة المحاولة'
                                            : AppLocalizations.register,
                                    onPressed: isLoading
                                        ? null
                                        : () {
                                            // Update cubit with current form values
                                            context.read<RegisterCubit>().updateName(nameController.text);
                                            context.read<RegisterCubit>().updatePassword(passwordController.text);
                                            context.read<RegisterCubit>().updateConfirmPassword(confirmPasswordController.text);
                                            context.read<RegisterCubit>().updatePhone(phoneController.text);
                                            
                                            // Register user
                                            context.read<RegisterCubit>().register();
                                          },
                                    isOutlined: true,
                                    width: double.infinity,
                                    icon: isLoading
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                    AppColors.primary,
                                                  ),
                                            ),
                                          )
                                        : Icon(
                                            hasError ? Ionicons.refresh_outline : Ionicons.person_add_outline,
                                            color: AppColors.primary,
                                            size: 20,
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
                                      color: AppColors.textTertiary.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Text(
                                      AppLocalizations.or,
                                      style: Theme.of(context).textTheme.bodySmall
                                          ?.copyWith(
                                            color: AppColors.textTertiary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: AppColors.textTertiary.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 32),

                              // Login Link
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.bodyLarge,
                                    children: [
                                      TextSpan(
                                        text: AppLocalizations.alreadyHaveAccount,
                                        style: TextStyle(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: GestureDetector(
                                          onTap: () => NavigationHelper.off(
                                            path: '/login',
                                            context: context,
                                          ),
                                          child: Text(
                                            AppLocalizations.login,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
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
