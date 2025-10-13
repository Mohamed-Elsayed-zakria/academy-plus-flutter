import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class HomeScreenSearchBar extends StatelessWidget {
  const HomeScreenSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomTextField(
        hintText: AppLocalizations.search,
        prefixIcon: const Icon(
          Ionicons.search_outline,
          color: AppColors.textSecondary,
          size: 20,
        ),
      ),
    );
  }
}
