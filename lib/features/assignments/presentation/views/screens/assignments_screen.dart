import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/app_colors.dart';

class AssignmentsScreen extends StatelessWidget {
  const AssignmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock assignments data
    final assignments = [
      {
        'id': 1,
        'title': 'Programming Assignment 1',
        'course': 'Advanced Programming',
        'dueDate': '2024-02-15',
        'status': 'Pending',
        'description': 'Implement a sorting algorithm and analyze its complexity.',
        'grade': null,
      },
      {
        'id': 2,
        'title': 'Database Design Project',
        'course': 'Database Systems',
        'dueDate': '2024-02-10',
        'status': 'Submitted',
        'description': 'Design and implement a database for an e-commerce system.',
        'submittedDate': '2024-02-08',
        'grade': null,
      },
      {
        'id': 3,
        'title': 'Web Development Task',
        'course': 'Web Development',
        'dueDate': '2024-01-30',
        'status': 'Graded',
        'description': 'Create a responsive landing page using modern CSS.',
        'submittedDate': '2024-01-28',
        'grade': 95,
      },
      {
        'id': 4,
        'title': 'Algorithm Analysis Report',
        'course': 'Data Structures',
        'dueDate': '2024-02-20',
        'status': 'Pending',
        'description': 'Write a detailed report analyzing time and space complexity.',
        'grade': null,
      },
      {
        'id': 5,
        'title': 'Mobile App Prototype',
        'course': 'Mobile Development',
        'dueDate': '2024-01-25',
        'status': 'Graded',
        'description': 'Design a mobile app prototype using Figma.',
        'submittedDate': '2024-01-24',
        'grade': 88,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Filter functionality
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: assignments.length,
        itemBuilder: (context, index) {
          final assignment = assignments[index];
          return _AssignmentCard(
            assignment: assignment,
            onTap: () {
              context.push('/assignment/${assignment['id']}', extra: assignment);
            },
          );
        },
      ),
    );
  }
}

class _AssignmentCard extends StatelessWidget {
  final Map<String, dynamic> assignment;
  final VoidCallback onTap;

  const _AssignmentCard({
    required this.assignment,
    required this.onTap,
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

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Pending':
        return Icons.pending_actions;
      case 'Submitted':
        return Icons.check_circle_outline;
      case 'Graded':
        return Icons.grade;
      default:
        return Icons.assignment;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = assignment['status'] as String;
    final statusColor = _getStatusColor(status);
    final dueDate = assignment['dueDate'] as String;
    final grade = assignment['grade'] as int?;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Status Badge & Course
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
                  const SizedBox(width: 8),
                  if (grade != null)
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
                            Icons.star,
                            size: 14,
                            color: AppColors.accent,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$grade%',
                            style: TextStyle(
                              color: AppColors.accent,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 12),

              // Assignment Title
              Text(
                assignment['title'] as String,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(height: 8),

              // Course Name
              Row(
                children: [
                  Icon(
                    Icons.book_outlined,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    assignment['course'] as String,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Due Date & Arrow
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: status == 'Pending'
                        ? AppColors.error
                        : AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Due: $dueDate',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: status == 'Pending'
                              ? AppColors.error
                              : AppColors.textSecondary,
                          fontWeight: status == 'Pending'
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.textTertiary,
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
