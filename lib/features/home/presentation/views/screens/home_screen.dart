import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentSlide = 0;

  final List<String> _banners = [
    'Banner 1',
    'Banner 2',
    'Banner 3',
  ];

  // Main Departments
  final List<Map<String, dynamic>> _departments = [
    {
      'id': 1,
      'name': 'Business',
      'icon': Icons.business_center,
      'color': Color(0xFF6366F1),
      'subDepartments': ['Accounting', 'Marketing', 'Finance', 'HR']
    },
    {
      'id': 2,
      'name': 'Engineering',
      'icon': Icons.engineering,
      'color': Color(0xFF8B5CF6),
      'subDepartments': ['Computer Science', 'Electrical', 'Mechanical', 'Civil']
    },
    {
      'id': 3,
      'name': 'Medicine',
      'icon': Icons.medical_services,
      'color': Color(0xFFEC4899),
      'subDepartments': ['General Medicine', 'Surgery', 'Pediatrics', 'Cardiology']
    },
    {
      'id': 4,
      'name': 'Arts',
      'icon': Icons.palette,
      'color': Color(0xFFF59E0B),
      'subDepartments': ['Fine Arts', 'Music', 'Theater', 'Literature']
    },
    {
      'id': 5,
      'name': 'Science',
      'icon': Icons.science,
      'color': Color(0xFF10B981),
      'subDepartments': ['Physics', 'Chemistry', 'Biology', 'Mathematics']
    },
    {
      'id': 6,
      'name': 'Law',
      'icon': Icons.gavel,
      'color': Color(0xFFEF4444),
      'subDepartments': ['Criminal Law', 'Civil Law', 'International Law', 'Corporate Law']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appName),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: AppStrings.search,
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // Banner Slider
            CarouselSlider(
              options: CarouselOptions(
                height: 180,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentSlide = index;
                  });
                },
              ),
              items: _banners.map((banner) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: AppColors.primaryGradient,
                      ),
                      child: Center(
                        child: Text(
                          banner,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            // Carousel Indicators
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _banners.asMap().entries.map((entry) {
                return Container(
                  width: _currentSlide == entry.key ? 24 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentSlide == entry.key
                        ? AppColors.primary
                        : AppColors.textTertiary.withValues(alpha: 0.3),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // Assignments & Quizzes
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: _buildQuickAccessCard(
                      title: AppStrings.assignments,
                      icon: Icons.assignment,
                      color: AppColors.primary,
                      onTap: () {
                        context.push('/assignments');
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildQuickAccessCard(
                      title: AppStrings.quizzes,
                      icon: Icons.quiz,
                      color: AppColors.accent,
                      onTap: () {
                        context.push('/quizzes');
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Departments Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                AppStrings.departments,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 16),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemCount: _departments.length,
              itemBuilder: (context, index) {
                final department = _departments[index];
                return _buildDepartmentCard(
                  name: department['name'],
                  icon: department['icon'],
                  color: department['color'],
                  onTap: () {
                    context.push(
                      '/department/${department['id']}',
                      extra: department,
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 32,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDepartmentCard({
    required String name,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 40,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              name,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
