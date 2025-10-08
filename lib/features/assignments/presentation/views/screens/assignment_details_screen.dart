import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/custom_button.dart';

class AssignmentDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> assignment;

  const AssignmentDetailsScreen({
    super.key,
    required this.assignment,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return AppColors.warning;
      case 'Submitted':
        return AppColors.info;
      case 'Graded':
        return AppColors.success;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = assignment['status'] as String;
    final statusColor = _getStatusColor(status);
    final grade = assignment['grade'] as int?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignment Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section with Status
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    statusColor.withValues(alpha: 0.1),
                    statusColor.withValues(alpha: 0.05),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Assignment Title
                  Text(
                    assignment['title'] as String,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),

                  // Course
                  Text(
                    assignment['course'] as String,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),

            // Details Section
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info Cards
                  Row(
                    children: [
                      Expanded(
                        child: _InfoCard(
                          icon: Ionicons.calendar_outline,
                          label: 'Due Date',
                          value: assignment['dueDate'] as String,
                          color: AppColors.error,
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (grade != null)
                        Expanded(
                          child: _InfoCard(
                            icon: Ionicons.star_outline,
                            label: 'Grade',
                            value: '$grade%',
                            color: AppColors.accent,
                          ),
                        )
                      else
                        const Expanded(child: SizedBox()),
                    ],
                  ),

                  if (assignment['submittedDate'] != null) ...[
                    const SizedBox(height: 16),
                    _InfoCard(
                      icon: Ionicons.checkmark_circle_outline,
                      label: 'Submitted On',
                      value: assignment['submittedDate'] as String,
                      color: AppColors.info,
                    ),
                  ],

                  const SizedBox(height: 32),

                  // Description
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    assignment['description'] as String,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.6,
                        ),
                  ),

                  const SizedBox(height: 32),

                  // Instructions Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.info.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.info.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Ionicons.information_circle_outline,
                          color: AppColors.info,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Make sure to follow all guidelines and submit before the deadline.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.info,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Action Buttons
                  if (status == 'Pending') ...[
                    CustomButton(
                      text: 'Upload Submission',
                      onPressed: () {
                        // Upload submission
                      },
                      isGradient: true,
                      width: double.infinity,
                      icon: const Icon(Ionicons.cloud_upload_outline, color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    CustomButton(
                      text: 'Download Materials',
                      onPressed: () {
                        // Download materials
                      },
                      isOutlined: true,
                      width: double.infinity,
                      icon: Icon(Ionicons.download_outline, color: AppColors.primary),
                    ),
                  ] else if (status == 'Submitted') ...[
                    CustomButton(
                      text: 'View Submission',
                      onPressed: () {
                        // View submission
                      },
                      isGradient: true,
                      width: double.infinity,
                      icon: const Icon(Ionicons.eye_outline, color: Colors.white),
                    ),
                  ] else if (status == 'Graded') ...[
                    CustomButton(
                      text: 'View Feedback',
                      onPressed: () {
                        // View feedback
                      },
                      isGradient: true,
                      width: double.infinity,
                      icon: const Icon(Ionicons.chatbubble_outline, color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    CustomButton(
                      text: 'Download Certificate',
                      onPressed: () {
                        // Download certificate
                      },
                      isOutlined: true,
                      width: double.infinity,
                      icon: Icon(Ionicons.trophy_outline, color: AppColors.primary),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
        ],
      ),
    );
  }
}
