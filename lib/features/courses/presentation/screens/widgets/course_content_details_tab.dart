import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_button.dart';

class CourseContentDetailsTab extends StatelessWidget {
  final Map<String, dynamic> course;
  final double discountedPrice;
  const CourseContentDetailsTab({
    super.key,
    required this.course,
    required this.discountedPrice,
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
                          course['instructor'] as String,
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
                              course['duration'] as String? ?? '16 weeks',
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
                              '${course['studentsCount'] as int? ?? 1250}',
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
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Ionicons.star,
                        color: AppColors.accentPurple,
                        size: 24,
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
                                final rating =
                                    course['rating'] as double? ?? 4.8;
                                return Icon(
                                  index < rating.floor()
                                      ? Ionicons.star
                                      : index < rating
                                      ? Ionicons.star_half
                                      : Ionicons.star_outline,
                                  color: AppColors.accentPurple,
                                  size: 16,
                                );
                              }),
                              const SizedBox(width: 8),
                              Text(
                                '${course['rating'] as double? ?? 4.8}',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: AppColors.accentPurple,
                                      fontWeight: FontWeight.bold,
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
                              if (course['discount'] as int > 0) ...[
                                Text(
                                  '\$${course['price']}',
                                  style: Theme.of(context).textTheme.bodyMedium
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
                    AppLocalizations.aboutCourse,
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

                // Subscription Button
                if (course['hasPaymentGateway'] == true)
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
