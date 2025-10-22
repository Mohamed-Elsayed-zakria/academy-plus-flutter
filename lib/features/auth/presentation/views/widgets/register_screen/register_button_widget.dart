import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../manager/register_cubit/register_cubit.dart';
import '../../../manager/register_cubit/register_state.dart';

class RegisterButtonWidget extends StatelessWidget {
  const RegisterButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        final isLoading = state is RegisterLoading;

        return CustomButton(
          text: isLoading
              ? 'جاري إنشاء الحساب...'
              : AppLocalizations.register,
          onPressed: isLoading
              ? null
              : () {
                  // Use the validateAndRegister method from cubit
                  context.read<RegisterCubit>().validateAndRegister();
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
                  Ionicons.person_add_outline,
                  color: AppColors.primary,
                  size: 20,
                ),
        );
      },
    );
  }
}
