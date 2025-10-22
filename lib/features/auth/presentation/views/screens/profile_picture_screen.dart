import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/custom_toast.dart';
import '../../../../../core/utils/navigation_helper.dart';
import '../../../../../core/services/service_locator.dart';
import '../../manager/profile_picture_cubit/profile_picture_cubit.dart';
import '../../manager/profile_picture_cubit/profile_picture_state.dart';
import '../widgets/profile_picture_screen/profile_picture_screen_widgets.dart';

class ProfilePictureScreen extends StatelessWidget {
  final Map<String, dynamic>? extraData;

  const ProfilePictureScreen({super.key, this.extraData});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SetupLocator.locator<ProfilePictureCubit>(),
      child: BlocListener<ProfilePictureCubit, ProfilePictureState>(
        listener: (context, state) {
          if (!context.mounted) return;

          if (state is ProfilePictureSuccess) {
            // Navigate to home screen
            NavigationHelper.off(path: '/main', context: context);
          } else if (state is ProfilePictureError) {
            // Show error toast
            CustomToast.showError(context, message: state.error);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                children: [
                  const SizedBox(height: 60),

                  // Header Section
                  const ProfilePictureHeaderWidget(),
                  const SizedBox(height: 30),

                  // Profile Picture Section
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Profile Picture Display
                        const ProfilePictureDisplayWidget(),

                        const SizedBox(height: 32),

                        // Action Buttons
                        const ProfilePictureButtonsWidget(),

                        // Error message display
                        const ProfilePictureErrorWidget(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
