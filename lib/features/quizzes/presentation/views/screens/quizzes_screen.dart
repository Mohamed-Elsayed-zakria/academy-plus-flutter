import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';

class QuizzesScreen extends StatelessWidget {
  const QuizzesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock quizzes data
    final quizzes = [
      {
        'id': 1,
        'title': 'Programming Fundamentals Quiz',
        'course': 'Advanced Programming',
        'questions': 20,
        'duration': 30, // minutes
        'status': 'Available',
        'attempts': 0,
        'bestScore': null,
        'deadline': '2024-02-18',
      },
      {
        'id': 2,
        'title': 'Database Concepts Test',
        'course': 'Database Systems',
        'questions': 15,
        'duration': 25,
        'status': 'Completed',
        'attempts': 2,
        'bestScore': 85,
        'deadline': '2024-02-05',
      },
      {
        'id': 3,
        'title': 'CSS & HTML Assessment',
        'course': 'Web Development',
        'questions': 25,
        'duration': 40,
        'status': 'Available',
        'attempts': 1,
        'bestScore': 78,
        'deadline': '2024-02-22',
      },
      {
        'id': 4,
        'title': 'Data Structures Quiz',
        'course': 'Data Structures',
        'questions': 30,
        'duration': 45,
        'status': 'Unavailable',
        'attempts': 0,
        'bestScore': null,
        'deadline': '2024-03-01',
      },
      {
        'id': 5,
        'title': 'Flutter Basics Quiz',
        'course': 'Mobile Development',
        'questions': 18,
        'duration': 30,
        'status': 'Completed',
        'attempts': 1,
        'bestScore': 92,
        'deadline': '2024-01-28',
      },
    ];

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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          final quiz = quizzes[index];
          return _QuizCard(
            quiz: quiz,
            onTap: () {
              context.push('/quiz/${quiz['id']}', extra: quiz);
            },
          );
        },
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
        return Ionicons.play_circle_outline;
      case 'Completed':
        return Ionicons.checkmark_circle_outline;
      case 'Unavailable':
        return Ionicons.lock_closed_outline;
      default:
        return Ionicons.help_circle_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = quiz['status'] as String;
    final statusColor = _getStatusColor(status);
    final questions = quiz['questions'] as int;
    final duration = quiz['duration'] as int;
    final attempts = quiz['attempts'] as int;
    final bestScore = quiz['bestScore'] as int?;

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
                // Header: Status Badge
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

                // Course Name
                Row(
                  children: [
                    Icon(
                      Ionicons.book_outline,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      quiz['course'] as String,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Quiz Info Row
                Row(
                  children: [
                    _InfoChip(
                      icon: Ionicons.help_circle_outline,
                      label: '$questions questions',
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 12),
                    _InfoChip(
                      icon: Ionicons.time_outline,
                      label: '$duration min',
                      color: AppColors.accentOrange,
                    ),
                    if (attempts > 0) ...[
                      const SizedBox(width: 12),
                      _InfoChip(
                        icon: Ionicons.refresh_outline,
                        label: '$attempts ${attempts == 1 ? 'attempt' : 'attempts'}',
                        color: AppColors.accentPurple,
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 12),

                // Deadline
                Row(
                  children: [
                    Icon(
                      Ionicons.calendar_outline,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Deadline: ${quiz['deadline']}',
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
