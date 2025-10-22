import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_toast.dart';
import '../../../../../core/utils/navigation_helper.dart';
import '../../../../../core/services/service_locator.dart';
import '../../manager/cubit/profile_picture_cubit.dart';
import '../../manager/cubit/profile_picture_state.dart';

class ProfilePictureScreen extends StatelessWidget {
  final Map<String, dynamic>? extraData;

  const ProfilePictureScreen({super.key, this.extraData});

  Future<void> _pickImage(
    ImageSource source,
    BuildContext context,
    ProfilePictureCubit cubit,
  ) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      cubit.updateProfileImage(File(pickedFile.path));
    }
  }

  void _showImageSourceDialog(BuildContext context, ProfilePictureCubit cubit) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textTertiary.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                children: [
                  Text(
                    'اختر مصدر الصورة',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => NavigationHelper.back(context),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceGrey.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Ionicons.close_outline,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Camera option
                  GestureDetector(
                    onTap: () {
                      print('ProfilePictureScreen: Camera option tapped');
                      NavigationHelper.back(context);
                      // Use a post-frame callback to ensure context is still valid
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        print(
                          'ProfilePictureScreen: Post-frame callback executed',
                        );
                        print(
                          'ProfilePictureScreen: Using passed cubit: $cubit',
                        );
                        _pickImage(ImageSource.camera, context, cubit);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceGrey.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Ionicons.camera_outline,
                              color: AppColors.primary,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'التقاط صورة',
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
                                ),
                                Text(
                                  'استخدم الكاميرا لالتقاط صورة جديدة',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Ionicons.chevron_forward_outline,
                            color: AppColors.textSecondary,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Gallery option
                  GestureDetector(
                    onTap: () {
                      print('ProfilePictureScreen: Gallery option tapped');
                      NavigationHelper.back(context);
                      // Use a post-frame callback to ensure context is still valid
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        print(
                          'ProfilePictureScreen: Post-frame callback executed',
                        );
                        print(
                          'ProfilePictureScreen: Using passed cubit: $cubit',
                        );
                        _pickImage(ImageSource.gallery, context, cubit);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceGrey.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Ionicons.images_outline,
                              color: AppColors.accent,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'اختيار من المعرض',
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
                                ),
                                Text(
                                  'اختر صورة من معرض الصور',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Ionicons.chevron_forward_outline,
                            color: AppColors.textSecondary,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _updateProfile(BuildContext context) {
    if (context.mounted) {
      // Update profile with the selected image
      context.read<ProfilePictureCubit>().updateProfile();
    }
  }

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
                  Center(
                    child: Column(
                      children: [
                        // App Logo
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Ionicons.school_outline,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Title
                        Text(
                          'الصورة الشخصية',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                        ),

                        const SizedBox(height: 8),

                        // Subtitle
                        Text(
                          'أضف صورتك الشخصية لإكمال ملفك الشخصي',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: AppColors.textSecondary),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Profile Picture Section
                  BlocBuilder<ProfilePictureCubit, ProfilePictureState>(
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
                        'ProfilePictureScreen: Current state: ${state.runtimeType}, profileImage: ${profileImage?.path}',
                      );
                      print(
                        'ProfilePictureScreen: Will show image: ${profileImage != null}',
                      );

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Profile Picture Display
                          GestureDetector(
                            onTap: () => _showImageSourceDialog(
                              context,
                              context.read<ProfilePictureCubit>(),
                            ),
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: profileImage != null
                                    ? Colors.transparent
                                    : AppColors.surfaceGrey.withValues(
                                        alpha: 0.3,
                                      ),
                                border: Border.all(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.3,
                                  ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Ionicons.camera_outline,
                                          size: 60,
                                          color: AppColors.textTertiary,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'اضغط لإضافة صورة',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
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
                          ),

                          const SizedBox(height: 32),

                          // Action Buttons
                          BlocBuilder<ProfilePictureCubit, ProfilePictureState>(
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
                                        text: isLoading
                                            ? 'جاري الحفظ...'
                                            : 'تخطي',
                                        onPressed: isLoading
                                            ? null
                                            : () {
                                                _updateProfile(context);
                                              },
                                        isOutlined: true,
                                        icon: isLoading
                                            ? const SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                        Color
                                                      >(AppColors.primary),
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
                                        onPressed: isLoading
                                            ? null
                                            : () {
                                                _updateProfile(context);
                                              },
                                        isGradient: true,
                                        icon: isLoading
                                            ? const SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                        Color
                                                      >(Colors.white),
                                                ),
                                              )
                                            : Icon(
                                                hasError
                                                    ? Ionicons.refresh_outline
                                                    : Ionicons
                                                          .checkmark_outline,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),

                          // Error message display
                          BlocBuilder<ProfilePictureCubit, ProfilePictureState>(
                            builder: (context, state) {
                              if (state is ProfilePictureError) {
                                return Container(
                                  margin: const EdgeInsets.only(top: 16),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColors.error.withValues(
                                      alpha: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: AppColors.error.withValues(
                                        alpha: 0.3,
                                      ),
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
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
                          ),
                        ],
                      );
                    },
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
