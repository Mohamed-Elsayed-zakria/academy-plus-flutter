import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/utils/whatsapp_launcher.dart';

class CourseScreen extends StatelessWidget {
  final String courseId;
  final Map<String, dynamic>? courseData;

  const CourseScreen({super.key, required this.courseId, this.courseData});

  @override
  Widget build(BuildContext context) {
    // Use passed course data or mock data
    final course =
        courseData ??
        {
          'nameAr': 'البرمجة المتقدمة',
          'nameEn': 'Advanced Programming',
          'instructor': 'Dr. Sarah Johnson',
          'description': 'Learn advanced programming concepts and techniques.',
          'price': 299.99,
          'discount': 20,
          'isSubscribed': false,
          'hasWhatsApp': true,
          'hasPaymentGateway': true,
        };

    final discountedPrice =
        (course['price'] as double) -
        ((course['price'] as double) * (course['discount'] as int) / 100);

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.courseDetails)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Cover Image with Play Button
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        size: 48,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Free Preview',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Course Title (Bilingual)
                  Text(
                    course['nameAr'] as String? ?? course['title'] as String,
                    style: Theme.of(context).textTheme.displaySmall,
                    textDirection: TextDirection.rtl,
                  ),
                  if (course['nameEn'] != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      course['nameEn'] as String,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                  const SizedBox(height: 12),

                  // Instructor
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.surfaceGrey,
                        child: Icon(
                          Icons.person,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.instructor,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            course['instructor'] as String,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Price Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceGrey,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.price,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                if (course['discount'] as int > 0) ...[
                                  Text(
                                    '\$${course['price']}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: AppColors.textTertiary,
                                        ),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                                Text(
                                  '\$${discountedPrice.toStringAsFixed(2)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color: AppColors.accent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (course['discount'] as int > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.error,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${course['discount']}% OFF',
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Description
                  if (course['description'] != null) ...[
                    Text(
                      'About this course',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      course['description'] as String,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 32),
                  ] else
                    const SizedBox(height: 32),

                  // Subscription Buttons (based on available options)
                  if (course['hasPaymentGateway'] == true)
                    CustomButton(
                      text: AppStrings.subscribe,
                      onPressed: () {
                        // Navigate to course content after subscription
                        context.push('/course/$courseId/content');
                      },
                      isGradient: true,
                      width: double.infinity,
                    ),
                  if (course['hasPaymentGateway'] == true &&
                      course['hasWhatsApp'] == true)
                    const SizedBox(height: 12),
                  if (course['hasWhatsApp'] == true)
                    CustomButton(
                      text: AppStrings.contactWhatsApp,
                      onPressed: () async {
                        // Get course name (bilingual or fallback to title)
                        final courseName =
                            course['nameAr'] as String? ??
                            course['title'] as String? ??
                            'this course';

                        // Default WhatsApp business number (you can change this)
                        const whatsappNumber =
                            '201234567890'; // Replace with actual number

                        try {
                          await WhatsAppLauncher.openForCourseSubscription(
                            phoneNumber: whatsappNumber,
                            courseName: courseName,
                            courseId: courseId,
                          );
                        } catch (e) {
                          // Could not open WhatsApp
                        }
                      },
                      isOutlined: true,
                      width: double.infinity,
                      icon: Icon(Icons.chat, color: AppColors.primary),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
