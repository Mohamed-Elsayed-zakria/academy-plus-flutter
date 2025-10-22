import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../manager/reset_password_cubit/reset_password_cubit.dart';

class ResetPasswordFormWidget extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  
  const ResetPasswordFormWidget({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }
}
