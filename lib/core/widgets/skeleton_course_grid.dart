import 'package:flutter/material.dart';
import 'skeleton_loader.dart';

class SkeletonCourseCard extends StatelessWidget {
  const SkeletonCourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
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
          // Image section
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
                  // Price badge skeleton
                  Positioned(
                    top: 8,
                    right: 8,
                    child: SkeletonLoader(
                      height: 24,
                      width: 60,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Text section
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Course title
                  const SkeletonLoader(height: 16, width: double.infinity),
                  const SizedBox(height: 4),
                  // Instructor name
                  const SkeletonLoader(height: 12, width: 120),
                  const SizedBox(height: 4),
                  // Rating and price row
                  Row(
                    children: [
                      const SkeletonLoader(height: 12, width: 12),
                      const SizedBox(width: 2),
                      const SkeletonLoader(height: 12, width: 20),
                      const Spacer(),
                      const SkeletonLoader(height: 10, width: 50),
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

class SkeletonCourseGrid extends StatelessWidget {
  final int itemCount;

  const SkeletonCourseGrid({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) => const SkeletonCourseCard(),
    );
  }
}
