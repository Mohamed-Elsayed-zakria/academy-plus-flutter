import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/empty_state.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock subscriptions data
    final subscriptions = [
      {
        'courseName': 'Advanced Programming',
        'instructor': 'Dr. Sarah Johnson',
        'startDate': '2024-01-15',
        'endDate': '2024-05-15',
        'status': 'active',
        'progress': 65,
      },
      {
        'courseName': 'Data Structures',
        'instructor': 'Dr. Michael Brown',
        'startDate': '2024-02-01',
        'endDate': '2024-06-01',
        'status': 'active',
        'progress': 40,
      },
      {
        'courseName': 'Web Development',
        'instructor': 'Dr. Emily Davis',
        'startDate': '2023-09-01',
        'endDate': '2024-01-01',
        'status': 'completed',
        'progress': 100,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.subscriptions),
      ),
      body: subscriptions.isEmpty
          ? EmptyState(
              icon: Ionicons.card_outline,
              message: AppLocalizations.noSubscriptions,
              subtitle: 'Subscribe to courses to see them here',
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: subscriptions.length,
              itemBuilder: (context, index) {
                final subscription = subscriptions[index];
                return _buildSubscriptionCard(context, subscription);
              },
            ),
    );
  }

  Widget _buildSubscriptionCard(
      BuildContext context, Map<String, dynamic> subscription) {
    final isActive = subscription['status'] == 'active';
    final progress = subscription['progress'] as int;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    subscription['courseName'] as String,
                    style: Theme.of(context).textTheme.titleLarge,
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
                        : AppColors.textTertiary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isActive
                          ? AppColors.accent.withValues(alpha: 0.3)
                          : AppColors.textTertiary.withValues(alpha: 0.3),
                      width: 0.5,
                    ),
                  ),
                  child: Text(
                    isActive ? AppLocalizations.active : AppLocalizations.completed,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isActive ? AppColors.accent : AppColors.textTertiary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Ionicons.person_outline,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  subscription['instructor'] as String,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Ionicons.calendar_outline,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  '${subscription['startDate']} - ${subscription['endDate']}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.progress,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      '$progress%',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
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
          ],
        ),
      ),
    );
  }
}
