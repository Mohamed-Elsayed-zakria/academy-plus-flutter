import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../core/utils/navigation_helper.dart';

class QuizzesScreen extends StatefulWidget {
  const QuizzesScreen({super.key});

  @override
  State<QuizzesScreen> createState() => _QuizzesScreenState();
}

class _QuizzesScreenState extends State<QuizzesScreen> {
  // Mock quizzes data - in real app this would come from a service
  List<Map<String, dynamic>> quizzes = [
    {
      'id': '1',
      'title': 'اختبار البرمجة المتقدمة',
      'description': 'اختبار شامل في البرمجة المتقدمة وتطوير الويب - يرجى رفع ملف الإجابة',
      'subjects': ['البرمجة المتقدمة', 'تطوير الويب'],
      'status': 'Available',
      'bestScore': null,
      'deadline': '24/12/2024',
      'quizDate': '25/12/2024',
      'totalPrice': 478.0,
      'username': 'student123',
      'createdDate': '2024-12-18T10:00:00Z',
      'submissionType': 'file_upload',
    },
    {
      'id': '2',
      'title': 'اختبار قواعد البيانات',
      'description': 'اختبار في تصميم وإدارة قواعد البيانات - يرجى رفع ملف الإجابة',
      'subjects': ['قواعد البيانات', 'هياكل البيانات'],
      'status': 'Available',
      'bestScore': 85,
      'deadline': '29/12/2024',
      'quizDate': '30/12/2024',
      'totalPrice': 428.0,
      'username': 'student456',
      'createdDate': '2024-12-15T14:30:00Z',
      'submissionType': 'file_upload',
    },
    {
      'id': '3',
      'title': 'اختبار الذكاء الاصطناعي',
      'description': 'اختبار في مفاهيم الذكاء الاصطناعي والتعلم الآلي - يرجى رفع ملف الإجابة',
      'subjects': ['الذكاء الاصطناعي', 'الرياضيات'],
      'status': 'Completed',
      'bestScore': 92,
      'deadline': '19/12/2024',
      'quizDate': '20/12/2024',
      'totalPrice': 498.0,
      'username': 'student789',
      'createdDate': '2024-12-10T09:15:00Z',
      'submissionType': 'file_upload',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalizations.quizzes),
        actions: [
          IconButton(
            icon: const Icon(Ionicons.filter_outline),
            onPressed: () {
              // Filter functionality
            },
          ),
        ],
      ),
      body: quizzes.isEmpty
          ? const EmptyQuizzesWidget()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: quizzes.length,
              itemBuilder: (context, index) {
                final quiz = quizzes[index];
                return _QuizCard(
                  quiz: quiz,
                  onTap: () {
                    NavigationHelper.to(
                      path: '/quiz/${quiz['id']}',
                      context: context,
                      data: quiz,
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationHelper.to(
            path: '/add-quiz',
            context: context,
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Ionicons.add, color: Colors.white),
      ),
    );
  }
}

class _QuizCard extends StatelessWidget {
  final Map<String, dynamic> quiz;
  final VoidCallback onTap;

  const _QuizCard({
    required this.quiz,
    required this.onTap,
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
        return Ionicons.cloud_upload_outline;
      case 'Completed':
        return Ionicons.checkmark_circle_outline;
      case 'Unavailable':
        return Ionicons.lock_closed_outline;
      default:
        return Ionicons.document_text_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = quiz['status'] as String;
    final statusColor = _getStatusColor(status);
    final bestScore = quiz['bestScore'] as int?;
    final subjects = quiz['subjects'] as List<String>? ?? [];
    final totalPrice = quiz['totalPrice'] as double? ?? 0.0;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: status == 'Unavailable' ? null : onTap,
        borderRadius: BorderRadius.circular(16),
        child: Opacity(
          opacity: status == 'Unavailable' ? 0.6 : 1.0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Status Badge & Price
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getStatusIcon(status),
                            size: 14,
                            color: statusColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            status,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    if (totalPrice > 0) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Ionicons.card_outline,
                              size: 14,
                              color: AppColors.accent,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${totalPrice.toStringAsFixed(0)} \$',
                              style: TextStyle(
                                color: AppColors.accent,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    if (bestScore != null)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$bestScore%',
                          style: TextStyle(
                            color: AppColors.accent,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 12),

                // Quiz Title
                Text(
                  quiz['title'] as String,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),

                const SizedBox(height: 8),

                // Subjects
                if (subjects.isNotEmpty) ...[
                  Row(
                    children: [
                      Icon(
                        Ionicons.book_outline,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          subjects.take(2).join('، ') + 
                          (subjects.length > 2 ? '...' : ''),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],

                // Quiz Info Row
                Row(
                  children: [
                    _InfoChip(
                      icon: Ionicons.document_outline,
                      label: 'رفع ملف',
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 12),
                    _InfoChip(
                      icon: Ionicons.calendar_outline,
                      label: 'موعد نهائي',
                      color: AppColors.accentOrange,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Quiz Date & Deadline
                Row(
                  children: [
                    Icon(
                      Ionicons.calendar_outline,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'الموعد النهائي: ${quiz['deadline']}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    const Spacer(),
                    if (status != 'Unavailable')
                      Icon(
                        Ionicons.chevron_forward_outline,
                        size: 16,
                        color: AppColors.textTertiary,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
