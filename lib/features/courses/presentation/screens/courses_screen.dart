import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/navigation_helper.dart';

class CoursesScreen extends StatelessWidget {
  final Map<String, dynamic> subDepartmentData;

  const CoursesScreen({super.key, required this.subDepartmentData});

  @override
  Widget build(BuildContext context) {
    final subDepartmentName = subDepartmentData['subDepartmentName'] as String;
    // Mock courses data with bilingual names

    final List<String> coursesUrls = [
      'https://talaeaalghad.edu.sa/wp-content/uploads/2023/06/66bbfa3d80600cd36191c46fa7983b7e-scaled.jpg',
      'https://ia-bc.com/wp-content/uploads/2024/01/School-Science-Laboratory.jpg',
      'https://ans.edu.jo/uploads/2024/09/66eaa687e6465.jpg',
      'https://ans.edu.jo/uploads/2023/09/64f6c5a88eba4.jpg',
      'https://ans.edu.jo/uploads/2023/08/64e709d3c69fe.jpg',
      'https://ans.edu.jo/uploads/2019/09/5d7f60e877963.jpg',
    ];

    final courses = List.generate(
      7,
      (index) => {
        'id': index,
        'nameAr': subDepartmentName,
        'nameEn': 'Introduction to $subDepartmentName',
        'instructor': 'Dr. John Doe',
        'price': 299.99,
        'discount': 20,
        'description':
            'This comprehensive course covers fundamental and advanced concepts in $subDepartmentName. Perfect for students looking to master this subject.',
        'image': 'https://via.placeholder.com/400x200',
        'hasWhatsApp': true,
        'hasPaymentGateway': true,
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(subDepartmentName)),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        physics: BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.75,
        ),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          final discountedPrice =
              (course['price'] as double) -
              ((course['price'] as double) * (course['discount'] as int) / 100);

          return GestureDetector(
            onTap: () {
              NavigationHelper.to(
                path: '/course/${course['id']}/content',
                context: context,
                data: course,
              );
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Course Cover Image
                  Expanded(
                    flex: 3,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                            child: Image.network(
                              coursesUrls[index % coursesUrls.length],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                              top: Radius.circular(16),
                                            ),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            AppColors.primary.withValues(
                                              alpha: 0.8,
                                            ),
                                            AppColors.accent.withValues(
                                              alpha: 0.8,
                                            ),
                                          ],
                                        ),
                                      ),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    );
                                  },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        AppColors.primary.withValues(
                                          alpha: 0.8,
                                        ),
                                        AppColors.accent.withValues(alpha: 0.8),
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.image_outlined,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        // Course Preview Badge
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.visibility,
                                  size: 12,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  'Preview',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Favorite Button
                        Positioned(
                          top: 8,
                          left: 8,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.9),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.favorite_border,
                                size: 16,
                                color: AppColors.error,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Course Details
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Course Name
                          Text(
                            course['nameEn'] as String,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.textSecondary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          // Instructor
                          Row(
                            children: [
                              Icon(
                                Icons.person_outline,
                                size: 12,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  course['instructor'] as String,
                                  style: Theme.of(context).textTheme.bodySmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),

                          // Price Section
                          Row(
                            children: [
                              if (course['discount'] as int > 0) ...[
                                Text(
                                  '\$${course['price']}',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        color: AppColors.textTertiary,
                                      ),
                                ),
                                const SizedBox(width: 4),
                              ],
                              Expanded(
                                child: Text(
                                  '\$${discountedPrice.toStringAsFixed(2)}',
                                  style: Theme.of(context).textTheme.titleSmall
                                      ?.copyWith(
                                        color: AppColors.accent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              if (course['discount'] as int > 0)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.error.withValues(
                                      alpha: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '${course['discount']}%',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: AppColors.error,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
