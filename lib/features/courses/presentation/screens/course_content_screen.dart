import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations.dart';
import 'widgets/course_content_attachments_tab.dart';
import 'widgets/course_content_content_tab.dart';
import 'widgets/course_content_details_tab.dart';
import 'widgets/course_content_video_section.dart';

class CourseContentScreen extends StatefulWidget {
  final String courseId;
  final Map<String, dynamic>? courseData;

  const CourseContentScreen({
    super.key,
    required this.courseId,
    this.courseData,
  });

  @override
  State<CourseContentScreen> createState() => _CourseContentScreenState();
}

class _CourseContentScreenState extends State<CourseContentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use passed course data or mock data
    final course =
        widget.courseData ??
        {
          'nameAr': 'البرمجة المتقدمة',
          'nameEn': 'Advanced Programming',
          'instructor': 'Dr. Sarah Johnson',
          'description': 'Learn advanced programming concepts and techniques.',
          'price': 299.99,
          'discount': 20,
          'isSubscribed': false,
          'hasWhatsApp': true,
          'hasPaymentGateway': true,
        };

    final discountedPrice =
        (course['price'] as double) -
        ((course['price'] as double) * (course['discount'] as int) / 100);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(AppLocalizations.courseContent),
          backgroundColor: AppColors.surface,
          elevation: 0,
        ),
        body: Column(
          children: [
            // Course Video Section
            CourseContentVideoSection(),

            // TabBar
            Container(
              color: AppColors.surface,
              child: TabBar(
                controller: _tabController,
                indicatorColor: AppColors.primary,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                tabs: const [
                  Tab(text: 'التفاصيل'),
                  Tab(text: 'المحتوى'),
                  Tab(text: 'المرفقات'),
                ],
              ),
            ),

            // TabBarView
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  CourseContentDetailsTab(
                    course: course,
                    discountedPrice: discountedPrice,
                  ),
                  CourseContentContentTab(),
                  CourseContentAttachmentsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
