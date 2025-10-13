import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';

class CoursesScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const CoursesScreen({
    super.key,
    required this.data,
  });

  String _getCourseImage(String courseName) {
    // Return different images based on course name
    if (courseName.contains('مقدمة')) {
      return 'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=500&h=300&fit=crop';
    } else if (courseName.contains('أساسيات')) {
      return 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=500&h=300&fit=crop';
    } else if (courseName.contains('المتقدم')) {
      return 'https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=500&h=300&fit=crop';
    } else if (courseName.contains('تطبيقات')) {
      return 'https://images.unsplash.com/photo-1581094794329-c8112a89af12?w=500&h=300&fit=crop';
    }
    return 'https://ans.edu.jo/uploads/2024/09/66eaa687e6465.jpg';
  }

  @override
  Widget build(BuildContext context) {
    final subDepartmentName = data['subDepartmentName'] as String;
    final departmentName = data['departmentName'] as String;

    // Mock courses data
    final courses = [
      {
        'name': 'مقدمة في $subDepartmentName',
        'instructor': 'د. أحمد محمد',
        'rating': 4.8,
        'students': 1250,
        'duration': '12 ساعة',
        'price': 299,
      },
      {
        'name': 'أساسيات $subDepartmentName',
        'instructor': 'د. فاطمة علي',
        'rating': 4.6,
        'students': 980,
        'duration': '10 ساعات',
        'price': 249,
      },
      {
        'name': '$subDepartmentName المتقدم',
        'instructor': 'د. محمود حسن',
        'rating': 4.9,
        'students': 750,
        'duration': '15 ساعة',
        'price': 399,
      },
      {
        'name': 'تطبيقات $subDepartmentName',
        'instructor': 'د. سارة خالد',
        'rating': 4.7,
        'students': 650,
        'duration': '8 ساعات',
        'price': 199,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          subDepartmentName,
          style: const TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.65,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final course = courses[index];
                  
                  return InkWell(
                    onTap: () {
                      context.push(
                        '/course/$index/content',
                        extra: {
                          'nameAr': course['name'],
                          'nameEn': course['name'],
                          'instructor': course['instructor'],
                          'rating': course['rating'],
                          'students': course['students'],
                          'duration': course['duration'],
                          'price': course['price'],
                          'discount': 20, // خصم افتراضي 20%
                          'description': 'وصف المادة: ${course['name']}',
                          'isSubscribed': false,
                          'hasWhatsApp': true,
                          'hasPaymentGateway': true,
                          'subDepartmentName': subDepartmentName,
                          'departmentName': departmentName,
                        },
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Course image
                        Expanded(
                          flex: 3,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  _getCourseImage(course['name'] as String),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            AppColors.primary,
                                            AppColors.accent,
                                          ],
                                        ),
                                      ),
                                      child: const Icon(
                                        Ionicons.book_outline,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    );
                                  },
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      color: AppColors.surfaceGrey,
                                      child: Center(
                                        child: SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            value: loadingProgress.expectedTotalBytes != null
                                                ? loadingProgress.cumulativeBytesLoaded /
                                                    loadingProgress.expectedTotalBytes!
                                                : null,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                // Action buttons overlay
                                Positioned(
                                  top: 12,
                                  left: 12,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.7),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.15),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {},
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          child: const Icon(
                                            Ionicons.heart_outline,
                                            color: Colors.red,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 12,
                                  right: 12,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.7),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.15),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {},
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          child: const Icon(
                                            Ionicons.cart_outline,
                                            color: AppColors.primary,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        // Course details
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Course name
                                Text(
                                  course['name'] as String,
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                
                                // Instructor
                                Text(
                                  course['instructor'] as String,
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                
                                // Rating and stats
                                Row(
                                  children: [
                                    const Icon(
                                      Ionicons.star,
                                      size: 12,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      '${course['rating']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${course['students']} طالب',
                                      style: const TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                
                                // Price before and after discount
                                Row(
                                  children: [
                                    Text(
                                      '${course['price']} \$',
                                      style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: AppColors.textSecondary,
                                        fontSize: 10,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${((course['price'] as int) * 0.8).round()} \$',
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
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
                childCount: courses.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

