import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../manager/forgot_password_cubit/forgot_password_cubit.dart';
import '../../../manager/forgot_password_cubit/forgot_password_state.dart';

class ForgotPasswordButtonWidget extends StatelessWidget {
  final TextEditingController phoneController;
  
  const ForgotPasswordButtonWidget({
    super.key,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      builder: (context, state) {
        final isLoading = state is ForgotPasswordLoading;

        return CustomButton(
          text: isLoading ? AppLocalizations.sending : AppLocalizations.sendOtp,
          onPressed: isLoading ? null : () {
            // Update cubit with current form values
            context.read<ForgotPasswordCubit>().updatePhone(phoneController.text);
            
            // Send OTP
            context.read<ForgotPasswordCubit>().sendOtp();
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
              : const Icon(
                  Ionicons.chatbubble_outline,
                  color: AppColors.primary,
                  size: 22,
                ),
        );
      },
    );
  }
}
