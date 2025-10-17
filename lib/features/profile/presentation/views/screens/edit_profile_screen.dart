import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/utils/navigation_helper.dart';
import '../../../data/repository/edit_profile_implement.dart';
import '../../manager/cubit/edit_profile_cubit.dart';
import '../../manager/cubit/edit_profile_state.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  File? _profileImage;
  String? _currentProfileImageUrl;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = EditProfileCubit(EditProfileImplement());
        // Load current profile data when the page opens
        cubit.loadCurrentProfile();
        return cubit;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(AppLocalizations.editProfile),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Ionicons.arrow_back_outline, color: AppColors.textPrimary),
            onPressed: () => NavigationHelper.back(context),
          ),
        ),
        body: BlocListener<EditProfileCubit, EditProfileState>(
          listener: (context, state) {
            if (state is EditProfileSuccess) {
              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('تم تحديث الملف الشخصي بنجاح'),
                  backgroundColor: Colors.green,
                ),
              );
              NavigationHelper.back(context);
            } else if (state is EditProfileError) {
              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('خطأ في تحديث الملف الشخصي: ${state.error}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<EditProfileCubit, EditProfileState>(
            builder: (context, state) {
              if (state is EditProfileLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is EditProfileError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Ionicons.warning_outline,
                        size: 64,
                        color: AppColors.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'خطأ في تحميل البيانات',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.error,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          context.read<EditProfileCubit>().loadCurrentProfile();
                        },
                        child: const Text('إعادة المحاولة'),
                      ),
                    ],
                  ),
                );
              } else if (state is EditProfileLoaded) {
                // Populate form with current data
                if (_nameController.text.isEmpty) {
                  _nameController.text = state.profile.name;
                  _currentProfileImageUrl = state.profile.profileImageUrl;
                }
                
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Profile Picture
                        Center(
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Stack(
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.surfaceGrey,
                                    border: Border.all(
                                      color: AppColors.primary,
                                      width: 3,
                                    ),
                                    image: _profileImage != null
                                        ? DecorationImage(
                                            image: FileImage(_profileImage!),
                                            fit: BoxFit.cover,
                                          )
                                        : _currentProfileImageUrl != null && _currentProfileImageUrl!.isNotEmpty
                                            ? DecorationImage(
                                                image: NetworkImage(_currentProfileImageUrl!),
                                                fit: BoxFit.cover,
                                                onError: (exception, stackTrace) {
                                                  // Handle image load error
                                                },
                                              )
                                            : null,
                                  ),
                                  child: _profileImage == null && (_currentProfileImageUrl == null || _currentProfileImageUrl!.isEmpty)
                                      ? Icon(
                                          Ionicons.person_outline,
                                          size: 60,
                                          color: AppColors.textTertiary,
                                        )
                                      : null,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 3,
                                      ),
                                    ),
                                    child: Icon(
                                      Ionicons.camera_outline,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'اضغط لتغيير الصورة',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Form Fields
                        CustomTextField(
                          hintText: AppLocalizations.fullName,
                          controller: _nameController,
                          prefixIcon: const Icon(Ionicons.person_outline),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.pleaseEnterFullName;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 32),

                        // Save Button
                        BlocBuilder<EditProfileCubit, EditProfileState>(
                          builder: (context, state) {
                            return CustomButton(
                              text: AppLocalizations.saveChanges,
                              onPressed: state is EditProfileLoading ? null : () {
                                if (_formKey.currentState!.validate()) {
                                  _saveProfile(context);
                                }
                              },
                              isOutlined: true,
                              width: double.infinity,
                              icon: state is EditProfileLoading 
                                  ? null 
                                  : Icon(
                                      Ionicons.checkmark_outline,
                                      color: AppColors.primary,
                                    ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
              
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  void _saveProfile(BuildContext context) {
    final name = _nameController.text.trim();
    
    // Update profile with image if available
    context.read<EditProfileCubit>().updateUserProfile(name, _profileImage);
  }
}
