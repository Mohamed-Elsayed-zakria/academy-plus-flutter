import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';

class HomeScreenDepartmentsTapbar extends StatelessWidget {
  final TabController tabController;
  final List<Map<String, dynamic>> departments;
  
  const HomeScreenDepartmentsTapbar({
    super.key,
    required this.tabController,
    required this.departments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.surfaceGrey.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: AppColors.primaryGradient,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        tabs: departments.map((department) {
          return Tab(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(department['icon'], size: 18),
                  const SizedBox(width: 8),
                  Text(department['name']),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
