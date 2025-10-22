import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../manager/login_cubit/login_cubit.dart';
import '../../../manager/login_cubit/login_state.dart';


class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final isLoading = state is LoginLoading;

        return CustomButton(
          text: isLoading 
              ? 'جاري تسجيل الدخول...' 
              : AppLocalizations.login,
          onPressed: isLoading ? null : () {
            // Use the validateAndLogin method from cubit
            context.read<LoginCubit>().validateAndLogin();
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
    );
  }
}
