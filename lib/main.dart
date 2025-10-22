import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/theme/app_theme.dart';
import 'core/localization/app_localization_config.dart';
import 'core/services/service_locator.dart';
import 'core/services/auth_manager.dart';
import 'routes/app_routes.dart';
import 'features/onboarding/data/services/onboarding_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize service locator
  SetupLocator().setup();

  // Initialize Easy Localization
  await AppLocalizationConfig.initialize();

  // Initialize Auth Manager
  await AuthManager.initialize();

  // Check if onboarding is completed
  final isOnboardingCompleted = await OnboardingService.isOnboardingCompleted();

  // Check if user is logged in (with proper verification)
  final isLoggedIn = await AuthManager.isLoggedInAsync();
  log('🔍 main.dart - Final isLoggedIn result: $isLoggedIn');

  // Check if phone verification is needed
  final needsPhoneVerification = AuthManager.needsPhoneVerification;
  final userPhoneNumber = AuthManager.currentUser?.phoneNumber;
  
  log('🔍 main.dart - needsPhoneVerification: $needsPhoneVerification');
  log('🔍 main.dart - userPhoneNumber: $userPhoneNumber');

  runApp(
    AppLocalizationConfig.getLocalizationWidget(
      child: MyApp(
        isOnboardingCompleted: isOnboardingCompleted,
        isLoggedIn: isLoggedIn,
        needsPhoneVerification: needsPhoneVerification,
        userPhoneNumber: userPhoneNumber,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isOnboardingCompleted;
  final bool isLoggedIn;
  final bool needsPhoneVerification;
  final String? userPhoneNumber;

  const MyApp({
    super.key, 
    required this.isOnboardingCompleted,
    required this.isLoggedIn,
    required this.needsPhoneVerification,
    this.userPhoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'app_name'.tr(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      localizationsDelegates: AppLocalizationConfig.getLocalizationDelegates(
        context,
      ),
      supportedLocales: AppLocalizationConfig.getSupportedLocales(context),
      locale: const Locale('ar'), // Force Arabic as default
      routerConfig: createAppRouter(
        isOnboardingCompleted: isOnboardingCompleted,
        isLoggedIn: isLoggedIn,
        needsPhoneVerification: needsPhoneVerification,
        userPhoneNumber: userPhoneNumber,
      ),
    );
  }
}
