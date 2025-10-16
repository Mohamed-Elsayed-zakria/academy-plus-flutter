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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedDialCode = '+20'; // Default to Egypt dial code
  late LoginCubit _loginCubit;
  late OtpCubit _otpCubit;

  @override
  void initState() {
    super.initState();
    _loginCubit = SetupLocator.locator<LoginCubit>();
    _otpCubit = SetupLocator.locator<OtpCubit>();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _loginCubit),
        BlocProvider(create: (context) => _otpCubit),
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
                  final fullPhoneNumber = '$_selectedDialCode${_phoneController.text}';
                  _otpCubit.requestOtp(fullPhoneNumber);
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
                final fullPhoneNumber = '$_selectedDialCode${_phoneController.text}';
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
                            onCountryChanged: (countryCode, dialCode) {
                              setState(() {
                                _selectedDialCode = dialCode;
                              });
                              print('Country changed: $countryCode, Dial code: $dialCode');
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.pleaseEnterPhone;
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          // Password Field
                          CustomTextField(
                            label: AppLocalizations.password,
                            hintText: AppLocalizations.password,
                            controller: _passwordController,
                            isPassword: true,
                            prefixIcon: const Icon(Ionicons.lock_closed_outline),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.pleaseEnterPassword;
                              }
                              return null;
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

                          const SizedBox(height: 32),

                          // Login Button
                          BlocBuilder<LoginCubit, LoginState>(
                            builder: (context, state) {
                              final isLoading = state is LoginLoading;

                              return CustomButton(
                                text: isLoading ? 'جاري تسجيل الدخول...' : AppLocalizations.login,
                                onPressed: isLoading ? null : () {
                                  if (_formKey.currentState!.validate()) {
                                    // Prepare phone number with country code
                                    final fullPhoneNumber = '$_selectedDialCode${_phoneController.text}';
                                    print('Logging in with phone: $fullPhoneNumber');
                                    
                                    // Login user
                                    _loginCubit.login(fullPhoneNumber, _passwordController.text);
                                  }
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
                                    : const Icon(
                                        Ionicons.enter_outline,
                                        color: AppColors.primary,
                                        size: 22,
                                      ),
                              );
                            },
                          ),
                        ],
                      ),
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