import 'package:flutter/material.dart';
import '../../../../../core/widgets/skeleton_loader.dart';
import '../../../../../core/constants/app_colors.dart';

class DepartmentSkeletonLoader extends StatelessWidget {
  const DepartmentSkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image section skeleton
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Stack(
                children: [
                  const SkeletonLoader(
                    width: double.infinity,
                    height: double.infinity,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  // Gradient overlay
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.3),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Text section skeleton
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SkeletonLoader(
                    height: 18,
                    width: 120,
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const SkeletonLoader(
                        width: 16,
                        height: 16,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      const SizedBox(width: 8),
                      const SkeletonLoader(
                        height: 12,
                        width: 80,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DepartmentSkeletonGrid extends StatelessWidget {
  final int itemCount;

  const DepartmentSkeletonGrid({super.key, this.itemCount = 4});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) => const DepartmentSkeletonLoader(),
      ),
    );
  }
}

class DepartmentSkeletonList extends StatelessWidget {
  final int itemCount;

  const DepartmentSkeletonList({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: List.generate(itemCount, (index) => 
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Image skeleton
                    const SkeletonLoader(
                      width: 68,
                      height: 68,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    const SizedBox(width: 16),
                    // Text content skeleton
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SkeletonLoader(
                            height: 18,
                            width: 140,
                            borderRadius: BorderRadius.all(Radius.circular(9)),
                          ),
                          const SizedBox(height: 8),
                          const SkeletonLoader(
                            height: 14,
                            width: 100,
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const SkeletonLoader(
                                width: 16,
                                height: 16,
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                              ),
                              const SizedBox(width: 8),
                              const SkeletonLoader(
                                height: 12,
                                width: 60,
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Arrow skeleton
                    const SkeletonLoader(
                      width: 24,
                      height: 24,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
