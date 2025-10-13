import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/empty_state_widget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Mock notifications data with Arabic content
  final List<Map<String, dynamic>> notifications = [
    {
      'title': AppLocalizations.newCourseAvailable,
      'message': AppLocalizations.checkNewCourse,
      'time': AppLocalizations.hoursAgo(2),
      'isRead': false,
      'type': 'course',
    },
    {
      'title': AppLocalizations.assignmentDueSoon,
      'message': AppLocalizations.assignmentDueMessage,
      'time': AppLocalizations.hoursAgo(5),
      'isRead': false,
      'type': 'assignment',
    },
    {
      'title': AppLocalizations.newLectureAdded,
      'message': AppLocalizations.lectureAddedMessage,
      'time': AppLocalizations.dayAgo,
      'isRead': true,
      'type': 'lecture',
    },
    {
      'title': AppLocalizations.quizAvailable,
      'message': AppLocalizations.quizReadyMessage,
      'time': AppLocalizations.daysAgo(2),
      'isRead': true,
      'type': 'quiz',
    },
  ];

  void _markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification['isRead'] = true;
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.markAllRead),
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _markAsRead(int index) {
    setState(() {
      notifications[index]['isRead'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          AppLocalizations.notifications,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (notifications.any((n) => !n['isRead']))
            TextButton(
              onPressed: _markAllAsRead,
              child: Text(
                AppLocalizations.markAllRead,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: notifications.isEmpty
          ? EmptyStateWidget(
              title: AppLocalizations.noNotifications,
              description: 'سنخبرك عندما يصل شيء جديد',
              buttonText: '',
              onButtonPressed: () {},
            )
          : Column(
              children: [
                // Header with count
                Container(
                  padding: const EdgeInsets.all(16),
                  color: AppColors.surface,
                  child: Row(
                    children: [
                      Icon(
                        Ionicons.notifications_outline,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${notifications.where((n) => !n['isRead']).length} إشعارات غير مقروءة',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Notifications list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      return _buildNotificationCard(context, notification, index);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildNotificationCard(
      BuildContext context, Map<String, dynamic> notification, int index) {
    IconData icon;
    Color iconColor;

    switch (notification['type']) {
      case 'course':
        icon = Ionicons.school_outline;
        iconColor = AppColors.primary;
        break;
      case 'assignment':
        icon = Ionicons.document_text_outline;
        iconColor = AppColors.accentOrange;
        break;
      case 'lecture':
        icon = Ionicons.play_circle_outline;
        iconColor = AppColors.accent;
        break;
      case 'quiz':
        icon = Ionicons.help_circle_outline;
        iconColor = AppColors.accentPurple;
        break;
      default:
        icon = Ionicons.notifications_outline;
        iconColor = AppColors.primary;
    }

    final isRead = notification['isRead'] as bool;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isRead ? 1 : 3,
      color: isRead ? AppColors.surface : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isRead ? AppColors.textTertiary.withValues(alpha: 0.2) : AppColors.primary.withValues(alpha: 0.2),
          width: isRead ? 0.5 : 1,
        ),
      ),
      child: InkWell(
        onTap: () => _markAsRead(index),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              
              const SizedBox(width: 12),
              
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title with unread indicator
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification['title'] as String,
                            style: TextStyle(
                              fontWeight: isRead ? FontWeight.w500 : FontWeight.w600,
                              color: AppColors.textPrimary,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        if (!isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    
                    const SizedBox(height: 6),
                    
                    // Message
                    Text(
                      notification['message'] as String,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Time
                    Row(
                      children: [
                        Icon(
                          Ionicons.time_outline,
                          size: 14,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          notification['time'] as String,
                          style: TextStyle(
                            color: AppColors.textTertiary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
