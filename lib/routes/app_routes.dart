import 'package:go_router/go_router.dart';
import '../features/splash/presentation/views/screens/splash_screen.dart';
import '../features/splash/presentation/views/screens/welcome_screen.dart';
import '../features/auth/presentation/views/screens/login_screen.dart';
import '../features/auth/presentation/views/screens/register_screen.dart';
import '../features/auth/presentation/views/screens/profile_picture_screen.dart';
import '../features/auth/presentation/views/screens/otp_screen.dart';
import '../features/auth/presentation/views/screens/forgot_password_screen.dart';
import '../features/auth/presentation/views/screens/reset_password_screen.dart';
import '../features/home/presentation/views/screens/main_screen.dart';
import '../features/home/presentation/views/screens/sub_departments_screen.dart';
import '../features/home/presentation/views/screens/courses_screen.dart';
import '../features/home/presentation/views/screens/course_screen.dart';
import '../features/home/presentation/views/screens/course_content_screen.dart';
import '../features/assignments/presentation/views/screens/assignments_screen.dart';
import '../features/assignments/presentation/views/screens/assignment_details_screen.dart';
import '../features/quizzes/presentation/views/screens/quizzes_screen.dart';
import '../features/quizzes/presentation/views/screens/quiz_details_screen.dart';
import '../features/profile/presentation/views/screens/edit_profile_screen.dart';
import '../features/onboarding/presentation/views/screens/onboarding_screen.dart';

GoRouter createAppRouter({required bool isOnboardingCompleted}) => GoRouter(
  initialLocation: isOnboardingCompleted ? '/welcome' : '/onboarding',
  routes: [
    // Splash Screen
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),

    // Welcome Screen
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),

    // Onboarding Screen
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),

    // Authentication Routes
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/profile-picture',
      builder: (context, state) => const ProfilePictureScreen(),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) => OtpScreen(extra: state.extra as Map<String, dynamic>?),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/reset-password-otp',
      builder: (context, state) => OtpScreen(extra: state.extra as Map<String, dynamic>?),
    ),
    GoRoute(
      path: '/reset-password',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final phoneNumber = extra?['phoneNumber'] as String? ?? '';
        return ResetPasswordScreen(phoneNumber: phoneNumber);
      },
    ),

    // Main Screen (with bottom navigation)
    GoRoute(
      path: '/main',
      builder: (context, state) => const MainScreen(),
    ),

    // Department Screen (shows sub-departments)
    GoRoute(
      path: '/department/:id',
      builder: (context, state) {
        final department = state.extra as Map<String, dynamic>;
        return SubDepartmentsScreen(department: department);
      },
    ),

    // Courses Screen (shows courses in a sub-department)
    GoRoute(
      path: '/subdepartment/:deptId/:subDeptId/courses',
      builder: (context, state) {
        final subDepartmentData = state.extra as Map<String, dynamic>;
        return CoursesScreen(subDepartmentData: subDepartmentData);
      },
    ),

    // Course Screen
    GoRoute(
      path: '/course/:id',
      builder: (context, state) {
        final courseId = state.pathParameters['id'] ?? '';
        final courseData = state.extra as Map<String, dynamic>?;
        return CourseScreen(courseId: courseId, courseData: courseData);
      },
    ),

    // Course Content Screen (after subscription)
    GoRoute(
      path: '/course/:id/content',
      builder: (context, state) {
        final courseId = state.pathParameters['id'] ?? '';
        return CourseContentScreen(courseId: courseId);
      },
    ),

    // Assignments Routes
    GoRoute(
      path: '/assignments',
      builder: (context, state) => const AssignmentsScreen(),
    ),
    GoRoute(
      path: '/assignment/:id',
      builder: (context, state) {
        final assignment = state.extra as Map<String, dynamic>;
        return AssignmentDetailsScreen(assignment: assignment);
      },
    ),

    // Quizzes Routes
    GoRoute(
      path: '/quizzes',
      builder: (context, state) => const QuizzesScreen(),
    ),
    GoRoute(
      path: '/quiz/:id',
      builder: (context, state) {
        final quiz = state.extra as Map<String, dynamic>;
        return QuizDetailsScreen(quiz: quiz);
      },
    ),

    // Profile Routes
    GoRoute(
      path: '/profile/edit',
      builder: (context, state) => const EditProfileScreen(),
    ),
  ],
);
