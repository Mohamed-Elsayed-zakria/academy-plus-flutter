import 'package:flutter/material.dart';
import '../../../../../core/widgets/skeleton_loader.dart';
import '../../../../../core/constants/app_colors.dart';

class AdSkeletonLoader extends StatelessWidget {
  const AdSkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main banner skeleton
        Container(
          height: 180,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                // Main skeleton background
                const SkeletonLoader(
                  width: double.infinity,
                  height: double.infinity,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                // Subtle gradient overlay to simulate image content
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.1),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Indicators skeleton
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) => 
            Container(
              width: index == 0 ? 24 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const SkeletonLoader(
                width: double.infinity,
                height: double.infinity,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
