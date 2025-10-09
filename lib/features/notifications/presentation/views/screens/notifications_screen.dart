import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/empty_state.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock notifications data
    final notifications = [
      {
        'title': 'New Course Available',
        'message': 'Check out the new Advanced Programming course!',
        'time': '2 hours ago',
        'isRead': false,
        'type': 'course',
      },
      {
        'title': 'Assignment Due Soon',
        'message': 'Your assignment is due in 2 days',
        'time': '5 hours ago',
        'isRead': false,
        'type': 'assignment',
      },
      {
        'title': 'New Lecture Added',
        'message': 'Lecture 5 has been added to your course',
        'time': '1 day ago',
        'isRead': true,
        'type': 'lecture',
      },
      {
        'title': 'Quiz Available',
        'message': 'A new quiz is ready for you to take',
        'time': '2 days ago',
        'isRead': true,
        'type': 'quiz',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {
              // Mark all as read
            },
            child: Text('Mark all read'),
          ),
        ],
      ),
      body: notifications.isEmpty
          ? EmptyState(
              icon: Ionicons.notifications_outline,
              message: 'No notifications yet',
              subtitle: 'We\'ll notify you when something new arrives',
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _buildNotificationCard(context, notification);
              },
            ),
    );
  }

  Widget _buildNotificationCard(
      BuildContext context, Map<String, dynamic> notification) {
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

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: notification['isRead'] as bool
          ? AppColors.surface
          : AppColors.primary.withValues(alpha: 0.05),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                notification['title'] as String,
                style: TextStyle(
                  fontWeight: notification['isRead'] as bool
                      ? FontWeight.normal
                      : FontWeight.w600,
                ),
              ),
            ),
            if (!(notification['isRead'] as bool))
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(notification['message'] as String),
            const SizedBox(height: 4),
            Text(
              notification['time'] as String,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        isThreeLine: true,
        onTap: () {
          // Handle notification tap
        },
      ),
    );
  }
}
