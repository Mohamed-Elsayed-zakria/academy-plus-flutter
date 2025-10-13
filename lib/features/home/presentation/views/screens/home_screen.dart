import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:university/features/home/presentation/views/widgets/home_screen_banner_slider.dart';
import 'package:university/features/home/presentation/views/widgets/home_screen_quick_access_section.dart';
import 'package:university/features/home/presentation/views/widgets/home_screen_search_bar.dart';
import 'package:university/features/home/presentation/views/widgets/departments_grid_widget.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // Main Departments
  final List<Map<String, dynamic>> _departments = [
    {
      'id': 1,
      'name': 'الأعمال',
      'icon': Ionicons.briefcase_outline,
      'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=500&h=300&fit=crop',
      'subDepartments': ['المحاسبة', 'التسويق', 'التمويل', 'الموارد البشرية'],
    },
    {
      'id': 2,
      'name': 'الهندسة',
      'icon': Ionicons.construct_outline,
      'image': 'https://images.unsplash.com/photo-1581094794329-c8112a89af12?w=500&h=300&fit=crop',
      'subDepartments': [
        'علوم الحاسوب',
        'الهندسة الكهربائية',
        'الهندسة الميكانيكية',
        'الهندسة المدنية',
      ],
    },
    {
      'id': 3,
      'name': 'الطب',
      'icon': Ionicons.medical_outline,
      'image': 'https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=500&h=300&fit=crop',
      'subDepartments': ['الطب العام', 'الجراحة', 'طب الأطفال', 'أمراض القلب'],
    },
    {
      'id': 4,
      'name': 'الفنون',
      'icon': Ionicons.color_palette_outline,
      'image': 'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=500&h=300&fit=crop',
      'subDepartments': ['الفنون الجميلة', 'الموسيقى', 'المسرح', 'الأدب'],
    },
    {
      'id': 5,
      'name': 'العلوم',
      'icon': Ionicons.flask_outline,
      'image': 'https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=500&h=300&fit=crop',
      'subDepartments': ['الفيزياء', 'الكيمياء', 'الأحياء', 'الرياضيات'],
    },
    {
      'id': 6,
      'name': 'القانون',
      'icon': Ionicons.scale_outline,
      'image': 'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?w=500&h=300&fit=crop',
      'subDepartments': [
        'القانون الجنائي',
        'القانون المدني',
        'القانون الدولي',
        'قانون الشركات',
      ],
    },
  ];


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
          // Departments Grid
          SliverToBoxAdapter(
            child: DepartmentsGridWidget(
              departments: _departments,
            ),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 24)),
        ],
      ),
    );
  }
}
