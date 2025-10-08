import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class CourseContentScreen extends StatelessWidget {
  final String courseId;

  const CourseContentScreen({
    super.key,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Course Content'),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            tabs: const [
              Tab(text: 'Midterm Lectures'),
              Tab(text: 'Final Lectures'),
              Tab(text: 'Midterm Exams'),
              Tab(text: 'Final Exams'),
              Tab(text: 'Attachments'),
              Tab(text: 'Test Yourself'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildLecturesList('midterm'),
            _buildLecturesList('final'),
            _buildExamsList('midterm'),
            _buildExamsList('final'),
            _buildAttachmentsList(),
            _buildTestYourselfSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildLecturesList(String type) {
    final lectures = List.generate(
      8,
      (index) => {
        'title': 'Lecture ${index + 1}',
        'duration': '45 min',
        'isWatched': index < 3,
      },
    );

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: lectures.length,
      itemBuilder: (context, index) {
        final lecture = lectures[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: lecture['isWatched'] as bool
                    ? AppColors.accent.withValues(alpha: 0.1)
                    : AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                lecture['isWatched'] as bool
                    ? Icons.check_circle
                    : Icons.play_circle_outline,
                color: lecture['isWatched'] as bool
                    ? AppColors.accent
                    : AppColors.primary,
              ),
            ),
            title: Text(
              lecture['title'] as String,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(lecture['duration'] as String),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.play_circle_outline,
                          size: 64,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Lecture description goes here. This is a detailed explanation of what will be covered in this lecture.',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExamsList(String type) {
    final exams = List.generate(
      4,
      (index) => {
        'title': 'Exam Solution ${index + 1}',
        'year': '2023',
      },
    );

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: exams.length,
      itemBuilder: (context, index) {
        final exam = exams[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.accentOrange.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.description,
                color: AppColors.accentOrange,
              ),
            ),
            title: Text(
              exam['title'] as String,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text('Year: ${exam['year']}'),
            trailing: Icon(Icons.download, color: AppColors.primary),
            onTap: () {
              // Open exam solution
            },
          ),
        );
      },
    );
  }

  Widget _buildAttachmentsList() {
    final attachments = [
      {'name': 'Lecture Notes.pdf', 'type': 'pdf', 'size': '2.5 MB'},
      {'name': 'Code Examples.zip', 'type': 'zip', 'size': '5.1 MB'},
      {'name': 'Presentation.pptx', 'type': 'pptx', 'size': '8.3 MB'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: attachments.length,
      itemBuilder: (context, index) {
        final attachment = attachments[index];
        IconData icon;
        Color color;

        switch (attachment['type']) {
          case 'pdf':
            icon = Icons.picture_as_pdf;
            color = AppColors.error;
            break;
          case 'zip':
            icon = Icons.folder_zip;
            color = AppColors.accentOrange;
            break;
          default:
            icon = Icons.insert_drive_file;
            color = AppColors.primary;
        }

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color),
            ),
            title: Text(
              attachment['name'] as String,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(attachment['size'] as String),
            trailing: Icon(Icons.download, color: AppColors.primary),
            onTap: () {
              // Download attachment
            },
          ),
        );
      },
    );
  }

  Widget _buildTestYourselfSection() {
    final quizzes = List.generate(
      5,
      (index) => {
        'title': 'Quiz ${index + 1}',
        'questions': 10,
        'duration': '15 min',
        'completed': index < 2,
      },
    );

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: quizzes.length,
      itemBuilder: (context, index) {
        final quiz = quizzes[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: quiz['completed'] as bool
                            ? AppColors.accent.withValues(alpha: 0.1)
                            : AppColors.accentPurple.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        quiz['completed'] as bool
                            ? Icons.check_circle
                            : Icons.quiz,
                        color: quiz['completed'] as bool
                            ? AppColors.accent
                            : AppColors.accentPurple,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            quiz['title'] as String,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${quiz['questions']} questions • ${quiz['duration']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
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
        );
      },
    );
  }
}
