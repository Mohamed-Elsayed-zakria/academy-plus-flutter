import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/constants/app_colors.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreenQuickAccessSection extends StatelessWidget {
  const HomeScreenQuickAccessSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildEnhancedQuickAccessCard(
                  context: context,
                  title: AppLocalizations.assignments,
                  subtitle: AppLocalizations.viewSubmit,
                  icon: Ionicons.clipboard_outline,
                  color: AppColors.primary,
                  gradient: AppColors.primaryGradient,
                  onTap: () {
                    context.push('/assignments');
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildEnhancedQuickAccessCard(
                  context: context,
                  title: AppLocalizations.quizzes,
                  subtitle: AppLocalizations.takeQuiz,
                  icon: Ionicons.school_outline,
                  color: AppColors.accent,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.accent,
                      AppColors.accent.withValues(alpha: 0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  onTap: () {
                    context.push('/quizzes');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedQuickAccessCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 135,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: color.withValues(alpha: 0.3),
                        width: 0.5,
                      ),
                    ),
                    child: Icon(icon, color: color, size: 24),
                  ),
                  const Spacer(),
                  Icon(Ionicons.arrow_forward_outline, color: color, size: 18),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
