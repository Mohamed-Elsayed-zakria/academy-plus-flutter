import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';

class CourseContentScreen extends StatefulWidget {
  final String courseId;

  const CourseContentScreen({super.key, required this.courseId});

  @override
  State<CourseContentScreen> createState() => _CourseContentScreenState();
}

class _CourseContentScreenState extends State<CourseContentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Track which sections are expanded
  final Map<String, bool> _expandedSections = {
    'midtermLectures': true,
    'finalLectures': false,
    'midtermExams': false,
    'finalExams': false,
    'attachments': false,
    'testYourself': false,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _toggleSection(String sectionKey) {
    setState(() {
      _expandedSections[sectionKey] = !_expandedSections[sectionKey]!;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.courseContent),
          backgroundColor: AppColors.surface,
          elevation: 0,
        ),
        body: Column(
          children: [
            // Course Image Section
            _buildCourseImageSection(),

            // TabBar
            Container(
              color: AppColors.surface,
              child: TabBar(
                controller: _tabController,
                indicatorColor: AppColors.primary,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                tabs: const [
                  Tab(text: 'Content'),
                  Tab(text: 'Details'),
                ],
              ),
            ),

            // TabBarView
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [_buildCourseContentTab(), _buildCourseDetailsTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseImageSection() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.8),
            AppColors.accent.withValues(alpha: 0.6),
          ],
        ),
      ),
      child: Image.network(
        'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=300&h=300&fit=crop',
        fit: BoxFit.fill,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.3),
                  AppColors.accent.withValues(alpha: 0.3),
                ],
              ),
            ),
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.3),
                  AppColors.accent.withValues(alpha: 0.3),
                ],
              ),
            ),
            child: const Icon(
              Ionicons.book_outline,
              color: Colors.white,
              size: 50,
            ),
          );
        },
      ),
    );
  }

  Widget _buildCourseDetailsTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCourseInfoSection(context),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildCourseContentTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // Midterm Lectures Section
          _buildSectionHeader(
            context: context,
            title: 'Midterm Lectures',
            icon: Ionicons.play_circle_outline,
            sectionKey: 'midtermLectures',
          ),
          if (_expandedSections['midtermLectures']!) ...[
            _buildLecturesList('midterm'),
            const SizedBox(height: 16),
          ],

          // Final Lectures Section
          _buildSectionHeader(
            context: context,
            title: 'Final Lectures',
            icon: Ionicons.play_circle_outline,
            sectionKey: 'finalLectures',
          ),
          if (_expandedSections['finalLectures']!) ...[
            _buildLecturesList('final'),
            const SizedBox(height: 16),
          ],

          // Midterm Exams Section
          _buildSectionHeader(
            context: context,
            title: 'Midterm Exams',
            icon: Ionicons.document_text_outline,
            sectionKey: 'midtermExams',
          ),
          if (_expandedSections['midtermExams']!) ...[
            _buildExamsList('midterm'),
            const SizedBox(height: 16),
          ],

          // Final Exams Section
          _buildSectionHeader(
            context: context,
            title: 'Final Exams',
            icon: Ionicons.document_text_outline,
            sectionKey: 'finalExams',
          ),
          if (_expandedSections['finalExams']!) ...[
            _buildExamsList('final'),
            const SizedBox(height: 16),
          ],

          // Attachments Section
          _buildSectionHeader(
            context: context,
            title: 'Attachments',
            icon: Ionicons.attach_outline,
            sectionKey: 'attachments',
          ),
          if (_expandedSections['attachments']!) ...[
            _buildAttachmentsList(),
            const SizedBox(height: 16),
          ],

          // Test Yourself Section
          _buildSectionHeader(
            context: context,
            title: 'Test Yourself',
            icon: Ionicons.help_circle_outline,
            sectionKey: 'testYourself',
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

  Widget _buildCourseInfoSection(BuildContext context) {
    // Mock course data
    final courseData = {
      'title': 'Introduction to Computer Science',
      'instructor': 'Dr. Ahmed Hassan',
      'duration': '16 weeks',
      'credits': '3 credits',
      'level': 'Beginner',
      'rating': 4.8,
      'students': 1250,
      'description':
          'This course provides a comprehensive introduction to computer science fundamentals including programming concepts, data structures, and algorithms.',
    };

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course Title
          Text(
            courseData['title'] as String,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 12),

          // Instructor
          _buildInfoRow(
            icon: Ionicons.person_outline,
            label: 'Instructor',
            value: courseData['instructor'] as String,
            color: AppColors.primary,
          ),

          const SizedBox(height: 8),

          // Duration
          _buildInfoRow(
            icon: Ionicons.time_outline,
            label: 'Duration',
            value: courseData['duration'] as String,
            color: AppColors.accent,
          ),

          const SizedBox(height: 8),

          // Level
          _buildInfoRow(
            icon: Ionicons.trending_up_outline,
            label: 'Level',
            value: courseData['level'] as String,
            color: AppColors.accentPurple,
          ),

          const SizedBox(height: 12),

          // Rating and Students
          Row(
            children: [
              // Rating
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Ionicons.star, color: AppColors.accent, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${courseData['rating']}',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Students Count
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.info.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Ionicons.people_outline,
                      color: AppColors.info,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${courseData['students']} students',
                      style: TextStyle(
                        color: AppColors.info,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Description
          Text(
            'Description',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            courseData['description'] as String,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader({
    required BuildContext context,
    required String title,
    required IconData icon,
    required String sectionKey,
  }) {
    final isExpanded = _expandedSections[sectionKey]!;

    return GestureDetector(
      onTap: () => _toggleSection(sectionKey),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
            AnimatedRotation(
              turns: isExpanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                Ionicons.chevron_down_outline,
                color: AppColors.primary,
                size: 20,
              ),
            ),
          ],
        ),
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
