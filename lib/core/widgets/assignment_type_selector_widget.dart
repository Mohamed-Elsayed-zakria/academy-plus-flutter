import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../core/constants/app_colors.dart';

enum AssignmentType {
  individual,
  team,
}

class AssignmentTypeSelectorWidget extends StatelessWidget {
  final AssignmentType? selectedType;
  final Function(AssignmentType?) onTypeChanged;
  final String label;
  final bool hasError;
  final String? errorText;

  const AssignmentTypeSelectorWidget({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
    required this.label,
    this.hasError = false,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        
        // Assignment Type Options
        Row(
          children: [
            // Individual Assignment
            Expanded(
              child: InkWell(
                onTap: () => onTypeChanged(AssignmentType.individual),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: selectedType == AssignmentType.individual
                        ? AppColors.primary.withValues(alpha: 0.1)
                        : AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selectedType == AssignmentType.individual
                          ? AppColors.primary
                          : AppColors.textTertiary,
                      width: selectedType == AssignmentType.individual ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Ionicons.person_outline,
                        color: selectedType == AssignmentType.individual
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'واجب فردي',
                        style: TextStyle(
                          color: selectedType == AssignmentType.individual
                              ? AppColors.primary
                              : AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'يعمل الطالب وحده',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(width: 12),
            
            // Team Assignment
            Expanded(
              child: InkWell(
                onTap: () => onTypeChanged(AssignmentType.team),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: selectedType == AssignmentType.team
                        ? AppColors.primary.withValues(alpha: 0.1)
                        : AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selectedType == AssignmentType.team
                          ? AppColors.primary
                          : AppColors.textTertiary,
                      width: selectedType == AssignmentType.team ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Ionicons.people_outline,
                        color: selectedType == AssignmentType.team
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'واجب فريق',
                        style: TextStyle(
                          color: selectedType == AssignmentType.team
                              ? AppColors.primary
                              : AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'يعمل الطلاب معاً',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        
        if (hasError && errorText != null) ...[
          const SizedBox(height: 8),
          Text(
            errorText!,
            style: TextStyle(
              color: AppColors.error,
              fontSize: 12,
            ),
          ),
        ],
        
        // Additional info based on selection
        if (selectedType != null) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: selectedType == AssignmentType.individual
                  ? AppColors.accent.withValues(alpha: 0.1)
                  : AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: selectedType == AssignmentType.individual
                    ? AppColors.accent.withValues(alpha: 0.3)
                    : AppColors.primary.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  selectedType == AssignmentType.individual
                      ? Ionicons.information_circle_outline
                      : Ionicons.people_outline,
                  color: selectedType == AssignmentType.individual
                      ? AppColors.accent
                      : AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    selectedType == AssignmentType.individual
                        ? 'الواجب الفردي يتطلب من كل طالب إنجاز المهمة بمفرده وتقديم حلول شخصية'
                        : 'الواجب الجماعي يتطلب من الطلاب العمل معاً في فريق وتقديم حلول مشتركة',
                    style: TextStyle(
                      fontSize: 12,
                      color: selectedType == AssignmentType.individual
                          ? AppColors.accent
                          : AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
