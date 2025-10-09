import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/custom_phone_input.dart';
import '../../../../../core/utils/navigation_helper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _selectedUniversity;
  bool _hasAttemptedSubmit = false;

  final List<String> _universities = [
    'Cairo University',
    'Alexandria University',
    'Ain Shams University',
    'Helwan University',
    'Mansoura University',
  ];

  @override
  void initState() {
    super.initState();
  }

  void _showUniversityPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _UniversityPickerBottomSheet(
        universities: _universities,
        selectedUniversity: _selectedUniversity,
        onUniversitySelected: (university) {
          setState(() {
            _selectedUniversity = university;
            _hasAttemptedSubmit = false; // Reset the attempt flag when university is selected
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              children: [
                const SizedBox(height: 60),
                
                // App Logo and Header Section
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
                      
                      // Welcome Text
                      Text(
                        AppStrings.appName,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 48),
                // Register Form Section
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            // Full Name Field
                            CustomTextField(
                              hintText: AppStrings.fullName,
                              controller: _nameController,
                              prefixIcon: const Icon(Ionicons.person_outline),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your full name';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 20),

                            // Password Field
                            CustomTextField(
                              hintText: AppStrings.password,
                              controller: _passwordController,
                              isPassword: true,
                              prefixIcon: const Icon(
                                Ionicons.lock_closed_outline,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 20),

                            // Confirm Password Field
                            CustomTextField(
                              hintText: AppStrings.confirmPassword,
                              controller: _confirmPasswordController,
                              isPassword: true,
                              prefixIcon: const Icon(
                                Ionicons.lock_closed_outline,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 20),

                            // Phone Number Field
                            CustomPhoneInput(
                              hintText: AppStrings.phoneNumber,
                              controller: _phoneController,
                              initialCountryCode: 'EG',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 20),

                            // University Selection
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.selectUniversity,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                GestureDetector(
                                  onTap: _showUniversityPicker,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.surface,
                                      borderRadius: BorderRadius.circular(12),
                                      border: _hasAttemptedSubmit && _selectedUniversity == null
                                          ? Border.all(color: AppColors.error, width: 1.5)
                                          : null,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.02),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Ionicons.school_outline,
                                          size: 18,
                                          color: _selectedUniversity != null
                                              ? AppColors.primary
                                              : AppColors.textSecondary,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            _selectedUniversity ?? 'اختر الجامعة',
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: _selectedUniversity != null
                                                  ? AppColors.textPrimary
                                                  : AppColors.textTertiary,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Ionicons.chevron_down_outline,
                                          size: 16,
                                          color: AppColors.textSecondary,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (_hasAttemptedSubmit && _selectedUniversity == null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      'Please select your university',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: AppColors.error,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                              ],
                            ),

                            const SizedBox(height: 32),

                            // Register Button
                            CustomButton(
                              text: AppStrings.register,
                              onPressed: () {
                                setState(() {
                                  _hasAttemptedSubmit = true;
                                });
                                
                                if (_formKey.currentState!.validate() && _selectedUniversity != null) {
                                  // Navigate to OTP screen first
                                  NavigationHelper.off(
                                    path: '/otp',
                                    context: context,
                                    data: {
                                      'phone': _phoneController.text,
                                      'isResetPassword': false,
                                    },
                                  );
                                }
                              },
                              isGradient: true,
                              width: double.infinity,
                              icon: const Icon(
                                Ionicons.person_add_outline,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),

                            const SizedBox(height: 32),

                            // Divider
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: AppColors.textTertiary.withValues(
                                      alpha: 0.3,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Text(
                                    'OR',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: AppColors.textTertiary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: AppColors.textTertiary.withValues(
                                      alpha: 0.3,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 32),

                            // Login Link
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  children: [
                                    const TextSpan(
                                      text: "Already have an account? ",
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: GestureDetector(
                                        onTap: () => NavigationHelper.off(
                                          path: '/login',
                                          context: context,
                                        ),
                                        child: Text(
                                          AppStrings.login,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UniversityPickerBottomSheet extends StatefulWidget {
  final List<String> universities;
  final String? selectedUniversity;
  final Function(String) onUniversitySelected;

  const _UniversityPickerBottomSheet({
    required this.universities,
    required this.selectedUniversity,
    required this.onUniversitySelected,
  });

  @override
  State<_UniversityPickerBottomSheet> createState() => _UniversityPickerBottomSheetState();
}

class _UniversityPickerBottomSheetState extends State<_UniversityPickerBottomSheet> {
  late List<String> _filteredUniversities;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredUniversities = widget.universities;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterUniversities(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredUniversities = widget.universities;
      } else {
        _filteredUniversities = widget.universities.where((university) {
          return university.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calculate dynamic height based on number of universities
    const double handleBarHeight = 28.0; // Handle bar + margins
    const double headerHeight = 64.0; // Header section
    const double searchBarHeight = 96.0; // Search bar section
    const double universityItemHeight = 64.0; // Each university item
    const double bottomPadding = 20.0; // Bottom padding
    const double maxHeightPercentage = 0.7; // Maximum 70% of screen height
    
    final double calculatedHeight = handleBarHeight + 
        headerHeight + 
        searchBarHeight + 
        (_filteredUniversities.length * universityItemHeight) + 
        bottomPadding;
    
    final double maxHeight = MediaQuery.of(context).size.height * maxHeightPercentage;
    final double dynamicHeight = calculatedHeight > maxHeight ? maxHeight : calculatedHeight;
    
    return Container(
      height: dynamicHeight,
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
                  'اختر الجامعة',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
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
          
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _searchController,
              onChanged: _filterUniversities,
              decoration: InputDecoration(
                hintText: 'ابحث عن الجامعة...',
                hintStyle: TextStyle(
                  color: AppColors.textTertiary,
                  fontSize: 14,
                ),
                prefixIcon: Icon(
                  Ionicons.search_outline,
                  color: AppColors.textSecondary,
                  size: 18,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          _filterUniversities('');
                        },
                        child: Icon(
                          Ionicons.close_circle_outline,
                          color: AppColors.textSecondary,
                          size: 18,
                        ),
                      )
                    : null,
                filled: true,
                fillColor: AppColors.surfaceGrey.withValues(alpha: 0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.primary, width: 1.5),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                isDense: true,
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Universities list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filteredUniversities.length,
              itemBuilder: (context, index) {
                final university = _filteredUniversities[index];
                final isSelected = university == widget.selectedUniversity;
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.08)
                        : AppColors.surfaceGrey.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                    border: isSelected
                        ? Border.all(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            width: 1,
                          )
                        : null,
                  ),
                  child: ListTile(
                    onTap: () => widget.onUniversitySelected(university),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 2,
                    ),
                    leading: Icon(
                      Ionicons.school_outline,
                      size: 20,
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textSecondary,
                    ),
                    title: Text(
                      university,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textPrimary,
                        fontSize: 14,
                      ),
                    ),
                    trailing: isSelected
                        ? Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Ionicons.checkmark,
                              color: Colors.white,
                              size: 14,
                            ),
                          )
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
