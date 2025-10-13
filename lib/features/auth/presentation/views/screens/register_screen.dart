import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/custom_phone_input.dart';
import '../../../../../core/widgets/university_selector_widget.dart';
import '../../../../../core/utils/navigation_helper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _selectedUniversity;
  bool _hasAttemptedSubmit = false;

  final List<String> _universities = [
    'جامعة القاهرة',
    'جامعة الإسكندرية',
    'جامعة عين شمس',
    'جامعة حلوان',
    'جامعة المنصورة',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
                // Register Form Section
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Full Name Field
                      CustomTextField(
                        label: AppLocalizations.fullName,
                        hintText: AppLocalizations.fullName,
                        controller: _nameController,
                        prefixIcon: const Icon(Ionicons.person_outline),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.pleaseEnterFullName;
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
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return AppLocalizations.passwordMustBeAtLeast6;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Confirm Password Field
                      CustomTextField(
                        label: AppLocalizations.confirmPassword,
                        hintText: AppLocalizations.confirmPassword,
                        controller: _confirmPasswordController,
                        isPassword: true,
                        prefixIcon: const Icon(Ionicons.lock_closed_outline),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.pleaseConfirmPassword;
                          }
                          if (value != _passwordController.text) {
                            return AppLocalizations.passwordsDoNotMatch;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

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
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // University Selection
                      UniversitySelectorWidget(
                        selectedUniversity: _selectedUniversity,
                        onUniversitySelected: (university) {
                          setState(() {
                            _selectedUniversity = university;
                            _hasAttemptedSubmit = false;
                          });
                        },
                        label: AppLocalizations.selectUniversity,
                        universities: _universities,
                        hasError: _hasAttemptedSubmit && _selectedUniversity == null,
                        errorText: _hasAttemptedSubmit && _selectedUniversity == null 
                            ? 'Please select your university' 
                            : null,
                      ),

                      const SizedBox(height: 32),

                      // Register Button
                      CustomButton(
                        text: AppLocalizations.register,
                        onPressed: () {
                          setState(() {
                            _hasAttemptedSubmit = true;
                          });

                          if (_formKey.currentState!.validate() &&
                              _selectedUniversity != null) {
                            // Navigate to OTP screen first
                            NavigationHelper.to(
                              path: '/otp',
                              context: context,
                              data: {
                                'phone': _phoneController.text,
                                'isResetPassword': false,
                              },
                            );
                          }
                        },
                        isOutlined: true,
                        width: double.infinity,
                        icon: const Icon(
                          Ionicons.person_add_outline,
                          color: AppColors.primary,
                          size: 20,
                        ),
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                    style: Theme.of(context).textTheme.bodyLarge
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