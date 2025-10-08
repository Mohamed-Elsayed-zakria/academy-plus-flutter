import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/whatsapp_launcher.dart';

class CoursesScreen extends StatelessWidget {
  final Map<String, dynamic> subDepartmentData;

  const CoursesScreen({
    super.key,
    required this.subDepartmentData,
  });

  @override
  Widget build(BuildContext context) {
    final subDepartmentName = subDepartmentData['subDepartmentName'] as String;
    final color = subDepartmentData['color'] as Color;

    // Mock courses data with bilingual names
    final courses = List.generate(
      5,
      (index) => {
        'id': index,
        'nameAr': 'مقدمة في $subDepartmentName',
        'nameEn': 'Introduction to $subDepartmentName',
        'instructor': 'Dr. John Doe',
        'price': 299.99,
        'discount': 20,
        'description': 'This comprehensive course covers fundamental and advanced concepts in $subDepartmentName. Perfect for students looking to master this subject.',
        'image': 'https://via.placeholder.com/400x200',
        'hasWhatsApp': true,
        'hasPaymentGateway': true,
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(subDepartmentName),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          final discountedPrice = (course['price'] as double) -
              ((course['price'] as double) * (course['discount'] as int) / 100);

          return GestureDetector(
            onTap: () {
              context.push('/course/${course['id']}', extra: course);
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Course Cover Image with Play Button
                  Stack(
                    children: [
                      Container(
                        height: 180,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [color, color.withValues(alpha: 0.7)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                      ),
                      // Free Intro Video Play Button
                      Positioned.fill(
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.play_arrow,
                              size: 40,
                              color: color,
                            ),
                          ),
                        ),
                      ),
                      // Free Preview Badge
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.play_circle,
                                size: 16,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Free Preview',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Bilingual Course Name
                        Text(
                          course['nameAr'] as String,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          course['nameEn'] as String,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                        const SizedBox(height: 12),

                        // Instructor
                        Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: 16,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              course['instructor'] as String,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Price Section
                        Row(
                          children: [
                            if (course['discount'] as int > 0) ...[
                              Text(
                                '\$${course['price']}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      color: AppColors.textTertiary,
                                    ),
                              ),
                              const SizedBox(width: 8),
                            ],
                            Text(
                              '\$${discountedPrice.toStringAsFixed(2)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: AppColors.accent,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            if (course['discount'] as int > 0) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.error.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${course['discount']}% OFF',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: AppColors.error,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Subscription Options
                        Row(
                          children: [
                            if (course['hasWhatsApp'] as bool)
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () async {
                                    final courseName = course['nameAr'] as String? ??
                                                      course['nameEn'] as String? ??
                                                      'this course';

                                    // Default WhatsApp business number
                                    const whatsappNumber = '201234567890'; // Replace with actual number

                                    try {
                                      await WhatsAppLauncher.openForCourseSubscription(
                                        phoneNumber: whatsappNumber,
                                        courseName: courseName,
                                        courseId: course['id'].toString(),
                                      );
                                    } catch (e) {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Could not open WhatsApp. Please make sure it is installed.'),
                                            backgroundColor: AppColors.error,
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Color(0xFF25D366),
                                    side: BorderSide(color: Color(0xFF25D366)),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  icon: Icon(Icons.chat, size: 18),
                                  label: Text('WhatsApp'),
                                ),
                              ),
                            if (course['hasWhatsApp'] as bool &&
                                course['hasPaymentGateway'] as bool)
                              const SizedBox(width: 12),
                            if (course['hasPaymentGateway'] as bool)
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    // Payment gateway
                                    context.push('/course/${course['id']}', extra: course);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  icon: Icon(Icons.payment, size: 18),
                                  label: Text('Subscribe'),
                                ),
                              ),
                          ],
                        ),
                      ],
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
