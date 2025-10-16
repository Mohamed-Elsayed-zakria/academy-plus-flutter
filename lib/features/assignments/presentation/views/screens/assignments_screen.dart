import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../core/widgets/assignment_type_selector_widget.dart';
import '../../../../../core/utils/navigation_helper.dart';

class AssignmentsScreen extends StatefulWidget {
  const AssignmentsScreen({super.key});

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  // Mock assignments data - in real app this would come from a service
  List<Map<String, dynamic>> assignments = [
    {
      'id': '1',
      'title': 'واجب البرمجة المتقدمة',
      'description': 'إنشاء تطبيق ويب باستخدام Flutter و Firebase',
      'subjects': ['البرمجة المتقدمة', 'تطوير الويب'],
      'type': AssignmentType.individual,
      'status': 'In Progress',
      'dueDate': '25/12/2024',
      'totalPrice': 478.0,
      'createdDate': '2024-12-18T10:00:00Z',
      'grade': null,
      'submittedDate': null,
    },
    {
      'id': '2',
      'title': 'واجب قواعد البيانات',
      'description': 'تصميم قاعدة بيانات لمتجر إلكتروني',
      'subjects': ['قواعد البيانات', 'هياكل البيانات'],
      'type': AssignmentType.team,
      'status': 'Pending',
      'dueDate': '30/12/2024',
      'totalPrice': 428.0,
      'createdDate': '2024-12-15T14:30:00Z',
      'grade': null,
      'submittedDate': null,
    },
    {
      'id': '3',
      'title': 'واجب الذكاء الاصطناعي',
      'description': 'تطوير نموذج تعلم آلة للتعرف على الصور',
      'subjects': ['الذكاء الاصطناعي', 'الرياضيات'],
      'type': AssignmentType.individual,
      'status': 'Submitted',
      'dueDate': '20/12/2024',
      'totalPrice': 498.0,
      'createdDate': '2024-12-10T09:15:00Z',
      'grade': null,
      'submittedDate': '2024-12-19T16:45:00Z',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalizations.assignments),
        actions: [
          IconButton(
            icon: const Icon(Ionicons.filter_outline),
            onPressed: () {
              // Filter functionality
            },
          ),
        ],
      ),
      body: assignments.isEmpty
          ? const EmptyAssignmentsWidget()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: assignments.length,
              itemBuilder: (context, index) {
                final assignment = assignments[index];
                return _AssignmentCard(
                  assignment: assignment,
                  onTap: () {
                    NavigationHelper.to(
                      path: '/assignment/${assignment['id']}',
                      context: context,
                      data: assignment,
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationHelper.to(
            path: '/add-assignment',
            context: context,
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Ionicons.add, color: Colors.white),
      ),
    );
  }
}

class _AssignmentCard extends StatelessWidget {
  final Map<String, dynamic> assignment;
  final VoidCallback onTap;

  const _AssignmentCard({required this.assignment, required this.onTap});

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
        return Ionicons.time_outline;
      case 'Submitted':
        return Ionicons.checkmark_circle_outline;
      case 'Graded':
        return Ionicons.star_outline;
      default:
        return Ionicons.document_text_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = assignment['status'] as String;
    final statusColor = _getStatusColor(status);
    final dueDate = assignment['dueDate'] as String;
    final grade = assignment['grade'] as int?;
    final subjects = assignment['subjects'] as List<String>? ?? [];
    final assignmentType = assignment['type'] as AssignmentType?;
    final totalPrice = assignment['totalPrice'] as double? ?? 0.0;

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
              // Header: Status Badge & Assignment Type
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
                  if (assignmentType != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            assignmentType == AssignmentType.individual
                                ? Ionicons.person_outline
                                : Ionicons.people_outline,
                            size: 14,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            assignmentType == AssignmentType.individual
                                ? 'فردي'
                                : 'فريق',
                            style: TextStyle(
                              color: AppColors.primary,
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
                            Ionicons.star_outline,
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
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
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
                const SizedBox(height: 8),
              ],

              // Due Date & Price
              Row(
                children: [
                  Icon(
                    Ionicons.calendar_outline,
                    size: 16,
                    color: status == 'Pending' || status == 'In Progress'
                        ? AppColors.error
                        : AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Due: $dueDate',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: status == 'Pending' || status == 'In Progress'
                          ? AppColors.error
                          : AppColors.textSecondary,
                      fontWeight: status == 'Pending' || status == 'In Progress'
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                  const Spacer(),
                  if (totalPrice > 0) ...[
                    Icon(
                      Ionicons.card_outline,
                      size: 16,
                      color: AppColors.accent,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${totalPrice.toStringAsFixed(0)} \$',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
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
    );
  }
}
