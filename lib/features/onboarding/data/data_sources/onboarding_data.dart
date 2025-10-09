import '../models/onboarding_page.dart';

class OnboardingData {
  static const List<OnboardingPage> pages = [
    OnboardingPage(
      title: 'Welcome to Academy Plus',
      description: 'Discover a comprehensive learning platform designed to enhance your educational journey with interactive courses and personalized content.',
      svgAsset: 'assets/images/Learning-amico.svg',
    ),
    OnboardingPage(
      title: 'Interactive Learning',
      description: 'Engage with dynamic quizzes, assignments, and real-time feedback to maximize your learning potential and track your progress.',
      svgAsset: 'assets/images/Learning-rafiki.svg',
    ),
    OnboardingPage(
      title: 'College Ready',
      description: 'Prepare for your college journey with specialized courses, expert guidance, and comprehensive resources tailored for academic success.',
      svgAsset: 'assets/images/college project-pana.svg',
    ),
  ];
}
