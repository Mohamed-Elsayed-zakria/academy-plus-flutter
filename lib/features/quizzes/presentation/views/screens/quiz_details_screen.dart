import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/custom_button.dart';

class QuizDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> quiz;

  const QuizDetailsScreen({
    super.key,
    required this.quiz,
  });

  @override
  Widget build(BuildContext context) {
    final status = quiz['status'] as String;
    final questions = quiz['questions'] as int;
    final duration = quiz['duration'] as int;
    final attempts = quiz['attempts'] as int;
    final bestScore = quiz['bestScore'] as int?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Quiz Icon
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Icon(
                      Ionicons.help_circle_outline,
                      size: 64,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    quiz['title'] as String,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    quiz['course'] as String,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
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
                  // Info Grid
                  Row(
                    children: [
                      Expanded(
                        child: _InfoCard(
                          icon: Ionicons.help_circle_outline,
                          label: 'Questions',
                          value: '$questions',
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _InfoCard(
                          icon: Ionicons.time_outline,
                          label: 'Duration',
                          value: '$duration min',
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
                          label: 'Attempts',
                          value: '$attempts',
                          color: AppColors.accentPurple,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _InfoCard(
                          icon: Ionicons.star_outline,
                          label: 'Best Score',
                          value: bestScore != null ? '$bestScore%' : 'N/A',
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Instructions
                  Text(
                    'Instructions',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),

                  _InstructionItem(
                    icon: Ionicons.time_outline,
                    text: 'You have $duration minutes to complete the quiz.',
                  ),
                  const SizedBox(height: 12),
                  _InstructionItem(
                    icon: Ionicons.help_circle_outline,
                    text: 'The quiz contains $questions questions.',
                  ),
                  const SizedBox(height: 12),
                  _InstructionItem(
                    icon: Ionicons.lock_closed_outline,
                    text: 'Once started, the timer cannot be paused.',
                  ),
                  const SizedBox(height: 12),
                  _InstructionItem(
                    icon: Ionicons.checkmark_circle_outline,
                    text: 'Review your answers before submitting.',
                  ),

                  const SizedBox(height: 32),

                  // Deadline Warning
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.warning.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Ionicons.calendar_outline,
                          color: AppColors.warning,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Deadline',
                                style: TextStyle(
                                  color: AppColors.warning,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                quiz['deadline'] as String,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.textSecondary,
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
                      text: attempts > 0 ? 'Retake Quiz' : 'Start Quiz',
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
                        text: 'View Previous Attempt',
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
                      text: 'View Results',
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
                              'This quiz is not yet available',
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
              const Text('Start Quiz'),
            ],
          ),
          content: const Text(
            'Are you ready to start the quiz? The timer will begin immediately.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Start quiz
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Start'),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
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
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ),
      ],
    );
  }
}
