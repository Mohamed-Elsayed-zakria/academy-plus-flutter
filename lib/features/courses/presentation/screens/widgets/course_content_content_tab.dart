import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/premium_content_overlay.dart';
import 'course_content_section_header.dart';

class CourseContentContentTab extends StatefulWidget {
  const CourseContentContentTab({super.key});

  @override
  State<CourseContentContentTab> createState() => _CourseContentContentTabState();
}

class _CourseContentContentTabState extends State<CourseContentContentTab> {
  // Track which sections are expanded
  final Map<String, bool> _expandedSections = {
    'midtermLectures': true,
    'finalLectures': false,
    'midtermExams': false,
    'finalExams': false,
    'testYourself': false,
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

          // Midterm Lectures Section
          CourseContentSectionHeader(
            title: 'Midterm Lectures',
            icon: Ionicons.play_circle_outline,
            sectionKey: 'midtermLectures',
            isExpanded: _expandedSections['midtermLectures']!,
            onToggle: () => _toggleSection('midtermLectures'),
          ),
          if (_expandedSections['midtermLectures']!) ...[
            _buildLecturesList('midterm'),
            const SizedBox(height: 16),
          ],

          // Final Lectures Section
          CourseContentSectionHeader(
            title: 'Final Lectures',
            icon: Ionicons.play_circle_outline,
            sectionKey: 'finalLectures',
            isExpanded: _expandedSections['finalLectures']!,
            onToggle: () => _toggleSection('finalLectures'),
          ),
          if (_expandedSections['finalLectures']!) ...[
            _buildLecturesList('final'),
            const SizedBox(height: 16),
          ],

          // Midterm Exams Section
          CourseContentSectionHeader(
            title: 'Midterm Exams',
            icon: Ionicons.document_text_outline,
            sectionKey: 'midtermExams',
            isExpanded: _expandedSections['midtermExams']!,
            onToggle: () => _toggleSection('midtermExams'),
          ),
          if (_expandedSections['midtermExams']!) ...[
            _buildExamsList('midterm'),
            const SizedBox(height: 16),
          ],

          // Final Exams Section
          CourseContentSectionHeader(
            title: 'Final Exams',
            icon: Ionicons.document_text_outline,
            sectionKey: 'finalExams',
            isExpanded: _expandedSections['finalExams']!,
            onToggle: () => _toggleSection('finalExams'),
          ),
          if (_expandedSections['finalExams']!) ...[
            _buildExamsList('final'),
            const SizedBox(height: 16),
          ],

          // Test Yourself Section
          CourseContentSectionHeader(
            title: 'Test Yourself',
            icon: Ionicons.help_circle_outline,
            sectionKey: 'testYourself',
            isExpanded: _expandedSections['testYourself']!,
            onToggle: () => _toggleSection('testYourself'),
          ),
          if (_expandedSections['testYourself']!) ...[
            _buildTestYourselfSection(),
            const SizedBox(height: 16),
          ],

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildLecturesList(String type) {
    final lectures = List.generate(
      4, // Reduced for better UX
      (index) => {
        'title':
            '${type[0].toUpperCase()}${type.substring(1)} Lecture ${index + 1}',
        'duration': '45 min',
        'isWatched': index < 2,
      },
    );

    return Column(
      children: lectures.map((lecture) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ExpansionTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: lecture['isWatched'] as bool
                      ? AppColors.accent.withValues(alpha: 0.1)
                      : AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  lecture['isWatched'] as bool
                      ? Ionicons.checkmark_circle
                      : Ionicons.play_circle_outline,
                  color: lecture['isWatched'] as bool
                      ? AppColors.accent
                      : AppColors.primary,
                  size: 20,
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
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Icon(
                            Ionicons.play_circle_outline,
                            size: 48,
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
          ),
        );
      }).toList(),
    );
  }

  Widget _buildExamsList(String type) {
    final exams = List.generate(
      3, // Reduced for better UX
      (index) => {
        'title':
            '${type[0].toUpperCase()}${type.substring(1)} Exam Solution ${index + 1}',
        'year': '2023',
      },
    );

    return Column(
      children: exams.map((exam) {
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
                  color: AppColors.accentOrange.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Ionicons.document_text_outline,
                  color: AppColors.accentOrange,
                  size: 20,
                ),
              ),
              title: Text(
                exam['title'] as String,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text('${AppLocalizations.year} ${exam['year']}'),
              trailing: Icon(
                Ionicons.download_outline,
                color: AppColors.primary,
              ),
              onTap: () {
                // Open exam solution
              },
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTestYourselfSection() {
    final quizzes = List.generate(
      3, // Reduced for better UX
      (index) => {
        'title': 'Quiz ${index + 1}',
        'questions': 10,
        'duration': '15 min',
        'completed': index < 1,
      },
    );

    return Column(
      children: quizzes.map((quiz) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: quiz['completed'] as bool
                          ? AppColors.accent.withValues(alpha: 0.1)
                          : AppColors.accentPurple.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      quiz['completed'] as bool
                          ? Ionicons.checkmark_circle
                          : Ionicons.help_circle_outline,
                      color: quiz['completed'] as bool
                          ? AppColors.accent
                          : AppColors.accentPurple,
                      size: 20,
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
                    Ionicons.chevron_forward_outline,
                    size: 16,
                    color: AppColors.textTertiary,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
