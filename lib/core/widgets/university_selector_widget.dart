import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../constants/app_colors.dart';
import '../localization/app_localizations.dart';
import '../utils/navigation_helper.dart';
import 'custom_text_field.dart';
import '../../features/universities/data/models/university_model.dart';

class UniversitySelectorWidget extends StatefulWidget {
  final UniversityModel? selectedUniversity;
  final Function(UniversityModel) onUniversitySelected;
  final Function()? onTap;
  final String label;
  final bool hasError;
  final String? errorText;
  final List<UniversityModel> universities;
  final bool isLoading;

  const UniversitySelectorWidget({
    super.key,
    required this.selectedUniversity,
    required this.onUniversitySelected,
    required this.label,
    required this.universities,
    this.onTap,
    this.hasError = false,
    this.errorText,
    this.isLoading = false,
  });

  @override
  State<UniversitySelectorWidget> createState() => _UniversitySelectorWidgetState();
}

class _UniversitySelectorWidgetState extends State<UniversitySelectorWidget> {
  void _showUniversityPicker() {
    if (widget.isLoading) return;
    
    if (widget.onTap != null) {
      widget.onTap!();
    }
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _UniversityPickerBottomSheet(
        universities: widget.universities,
        selectedUniversity: widget.selectedUniversity,
        onUniversitySelected: widget.onUniversitySelected,
        isLoading: widget.isLoading,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _showUniversityPicker,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: widget.hasError ? AppColors.error : AppColors.textTertiary,
                width: widget.hasError ? 2 : 1,
              ),
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
                  color: widget.hasError 
                      ? AppColors.error 
                      : (widget.selectedUniversity != null 
                          ? AppColors.primary 
                          : AppColors.textSecondary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: widget.isLoading
                      ? Row(
                          children: [
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Loading universities...',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.textTertiary,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          widget.selectedUniversity?.nameEn ?? AppLocalizations.chooseUniversity,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: widget.selectedUniversity != null
                                ? AppColors.textPrimary
                                : AppColors.textTertiary,
                            fontSize: 14,
                          ),
                        ),
                ),
                Icon(
                  Ionicons.chevron_down_outline,
                  size: 16,
                  color: widget.hasError ? AppColors.error : AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
        if (widget.hasError && widget.errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            widget.errorText!,
            style: TextStyle(
              color: AppColors.error,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }
}

class _UniversityPickerBottomSheet extends StatefulWidget {
  final List<UniversityModel> universities;
  final UniversityModel? selectedUniversity;
  final Function(UniversityModel) onUniversitySelected;
  final bool isLoading;

  const _UniversityPickerBottomSheet({
    required this.universities,
    required this.selectedUniversity,
    required this.onUniversitySelected,
    this.isLoading = false,
  });

  @override
  State<_UniversityPickerBottomSheet> createState() => _UniversityPickerBottomSheetState();
}

class _UniversityPickerBottomSheetState extends State<_UniversityPickerBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<UniversityModel> _filteredUniversities = [];

  @override
  void initState() {
    super.initState();
    _filteredUniversities = widget.universities;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _filterUniversities(_searchController.text);
  }

  void _filterUniversities(String query) {
    setState(() {
      _filteredUniversities = widget.universities
          .where((university) =>
              university.nameEn.toLowerCase().contains(query.toLowerCase()) ||
              university.nameAr.contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textTertiary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Row(
              children: [
                Text(
                  AppLocalizations.chooseUniversity,
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

          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: _searchController,
              hintText: AppLocalizations.searchUniversityPlaceholder,
              prefixIcon: Icon(
                Ionicons.search_outline,
                color: AppColors.textSecondary,
                size: 18,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Universities list
          Expanded(
            child: widget.isLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Loading universities...',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _filteredUniversities.length,
                    itemBuilder: (context, index) {
                      final university = _filteredUniversities[index];
                      final isSelected = university.id == widget.selectedUniversity?.id;

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
                    onTap: () {
                      widget.onUniversitySelected(university);
                      NavigationHelper.back(context);
                    },
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
                      university.nameEn,
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
                    subtitle: university.nameAr.isNotEmpty
                        ? Text(
                            university.nameAr,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          )
                        : null,
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
