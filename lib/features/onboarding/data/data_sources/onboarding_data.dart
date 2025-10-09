import '../models/onboarding_page.dart';
import '../../../../core/localization/app_localizations.dart';

class OnboardingData {
  static List<OnboardingPage> get pages => [
    OnboardingPage(
      title: AppLocalizations.onboardingTitle1,
      description: AppLocalizations.onboardingDescription1,
      svgAsset: 'assets/images/Learning-amico.svg',
    ),
    OnboardingPage(
      title: AppLocalizations.onboardingTitle2,
      description: AppLocalizations.onboardingDescription2,
      svgAsset: 'assets/images/Learning-rafiki.svg',
    ),
    OnboardingPage(
      title: AppLocalizations.onboardingTitle3,
      description: AppLocalizations.onboardingDescription3,
      svgAsset: 'assets/images/college project-pana.svg',
    ),
  ];
}
