import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/assignment_type_selector_widget.dart';

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
      case 'In Progress':
        return AppColors.primary;
      default:
        return AppColors.textSecondary;
    }
  }

  String _getAssignmentTypeText(AssignmentType? type) {
    switch (type) {
      case AssignmentType.individual:
        return 'واجب فردي';
      case AssignmentType.team:
        return 'واجب فريق';
      default:
        return 'غير محدد';
    }
  }

  IconData _getAssignmentTypeIcon(AssignmentType? type) {
    switch (type) {
      case AssignmentType.individual:
        return Ionicons.person_outline;
      case AssignmentType.team:
        return Ionicons.people_outline;
      default:
        return Ionicons.document_text_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = assignment['status'] as String? ?? 'In Progress';
    final statusColor = _getStatusColor(status);
    final grade = assignment['grade'] as int?;
    final assignmentType = assignment['type'] as AssignmentType?;
    final subjects = assignment['subjects'] as List<String>? ?? [];
    final title = assignment['title'] as String? ?? 'واجب جديد';
    final description = assignment['description'] as String? ?? 'لا يوجد وصف متاح';
    final dueDate = assignment['dueDate'] as String? ?? 'غير محدد';
    final submittedDate = assignment['submittedDate'] as String?;
    final totalPrice = assignment['totalPrice'] as double? ?? 0.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalizations.assignmentDetails),
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
                    title,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),

                  // Assignment Type
                  Row(
                    children: [
                      Icon(
                        _getAssignmentTypeIcon(assignmentType),
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _getAssignmentTypeText(assignmentType),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ],
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
                  // Subjects Section
                  if (subjects.isNotEmpty) ...[
                    Text(
                      'المواد المختارة',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Column(
                        children: subjects.map((subject) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                Icon(
                                  Ionicons.book_outline,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    subject,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: AppColors.textPrimary,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Info Cards
                  Row(
                    children: [
                      Expanded(
                        child: _InfoCard(
                          icon: Ionicons.calendar_outline,
                          label: 'تاريخ الاستحقاق',
                          value: dueDate,
                          color: AppColors.error,
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (grade != null)
                        Expanded(
                          child: _InfoCard(
                            icon: Ionicons.star_outline,
                            label: 'الدرجة',
                            value: '$grade%',
                            color: AppColors.accent,
                          ),
                        )
                      else
                        const Expanded(child: SizedBox()),
                    ],
                  ),

                  if (submittedDate != null) ...[
                    const SizedBox(height: 16),
                    _InfoCard(
                      icon: Ionicons.checkmark_circle_outline,
                      label: 'تاريخ التسليم',
                      value: submittedDate,
                      color: AppColors.info,
                    ),
                  ],

                  if (totalPrice > 0) ...[
                    const SizedBox(height: 16),
                    _InfoCard(
                      icon: Ionicons.card_outline,
                      label: 'السعر الإجمالي',
                      value: '${totalPrice.toStringAsFixed(0)} \$',
                      color: AppColors.accent,
                    ),
                  ],

                  const SizedBox(height: 32),

                  // Description
                  Text(
                    'الوصف',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
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
                            'تأكد من اتباع جميع الإرشادات والتسليم قبل الموعد النهائي.',
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
                  if (status == 'Pending' || status == 'In Progress') ...[
                    CustomButton(
                      text: 'رفع التسليم',
                      onPressed: () {
                        // Upload submission
                      },
                      isGradient: true,
                      width: double.infinity,
                      icon: const Icon(Ionicons.cloud_upload_outline, color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    CustomButton(
                      text: 'تحميل المواد',
                      onPressed: () {
                        // Download materials
                      },
                      isOutlined: true,
                      width: double.infinity,
                      icon: Icon(Ionicons.download_outline, color: AppColors.primary),
                    ),
                  ] else if (status == 'Submitted') ...[
                    CustomButton(
                      text: 'عرض التسليم',
                      onPressed: () {
                        // View submission
                      },
                      isGradient: true,
                      width: double.infinity,
                      icon: const Icon(Ionicons.eye_outline, color: Colors.white),
                    ),
                  ] else if (status == 'Graded') ...[
                    CustomButton(
                      text: 'عرض التعليقات',
                      onPressed: () {
                        // View feedback
                      },
                      isGradient: true,
                      width: double.infinity,
                      icon: const Icon(Ionicons.chatbubble_outline, color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    CustomButton(
                      text: 'تحميل الشهادة',
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
