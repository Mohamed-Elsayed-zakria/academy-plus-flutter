import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../manager/profile_picture_cubit/profile_picture_cubit.dart';
import '../../../manager/profile_picture_cubit/profile_picture_state.dart';
import 'image_source_dialog_widget.dart';

class ProfilePictureDisplayWidget extends StatelessWidget {
  const ProfilePictureDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePictureCubit, ProfilePictureState>(
      builder: (context, state) {
        final profileImage = state is ProfilePictureInitial
            ? state.profileImage
            : state is ProfilePictureLoading
            ? state.profileImage
            : state is ProfilePictureSuccess
            ? state.profileImage
            : state is ProfilePictureError
            ? state.profileImage
            : null;

        print(
          'ProfilePictureDisplayWidget: Current state: ${state.runtimeType}, profileImage: ${profileImage?.path}',
        );
        print(
          'ProfilePictureDisplayWidget: Will show image: ${profileImage != null}',
        );

        return GestureDetector(
          onTap: () => _showImageSourceDialog(context),
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: profileImage != null
                  ? Colors.transparent
                  : AppColors.surfaceGrey.withValues(alpha: 0.3),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: profileImage == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Ionicons.camera_outline,
                        size: 60,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'اضغط لإضافة صورة',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  )
                : ClipOval(
                    child: Image.file(
                      profileImage,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        );
      },
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const ImageSourceDialogWidget(),
    );
  }
}
