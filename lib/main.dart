import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/theme/app_theme.dart';
import 'core/localization/app_localization_config.dart';
import 'routes/app_routes.dart';
import 'features/onboarding/data/services/onboarding_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Easy Localization
  await AppLocalizationConfig.initialize();

  // Check if onboarding is completed
  final isOnboardingCompleted = await OnboardingService.isOnboardingCompleted();

  runApp(
    AppLocalizationConfig.getLocalizationWidget(
      child: MyApp(isOnboardingCompleted: isOnboardingCompleted),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isOnboardingCompleted;

  const MyApp({super.key, required this.isOnboardingCompleted});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'app_name'.tr(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      localizationsDelegates: AppLocalizationConfig.getLocalizationDelegates(context),
      supportedLocales: AppLocalizationConfig.getSupportedLocales(context),
      locale: const Locale('ar'), // Force Arabic as default
      routerConfig: createAppRouter(
        isOnboardingCompleted: isOnboardingCompleted,
      ),
    );
  }
}
