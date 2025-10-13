import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:io';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/university_selector_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'John Doe');
  final _phoneController = TextEditingController(text: '+1 234 567 8900');
  final _emailController = TextEditingController(text: 'john.doe@example.com');
  File? _profileImage;
  String? _selectedUniversity = 'Cairo University';

  final List<String> _universities = [
    'Cairo University',
    'Alexandria University',
    'Ain Shams University',
    'Helwan University',
    'Mansoura University',
  ];

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
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalizations.editProfile),
      ),
      body: SingleChildScrollView(
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
                              : null,
                        ),
                        child: _profileImage == null
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
                AppLocalizations.tapToChangePicture,
                style: Theme.of(context).textTheme.bodySmall,
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
              const SizedBox(height: 16),
              CustomTextField(
                hintText: AppLocalizations.phoneNumber,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Ionicons.call_outline),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.pleaseEnterPhone;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: AppLocalizations.email,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Ionicons.mail_outline),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.pleaseEnterEmail;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              UniversitySelectorWidget(
                selectedUniversity: _selectedUniversity,
                onUniversitySelected: (university) {
                  setState(() {
                    _selectedUniversity = university;
                  });
                },
                label: AppLocalizations.selectUniversity,
                universities: _universities,
              ),
              const SizedBox(height: 32),

              // Save Button
              CustomButton(
                text: AppLocalizations.saveChanges,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save profile changes
                    context.pop();
                  }
                },
                isOutlined: true,
                width: double.infinity,
                icon: Icon(
                  Ionicons.checkmark_outline,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
