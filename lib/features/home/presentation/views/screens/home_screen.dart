import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:university/features/home/presentation/views/widgets/home_screen_banner_slider.dart';
import 'package:university/features/home/presentation/views/widgets/home_screen_departments_tapbar.dart';
import 'package:university/features/home/presentation/views/widgets/home_screen_quick_access_section.dart';
import 'package:university/features/home/presentation/views/widgets/home_screen_search_bar.dart';
import 'package:university/features/home/presentation/views/widgets/home_screen_sub_departments_grid.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  // Main Departments
  final List<Map<String, dynamic>> _departments = [
    {
      'id': 1,
      'name': 'Business',
      'icon': Ionicons.briefcase_outline,
      'subDepartments': ['Accounting', 'Marketing', 'Finance', 'HR'],
    },
    {
      'id': 2,
      'name': 'Engineering',
      'icon': Ionicons.construct_outline,
      'subDepartments': [
        'Computer Science',
        'Electrical',
        'Mechanical',
        'Civil',
      ],
    },
    {
      'id': 3,
      'name': 'Medicine',
      'icon': Ionicons.medical_outline,
      'subDepartments': [
        'General Medicine',
        'Surgery',
        'Pediatrics',
        'Cardiology',
      ],
    },
    {
      'id': 4,
      'name': 'Arts',
      'icon': Ionicons.color_palette_outline,
      'subDepartments': ['Fine Arts', 'Music', 'Theater', 'Literature'],
    },
    {
      'id': 5,
      'name': 'Science',
      'icon': Ionicons.flask_outline,
      'subDepartments': ['Physics', 'Chemistry', 'Biology', 'Mathematics'],
    },
    {
      'id': 6,
      'name': 'Law',
      'icon': Ionicons.scale_outline,
      'subDepartments': [
        'Criminal Law',
        'Civil Law',
        'International Law',
        'Corporate Law',
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _departments.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(AppLocalizations.appName),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Ionicons.heart_outline),
            tooltip: 'Favorites',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Search Bar
          SliverToBoxAdapter(child: HomeScreenSearchBar()),

          // Banner Slider
          SliverToBoxAdapter(child: HomeScreenBannerSlider()),

          SliverToBoxAdapter(child: const SizedBox(height: 24)),

          // Quick Access Section
          SliverToBoxAdapter(child: HomeScreenQuickAccessSection()),

          SliverToBoxAdapter(child: const SizedBox(height: 24)),

          // Departments Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                AppLocalizations.departments,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          // Tab Bar
          SliverToBoxAdapter(
            child: HomeScreenDepartmentsTapbar(
              tabController: _tabController,
              departments: _departments,
            ),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 20)),
          // Sub-departments content
          HomeScreenSubDepartmentsGrid(
            tabController: _tabController,
            departments: _departments,
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 24)),
        ],
      ),
    );
  }
}
