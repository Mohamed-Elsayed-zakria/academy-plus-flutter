import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../data/models/course_model.dart';

class CourseContentDetailsTab extends StatelessWidget {
  final CourseModel course;
  const CourseContentDetailsTab({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Course Title (Bilingual)
                Text(
                  course.titleAr,
                  style: Theme.of(context).textTheme.displaySmall,
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 8),
                Text(
                  course.titleEn,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),

                // Instructor
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.surfaceGrey,
                      child: Icon(Icons.person, color: AppColors.textSecondary),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.instructor,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          course.instructorName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Course Info Cards
                Row(
                  children: [
                    // Duration Card
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Ionicons.time_outline,
                              color: AppColors.primary,
                              size: 24,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Duration',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.textSecondary),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '16 weeks', // Default duration
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Students Count Card
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.accent.withValues(alpha: 0.2),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Ionicons.people_outline,
                              color: AppColors.accent,
                              size: 24,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Students',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.textSecondary),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '1250', // Default students count
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: AppColors.accent,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Rating Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.accentPurple.withValues(alpha: 0.2),
                      width: 1,
                    ),
                    color: AppColors.surface,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.accentPurple.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Ionicons.star,
                          color: AppColors.accentPurple,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rating',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.textSecondary),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              // Stars
                              ...List.generate(5, (index) {
                                final rating = 4.8; // Default rating
                                return Container(
                                  margin: const EdgeInsets.only(right: 1),
                                  child: Icon(
                                    index < rating.floor()
                                        ? Ionicons.star
                                        : index < rating
                                        ? Ionicons.star_half
                                        : Ionicons.star_outline,
                                    color: index < rating.floor()
                                        ? AppColors.accentPurple
                                        : index < rating
                                        ? AppColors.accentPurple
                                        : AppColors.textTertiary,
                                    size: 14,
                                  ),
                                );
                              }),
                              const SizedBox(width: 8),
                              Text(
                                '4.8', // Default rating
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: AppColors.accentPurple,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
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
                            AppLocalizations.price,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              if (course.discountPrice > 0 && course.discountPrice < course.price) ...[
                                Text(
                                  '${course.price.toStringAsFixed(0)} ج.م',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        color: AppColors.textTertiary,
                                      ),
                                ),
                                const SizedBox(width: 8),
                              ],
                              Text(
                                '${course.discountPrice > 0 ? course.discountPrice : course.price} ج.م',
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
                      if (course.discountPrice > 0 && course.discountPrice < course.price)
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
                            '${((course.price - course.discountPrice) / course.price * 100).round()}% OFF',
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
                if (course.description != null && course.description!.isNotEmpty) ...[
                  Text(
                    AppLocalizations.aboutCourse,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    course.description!,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 32),
                ] else
                  const SizedBox(height: 32),

                // Subscription Button
                CustomButton(
                  text: AppLocalizations.subscribe,
                  onPressed: () {},
                  isGradient: true,
                  width: double.infinity,
                  icon: Icon(Ionicons.star, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
