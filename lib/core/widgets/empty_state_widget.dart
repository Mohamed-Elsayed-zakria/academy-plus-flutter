import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_colors.dart';
import '../localization/app_localizations.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final String? svgAssetPath;

  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onButtonPressed,
    this.svgAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SVG Illustration
            if (svgAssetPath != null)
              SvgPicture.asset(
                svgAssetPath!,
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              )
            else
              Icon(
                Icons.inbox_outlined,
                size: 120,
                color: AppColors.textTertiary,
              ),
            
            const SizedBox(height: 32),
            
            // Title
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 16),
            
            // Description
            Text(
              description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Predefined empty states for common use cases
class EmptyAssignmentsWidget extends StatelessWidget {
  const EmptyAssignmentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      title: AppLocalizations.noAssignments,
      description: AppLocalizations.noAssignmentsDescription,
      buttonText: '', // Empty button text since we don't need the button
      onButtonPressed: () {}, // Empty callback
      svgAssetPath: 'assets/images/undraw_no-data_ig65.svg',
    );
  }
}

class EmptyQuizzesWidget extends StatelessWidget {
  const EmptyQuizzesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      title: AppLocalizations.noQuizzes,
      description: AppLocalizations.noQuizzesDescription,
      buttonText: '', // Empty button text since we don't need the button
      onButtonPressed: () {}, // Empty callback
      svgAssetPath: 'assets/images/undraw_no-data_ig65.svg',
    );
  }
}
