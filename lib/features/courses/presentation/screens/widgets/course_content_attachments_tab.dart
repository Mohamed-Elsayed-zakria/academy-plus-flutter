import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/premium_content_overlay.dart';
import 'course_content_section_header.dart';

class CourseContentAttachmentsTab extends StatefulWidget {
  const CourseContentAttachmentsTab({super.key});

  @override
  State<CourseContentAttachmentsTab> createState() => _CourseContentAttachmentsTabState();
}

class _CourseContentAttachmentsTabState extends State<CourseContentAttachmentsTab> {
  // Track which sections are expanded
  final Map<String, bool> _expandedSections = {
    'attachments': false,
  };

  void _toggleSection(String sectionKey) {
    setState(() {
      _expandedSections[sectionKey] = !_expandedSections[sectionKey]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // Premium Content Overlay
          PremiumContentOverlay(),

          // Attachments Section
          CourseContentSectionHeader(
            title: 'Attachments',
            icon: Ionicons.attach_outline,
            sectionKey: 'attachments',
            isExpanded: _expandedSections['attachments']!,
            onToggle: () => _toggleSection('attachments'),
          ),
          if (_expandedSections['attachments']!) ...[
            _buildAttachmentsList(),
            const SizedBox(height: 16),
          ],

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildAttachmentsList() {
    final attachments = [
      {'name': 'Lecture Notes.pdf', 'type': 'pdf', 'size': '2.5 MB'},
      {'name': 'Code Examples.zip', 'type': 'zip', 'size': '5.1 MB'},
      {'name': 'Presentation.pptx', 'type': 'pptx', 'size': '8.3 MB'},
    ];

    return Column(
      children: attachments.map((attachment) {
        IconData icon;
        Color color;

        switch (attachment['type']) {
          case 'pdf':
            icon = Ionicons.document_text_outline;
            color = AppColors.error;
            break;
          case 'zip':
            icon = Ionicons.archive_outline;
            color = AppColors.accentOrange;
            break;
          default:
            icon = Ionicons.document_outline;
            color = AppColors.primary;
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              title: Text(
                attachment['name'] as String,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(attachment['size'] as String),
              trailing: Icon(
                Ionicons.download_outline,
                color: AppColors.primary,
              ),
              onTap: () {
                // Download attachment
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
