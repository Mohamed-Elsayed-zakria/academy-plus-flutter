import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../manager/profile_picture_cubit/profile_picture_cubit.dart';
import '../../../manager/profile_picture_cubit/profile_picture_state.dart';

class ProfilePictureButtonsWidget extends StatelessWidget {
  const ProfilePictureButtonsWidget({super.key});

  void _updateProfile(BuildContext context) {
    if (context.mounted) {
      // Update profile with the selected image
      context.read<ProfilePictureCubit>().updateProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePictureCubit, ProfilePictureState>(
      builder: (context, state) {
        final isLoading = state is ProfilePictureLoading;
        final hasError = state is ProfilePictureError;

        return Row(
          children: [
            // Skip Button
            Expanded(
              child: SizedBox(
                height: 58,
                child: CustomButton(
                  text: isLoading ? 'جاري الحفظ...' : 'تخطي',
                  onPressed: isLoading ? null : () => _updateProfile(context),
                  isOutlined: true,
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
                          Ionicons.arrow_forward_outline,
                          color: AppColors.primary,
                          size: 20,
                        ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Continue Button
            Expanded(
              child: SizedBox(
                height: 58,
                child: CustomButton(
                  text: isLoading
                      ? 'جاري الحفظ...'
                      : hasError
                          ? 'إعادة المحاولة'
                          : 'متابعة',
                  onPressed: isLoading ? null : () => _updateProfile(context),
                  isGradient: true,
                  icon: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Icon(
                          hasError
                              ? Ionicons.refresh_outline
                              : Ionicons.checkmark_outline,
                          color: Colors.white,
                          size: 20,
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
