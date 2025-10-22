import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../manager/reset_password_cubit/reset_password_cubit.dart';
import '../../../manager/reset_password_cubit/reset_password_state.dart';

class ResetPasswordErrorWidget extends StatelessWidget {
  const ResetPasswordErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      builder: (context, state) {
        if (state is ResetPasswordError) {
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
    );
  }
}
