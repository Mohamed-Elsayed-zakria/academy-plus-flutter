import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/navigation_helper.dart';
import '../../data/models/course_model.dart';
import 'widgets/course_content_attachments_tab.dart';
import 'widgets/course_content_content_tab.dart';
import 'widgets/course_content_details_tab.dart';
import 'widgets/course_content_video_section.dart';

class CourseContentScreen extends StatefulWidget {
  final CourseModel course;

  const CourseContentScreen({
    super.key,
    required this.course,
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.course.titleAr),
          backgroundColor: AppColors.surface,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => NavigationHelper.back(context),
          ),
        ),
        body: Column(
          children: [
            // Course Video Section
            CourseContentVideoSection(
              course: widget.course,
            ),

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
                    course: widget.course,
                  ),
                  CourseContentContentTab(
                    course: widget.course,
                  ),
                  CourseContentAttachmentsTab(
                    course: widget.course,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}