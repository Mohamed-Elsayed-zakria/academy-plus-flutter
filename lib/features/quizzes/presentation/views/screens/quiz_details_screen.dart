import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/utils/navigation_helper.dart';

class QuizDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> quiz;

  const QuizDetailsScreen({
    super.key,
    required this.quiz,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Available':
        return AppColors.success;
      case 'Completed':
        return AppColors.info;
      case 'Unavailable':
        return AppColors.textTertiary;
      default:
        return AppColors.textSecondary;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Available':
        return Ionicons.play_circle_outline;
      case 'Completed':
        return Ionicons.checkmark_circle_outline;
      case 'Unavailable':
        return Ionicons.lock_closed_outline;
      default:
        return Ionicons.help_circle_outline;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'Available':
        return 'متاح';
      case 'Completed':
        return 'مكتمل';
      case 'Unavailable':
        return 'غير متاح';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = quiz['status'] as String? ?? 'Available';
    final questions = quiz['questions'] as int? ?? 10;
    final duration = quiz['duration'] as int? ?? 30;
    final attempts = quiz['attempts'] as int? ?? 0;
    final bestScore = quiz['bestScore'] as int?;
    final subjects = quiz['subjects'] as List<String>? ?? [];
    final title = quiz['title'] as String? ?? 'اختبار جديد';
    final description = quiz['description'] as String? ?? 'لا يوجد وصف متاح';
    final deadline = quiz['deadline'] as String? ?? 'غير محدد';
    final totalPrice = quiz['totalPrice'] as double? ?? 0.0;
    final username = quiz['username'] as String?;
    final quizDate = quiz['quizDate'] as String?;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalizations.quizDetails),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Quiz Icon
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
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
                  // Status Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(status).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _getStatusColor(status).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getStatusIcon(status),
                          size: 16,
                          color: _getStatusColor(status),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _getStatusText(status),
                          style: TextStyle(
                            color: _getStatusColor(status),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Quiz Icon
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Ionicons.help_circle_outline,
                      size: 48,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Quiz Title
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  
                  // Subjects
                  if (subjects.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.textTertiary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        subjects.take(2).join('، ') + 
                        (subjects.length > 2 ? '...' : ''),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),

            // Quiz Info Cards
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
                            color: AppColors.textPrimary,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: subjects.map((subject) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Ionicons.book_outline,
                                    size: 16,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    subject,
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],

                  // Info Grid
                  Row(
                    children: [
                      Expanded(
                        child: _InfoCard(
                          icon: Ionicons.help_circle_outline,
                          label: 'الأسئلة',
                          value: '$questions',
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _InfoCard(
                          icon: Ionicons.time_outline,
                          label: 'المدة',
                          value: '$duration دقيقة',
                          color: AppColors.accentOrange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _InfoCard(
                          icon: Ionicons.refresh_outline,
                          label: 'المحاولات',
                          value: '$attempts',
                          color: AppColors.accentPurple,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _InfoCard(
                          icon: Ionicons.star_outline,
                          label: 'أفضل نتيجة',
                          value: bestScore != null ? '$bestScore%' : 'غير متاح',
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),

                  if (totalPrice > 0) ...[
                    const SizedBox(height: 16),
                    _InfoCard(
                      icon: Ionicons.card_outline,
                      label: 'السعر الإجمالي',
                      value: '${totalPrice.toStringAsFixed(0)} \$',
                      color: AppColors.accent,
                    ),
                  ],

                  if (quizDate != null) ...[
                    const SizedBox(height: 16),
                    _InfoCard(
                      icon: Ionicons.calendar_outline,
                      label: 'تاريخ الاختبار',
                      value: quizDate,
                      color: AppColors.info,
                    ),
                  ],

                  if (username != null) ...[
                    const SizedBox(height: 16),
                    _InfoCard(
                      icon: Ionicons.person_outline,
                      label: 'اسم المستخدم',
                      value: username,
                      color: AppColors.primary,
                    ),
                  ],

                  const SizedBox(height: 32),

                  // Description
                  if (description.isNotEmpty) ...[
                    Text(
                      'الوصف',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.textTertiary.withValues(alpha: 0.2),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        description,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.textPrimary,
                              height: 1.6,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],

                  // Instructions
                  Text(
                    'التعليمات',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 16),

                  _InstructionItem(
                    icon: Ionicons.time_outline,
                    text: 'لديك $duration دقيقة لإكمال الاختبار',
                  ),
                  const SizedBox(height: 12),
                  _InstructionItem(
                    icon: Ionicons.help_circle_outline,
                    text: 'يحتوي الاختبار على $questions سؤال',
                  ),
                  const SizedBox(height: 12),
                  _InstructionItem(
                    icon: Ionicons.lock_closed_outline,
                    text: 'لا يمكن إيقاف المؤقت',
                  ),
                  const SizedBox(height: 12),
                  _InstructionItem(
                    icon: Ionicons.checkmark_circle_outline,
                    text: 'راجع إجاباتك قبل التسليم',
                  ),

                  const SizedBox(height: 32),

                  // Deadline Warning
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.warning.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
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
                            color: AppColors.warning.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Ionicons.calendar_outline,
                            color: AppColors.warning,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'الموعد النهائي',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: AppColors.warning,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                deadline,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Action Buttons
                  if (status == 'Available') ...[
                    CustomButton(
                      text: attempts > 0 ? 'إعادة الاختبار' : 'بدء الاختبار',
                      onPressed: () {
                        _showStartConfirmation(context);
                      },
                      isGradient: true,
                      width: double.infinity,
                      icon: Icon(
                        attempts > 0 ? Ionicons.refresh_outline : Ionicons.play_outline,
                        color: Colors.white,
                      ),
                    ),
                    if (bestScore != null) ...[
                      const SizedBox(height: 12),
                      CustomButton(
                        text: 'عرض المحاولة السابقة',
                        onPressed: () {
                          // View previous attempt
                        },
                        isOutlined: true,
                        width: double.infinity,
                        icon: Icon(Ionicons.eye_outline, color: AppColors.primary),
                      ),
                    ],
                  ] else if (status == 'Completed') ...[
                    CustomButton(
                      text: 'عرض النتائج',
                      onPressed: () {
                        // View results
                      },
                      isGradient: true,
                      width: double.infinity,
                      icon: const Icon(Ionicons.bar_chart_outline, color: Colors.white),
                    ),
                  ] else if (status == 'Unavailable') ...[
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.textTertiary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Ionicons.lock_closed_outline,
                            color: AppColors.textTertiary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'الاختبار غير متاح حالياً',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                            ),
                          ),
                        ],
                      ),
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

  void _showStartConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Ionicons.information_circle_outline, color: AppColors.primary),
              const SizedBox(width: 12),
              Text(AppLocalizations.startQuiz),
            ],
          ),
          content: Text(
            AppLocalizations.areYouReadyStart,
          ),
          actions: [
            TextButton(
              onPressed: () => NavigationHelper.back(context),
              child: Text(AppLocalizations.cancel),
            ),
            ElevatedButton(
              onPressed: () {
                NavigationHelper.back(context);
                // Start quiz
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(AppLocalizations.start),
            ),
          ],
        );
      },
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _InstructionItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InstructionItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.textTertiary.withValues(alpha: 0.2),
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
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 20,
              color: AppColors.primary,
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
