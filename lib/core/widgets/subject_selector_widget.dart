import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../constants/app_colors.dart';
import '../localization/app_localizations.dart';

class SubjectSelectorWidget extends StatelessWidget {
  final String? selectedSubject;
  final VoidCallback onTap;
  final String label;
  final bool hasError;
  final String? errorText;

  const SubjectSelectorWidget({
    super.key,
    required this.selectedSubject,
    required this.onTap,
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
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: hasError ? AppColors.error : AppColors.textTertiary,
                width: hasError ? 2 : 1,
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
                  Ionicons.book_outline,
                  color: hasError ? AppColors.error : AppColors.textSecondary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    selectedSubject ?? AppLocalizations.selectSubject,
                    style: TextStyle(
                      color: selectedSubject != null 
                          ? AppColors.textPrimary 
                          : AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ),
                Icon(
                  Ionicons.chevron_down_outline,
                  color: hasError ? AppColors.error : AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
        if (hasError && errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            errorText!,
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
