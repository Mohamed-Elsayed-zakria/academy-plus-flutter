import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../core/widgets/custom_button.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  // Mock subscriptions data with Arabic content
  final List<Map<String, dynamic>> subscriptions = [
    {
      'courseName': AppLocalizations.advancedProgramming,
      'instructor': AppLocalizations.drSarahJohnson,
      'startDate': '2024-01-15',
      'endDate': '2024-05-15',
      'status': 'active',
      'progress': 65,
      'type': 'programming',
    },
    {
      'courseName': AppLocalizations.dataStructures,
      'instructor': AppLocalizations.drMichaelBrown,
      'startDate': '2024-02-01',
      'endDate': '2024-06-01',
      'status': 'active',
      'progress': 40,
      'type': 'programming',
    },
    {
      'courseName': AppLocalizations.webDevelopment,
      'instructor': AppLocalizations.drEmilyDavis,
      'startDate': '2023-09-01',
      'endDate': '2024-01-01',
      'status': 'completed',
      'progress': 100,
      'type': 'web',
    },
  ];

  void _viewCourse(Map<String, dynamic> subscription) {
    // Navigate to course details
    // TODO: Implement navigation to course details
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          AppLocalizations.subscriptions,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Filter or search functionality
            },
            icon: const Icon(
              Ionicons.search_outline,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
      body: subscriptions.isEmpty
          ? EmptyStateWidget(
              title: AppLocalizations.noSubscriptions,
              description: 'اشترك في الكورسات لتراها هنا',
              buttonText: '',
              onButtonPressed: () {},
            )
          : Column(
              children: [
                // Header with stats
                Container(
                  padding: const EdgeInsets.all(16),
                  color: AppColors.surface,
                  child: Row(
                    children: [
                      _buildStatCard(
                        icon: Ionicons.school_outline,
                        title: '${subscriptions.length}',
                        subtitle: 'إجمالي الاشتراكات',
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 16),
                      _buildStatCard(
                        icon: Ionicons.play_circle_outline,
                        title: '${subscriptions.where((s) => s['status'] == 'active').length}',
                        subtitle: 'اشتراكات نشطة',
                        color: AppColors.accent,
                      ),
                      const SizedBox(width: 16),
                      _buildStatCard(
                        icon: Ionicons.checkmark_circle_outline,
                        title: '${subscriptions.where((s) => s['status'] == 'completed').length}',
                        subtitle: 'مكتملة',
                        color: AppColors.accent,
                      ),
                    ],
                  ),
                ),
                
                // Subscriptions list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: subscriptions.length,
                    itemBuilder: (context, index) {
                      final subscription = subscriptions[index];
                      return _buildSubscriptionCard(context, subscription);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard(
      BuildContext context, Map<String, dynamic> subscription) {
    final isActive = subscription['status'] == 'active';
    final progress = subscription['progress'] as int;
    final courseType = subscription['type'] as String;

    IconData courseIcon;
    Color courseColor;

    switch (courseType) {
      case 'programming':
        courseIcon = Ionicons.code_slash_outline;
        courseColor = AppColors.primary;
        break;
      case 'web':
        courseIcon = Ionicons.globe_outline;
        courseColor = AppColors.accentOrange;
        break;
      default:
        courseIcon = Ionicons.school_outline;
        courseColor = AppColors.primary;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive 
              ? AppColors.primary.withValues(alpha: 0.2)
              : AppColors.textTertiary.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with course name and status
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: courseColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(courseIcon, color: courseColor, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    subscription['courseName'] as String,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.accent.withValues(alpha: 0.1)
                        : AppColors.accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isActive
                          ? AppColors.accent.withValues(alpha: 0.3)
                          : AppColors.accent.withValues(alpha: 0.3),
                      width: 0.5,
                    ),
                  ),
                  child: Text(
                    isActive ? AppLocalizations.active : AppLocalizations.completed,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isActive ? AppColors.accent : AppColors.accent,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Instructor
            Row(
              children: [
                Icon(
                  Ionicons.person_outline,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Text(
                  subscription['instructor'] as String,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // Course duration
            Row(
              children: [
                Icon(
                  Ionicons.calendar_outline,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Text(
                  '${AppLocalizations.startDate}: ${subscription['startDate']}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 4),
            
            Row(
              children: [
                Icon(
                  Ionicons.calendar_outline,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Text(
                  '${AppLocalizations.endDate}: ${subscription['endDate']}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Progress section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.progress,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      '$progress%',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      width: 0.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress / 100,
                      backgroundColor: AppColors.surfaceGrey,
                      color: AppColors.primary,
                      minHeight: 8,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Action button
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: isActive ? AppLocalizations.continueLearning : AppLocalizations.viewCourse,
                onPressed: () => _viewCourse(subscription),
                isOutlined: !isActive,
                width: double.infinity,
                icon: Icon(
                  isActive ? Ionicons.play_outline : Ionicons.eye_outline,
                  color: isActive ? Colors.white : AppColors.primary,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
