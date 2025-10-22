import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../manager/reset_password_cubit/reset_password_cubit.dart';
import '../../../manager/reset_password_cubit/reset_password_state.dart';

class ResetPasswordButtonWidget extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final String phoneNumber;
  final String otpCode;
  
  const ResetPasswordButtonWidget({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.phoneNumber,
    required this.otpCode,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
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
    );
  }
}
