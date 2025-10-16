import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_toast.dart';
import '../../../../../core/utils/navigation_helper.dart';
import '../../../../../core/services/service_locator.dart';
import '../../manager/cubit/otp_cubit.dart';
import '../../manager/cubit/otp_state.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final bool isResetPassword;
  final Function(String phoneNumber)? onOtpVerified;
  final Function(String phoneNumber)? onResendOtp;
  final Map<String, dynamic>? extraData;

  const OtpScreen({
    super.key,
    required this.phoneNumber,
    this.isResetPassword = false,
    this.onOtpVerified,
    this.onResendOtp,
    this.extraData,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _pinController = TextEditingController();
  final _focusNode = FocusNode();
  late OtpCubit _otpCubit;
  String _currentOtp = '';

  @override
  void initState() {
    super.initState();
    _otpCubit = SetupLocator.locator<OtpCubit>();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryLight, width: 2),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: AppColors.primary, width: 2),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: AppColors.primaryLight.withValues(alpha: 0.1),
        border: Border.all(color: AppColors.primary, width: 2),
      ),
    );

    return BlocProvider(
      create: (context) => _otpCubit,
      child: BlocListener<OtpCubit, OtpState>(
        listener: (context, state) {
              if (state is OtpVerifySuccess) {
                // Call the custom verification handler
                if (widget.onOtpVerified != null) {
                  widget.onOtpVerified!(widget.phoneNumber);
                } else {
                  // Check if this is login verification
                  if (widget.extraData?['isLoginVerification'] == true) {
                    // Navigate to main screen after successful login verification
                    NavigationHelper.off(
                      path: '/main',
                      context: context,
                    );
                    CustomToast.showSuccess(
                      context,
                      message: 'تم التحقق من رقم الهاتف بنجاح!',
                    );
                  } else if (widget.isResetPassword) {
                    NavigationHelper.off(
                      path: '/reset-password',
                      context: context,
                      data: {'phoneNumber': widget.phoneNumber},
                    );
                  } else {
                    // Navigate to profile picture screen for registration
                    NavigationHelper.off(
                      path: '/profile-picture',
                      context: context,
                      data: widget.extraData,
                    );
                  }
                }
              } else if (state is OtpVerifyError) {
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
                    Center(
                      child: Column(
                        children: [
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
                              'assets/images/Enter OTP-amico.svg',
                              width: 240,
                              height: 240,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            AppLocalizations.verifyOtp,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            AppLocalizations.enterOtp,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Pinput(
                              controller: _pinController,
                              focusNode: _focusNode,
                              length: 6,
                              defaultPinTheme: defaultPinTheme,
                              focusedPinTheme: focusedPinTheme,
                              submittedPinTheme: submittedPinTheme,
                              showCursor: true,
                              keyboardType: TextInputType.number,
                              inputFormatters: [],
                              onChanged: (value) {
                                print('OTP Changed: "$value" (length: ${value.length})');
                                setState(() {
                                  _currentOtp = value;
                                });
                              },
                              onCompleted: (pin) {
                                print('OTP Completed: "$pin" (length: ${pin.length})');
                                // Verify OTP when completed
                                if (pin.length == 6) {
                                  // Use phone number as received from registration (already formatted with country code)
                                  String formattedPhone = widget.phoneNumber;
                                  
                                  print('Auto-completed OTP verification:');
                                  print('Phone: $formattedPhone');
                                  print('OTP: $pin');
                                  _otpCubit.verifyOtp(formattedPhone, pin);
                                } else {
                                  CustomToast.showError(
                                    context,
                                    message: 'رمز التحقق غير صحيح',
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.bodyMedium,
                              children: [
                                TextSpan(
                                  text: AppLocalizations.didntReceiveCode,
                                  style: TextStyle(color: AppColors.textSecondary),
                                ),
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () {
                                      // Call custom resend handler or default behavior
                                      if (widget.onResendOtp != null) {
                                        widget.onResendOtp!(widget.phoneNumber);
                                      } else {
                                        _otpCubit.requestOtp(widget.phoneNumber);
                                      }
                                    },
                                    child: Text(
                                      AppLocalizations.resend,
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                        const SizedBox(height: 32),
                        BlocBuilder<OtpCubit, OtpState>(
                          builder: (context, state) {
                            final isLoading = state is OtpVerifyLoading;
                            
                            return CustomButton(
                              text: isLoading ? 'جاري التحقق...' : AppLocalizations.verify,
                              onPressed: isLoading ? null : () {
                                final otpCode = _currentOtp.isNotEmpty ? _currentOtp : _pinController.text.trim();
                                
                                if (otpCode.length == 6) {
                                  print('Calling _otpCubit.verifyOtp with:');
                                  print('Phone: ${widget.phoneNumber}');
                                  print('OTP: $otpCode');
                                  
                                  // Use phone number as received from registration (already formatted with country code)
                                  String formattedPhone = widget.phoneNumber;
                                  
                                  print('Using Phone: $formattedPhone');
                                  _otpCubit.verifyOtp(formattedPhone, otpCode);
                                } else {
                                  CustomToast.showError(
                                    context,
                                    message: 'يرجى إدخال رمز التحقق كاملاً (6 أرقام)',
                                  );
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
                                      Ionicons.checkmark_circle_outline,
                                      color: AppColors.primary,
                                      size: 20,
                                    ),
                            );
                          },
                        ),
                      ],
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