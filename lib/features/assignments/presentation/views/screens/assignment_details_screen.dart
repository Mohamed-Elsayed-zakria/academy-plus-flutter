import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
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
            // Modern Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: statusColor.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
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
                  const SizedBox(height: 20),

                  // Assignment Icon with Glass Effect
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Ionicons.document_text_outline,
                      size: 32,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Assignment Title
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 12),

                  // Assignment Type and Subjects
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _getAssignmentTypeIcon(assignmentType),
                              size: 14,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _getAssignmentTypeText(assignmentType),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      ...subjects.map((subject) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.accent.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              subject,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.accent,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),

            // Modern Content Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Modern Info Cards Grid
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Due Date Card
                      _ModernInfoCard(
                        icon: Ionicons.calendar_outline,
                        label: 'تاريخ الاستحقاق',
                        value: dueDate,
                        color: AppColors.error,
                        isHighlighted: true,
                      ),
                      const SizedBox(height: 16),
                      
                      // Grade and Price Row
                      Row(
                        children: [
                          if (grade != null) ...[
                            Expanded(
                              child: _ModernInfoCard(
                                icon: Ionicons.star_outline,
                                label: 'الدرجة',
                                value: '$grade%',
                                color: AppColors.accent,
                              ),
                            ),
                            const SizedBox(width: 16),
                          ],
                          if (totalPrice > 0) ...[
                            Expanded(
                              child: _ModernInfoCard(
                                icon: Ionicons.card_outline,
                                label: 'السعر الإجمالي',
                                value: '${totalPrice.toStringAsFixed(0)} \$',
                                color: AppColors.info,
                              ),
                            ),
                          ],
                        ],
                      ),
                      
                      if (submittedDate != null) ...[
                        const SizedBox(height: 16),
                        _ModernInfoCard(
                          icon: Ionicons.checkmark_circle_outline,
                          label: 'تاريخ التسليم',
                          value: submittedDate,
                          color: AppColors.success,
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Modern Instructions Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Ionicons.information_circle_outline,
                              color: AppColors.primary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'التعليمات',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      _ModernInstructionItem(
                        icon: Ionicons.document_outline,
                        text: 'قم برفع ملف يحتوي على إجاباتك (PDF, Word, أو صور)',
                        color: AppColors.primary,
                      ),
                      const SizedBox(height: 16),
                      _ModernInstructionItem(
                        icon: Ionicons.calendar_outline,
                        text: 'تأكد من التسليم قبل الموعد النهائي',
                        color: AppColors.error,
                      ),
                      const SizedBox(height: 16),
                      _ModernInstructionItem(
                        icon: Ionicons.checkmark_circle_outline,
                        text: 'راجع الملف قبل الرفع',
                        color: AppColors.success,
                      ),
                      const SizedBox(height: 16),
                      _ModernInstructionItem(
                        icon: Ionicons.time_outline,
                        text: 'يمكنك رفع الملف في أي وقت قبل الموعد النهائي',
                        color: AppColors.info,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Modern Action Buttons
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      if (status == 'Pending' || status == 'In Progress') ...[
                        _ModernActionButton(
                          text: 'رفع التسليم',
                          onPressed: () {
                            // Upload submission
                          },
                          icon: Ionicons.cloud_upload_outline,
                          isPrimary: true,
                        ),
                        const SizedBox(height: 12),
                        _ModernActionButton(
                          text: 'تحميل المواد',
                          onPressed: () {
                            // Download materials
                          },
                          icon: Ionicons.download_outline,
                          isPrimary: false,
                        ),
                      ] else if (status == 'Submitted') ...[
                        _ModernActionButton(
                          text: 'عرض التسليم',
                          onPressed: () {
                            // View submission
                          },
                          icon: Ionicons.eye_outline,
                          isPrimary: true,
                        ),
                      ] else if (status == 'Graded') ...[
                        _ModernActionButton(
                          text: 'عرض التعليقات',
                          onPressed: () {
                            // View feedback
                          },
                          icon: Ionicons.chatbubble_outline,
                          isPrimary: true,
                        ),
                        const SizedBox(height: 12),
                        _ModernActionButton(
                          text: 'تحميل الشهادة',
                          onPressed: () {
                            // Download certificate
                          },
                          icon: Ionicons.trophy_outline,
                          isPrimary: false,
                        ),
                      ],
                    ],
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

class _ModernInfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool isHighlighted;

  const _ModernInfoCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isHighlighted 
            ? Border.all(color: color.withValues(alpha: 0.3), width: 1)
            : Border.all(color: color.withValues(alpha: 0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
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
          ),
        ],
      ),
    );
  }
}

class _ModernInstructionItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _ModernInstructionItem({
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
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
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 20,
              color: color,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModernActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData icon;
  final bool isPrimary;

  const _ModernActionButton({
    required this.text,
    required this.onPressed,
    required this.icon,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: isPrimary
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary,
                  AppColors.primary.withValues(alpha: 0.8),
                ],
              )
            : null,
        color: isPrimary ? null : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isPrimary
            ? null
            : Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
                width: 1,
              ),
        boxShadow: [
          BoxShadow(
            color: isPrimary
                ? AppColors.primary.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isPrimary ? Colors.white : AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                text,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isPrimary ? Colors.white : AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
