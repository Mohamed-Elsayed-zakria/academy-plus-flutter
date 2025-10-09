import 'package:easy_localization/easy_localization.dart';

/// Helper class for localization
class AppLocalizations {
  // App Info
  static String get appName => 'app_name'.tr();
  static String get welcome => 'welcome'.tr();
  
  // Auth
  static String get login => 'login'.tr();
  static String get register => 'register'.tr();
  static String get phoneNumber => 'phone_number'.tr();
  static String get password => 'password'.tr();
  static String get confirmPassword => 'confirm_password'.tr();
  static String get fullName => 'full_name'.tr();
  static String get selectUniversity => 'select_university'.tr();
  static String get verifyOtp => 'verify_otp'.tr();
  static String get enterOtp => 'enter_otp'.tr();
  static String get forgotPassword => 'forgot_password'.tr();
  static String get resetPassword => 'reset_password'.tr();
  static String get enterPhoneReset => 'enter_phone_reset'.tr();
  static String get noWorries => 'no_worries'.tr();
  static String get sendOtp => 'send_otp'.tr();
  static String get sending => 'sending'.tr();
  static String get rememberPassword => 'remember_password'.tr();
  static String get backToLogin => 'back_to_login'.tr();
  static String get alreadyHaveAccount => 'already_have_account'.tr();
  static String get dontHaveAccount => 'dont_have_account'.tr();
  static String get verify => 'verify'.tr();
  static String get didntReceiveCode => 'didnt_receive_code'.tr();
  static String get resend => 'resend'.tr();
  
  // Navigation
  static String get home => 'home'.tr();
  static String get notifications => 'notifications'.tr();
  static String get subscriptions => 'subscriptions'.tr();
  static String get profile => 'profile'.tr();
  
  // Home
  static String get search => 'search'.tr();
  static String get assignments => 'assignments'.tr();
  static String get quizzes => 'quizzes'.tr();
  static String get departments => 'departments'.tr();
  static String get quickAccess => 'quick_access'.tr();
  static String get viewSubmit => 'view_submit'.tr();
  static String get takeQuiz => 'take_quiz'.tr();
  
  // Course
  static String get courseDetails => 'course_details'.tr();
  static String get instructor => 'instructor'.tr();
  static String get price => 'price'.tr();
  static String get discount => 'discount'.tr();
  static String get subscribe => 'subscribe'.tr();
  static String get contactWhatsapp => 'contact_whatsapp'.tr();
  static String get aboutCourse => 'about_course'.tr();
  static String get freePreview => 'free_preview'.tr();
  
  // Course Content
  static String get midtermLectures => 'midterm_lectures'.tr();
  static String get finalLectures => 'final_lectures'.tr();
  static String get midtermExams => 'midterm_exams'.tr();
  static String get finalExams => 'final_exams'.tr();
  static String get attachments => 'attachments'.tr();
  static String get testYourself => 'test_yourself'.tr();
  
  // Profile
  static String get editProfile => 'edit_profile'.tr();
  static String get changePassword => 'change_password'.tr();
  static String get logout => 'logout'.tr();
  static String get personalInformation => 'personal_information'.tr();
  static String get email => 'email'.tr();
  static String get phone => 'phone'.tr();
  static String get university => 'university'.tr();
  static String get settings => 'settings'.tr();
  static String get language => 'language'.tr();
  static String get darkMode => 'dark_mode'.tr();
  static String get enabled => 'enabled'.tr();
  static String get disabled => 'disabled'.tr();
  static String get helpSupport => 'help_support'.tr();
  static String get about => 'about'.tr();
  static String get logoutConfirmation => 'logout_confirmation'.tr();
  static String get cancel => 'cancel'.tr();
  static String get saveChanges => 'save_changes'.tr();
  static String get tapToChangePicture => 'tap_to_change_picture'.tr();
  
  // Empty States
  static String get noNotifications => 'no_notifications'.tr();
  static String get noSubscriptions => 'no_subscriptions'.tr();
  static String get noCourses => 'no_courses'.tr();
  
  // Progress & Status
  static String get progress => 'progress'.tr();
  static String get active => 'active'.tr();
  static String get completed => 'completed'.tr();
  static String get markAllRead => 'mark_all_read'.tr();
  
  // Shopping Cart
  static String get continueShopping => 'continue_shopping'.tr();
  static String get checkout => 'checkout'.tr();
  static String get total => 'total'.tr();
  static String get shoppingCart => 'shopping_cart'.tr();
  static String get qty => 'qty'.tr();
  
  // Languages
  static String get english => 'english'.tr();
  static String get arabic => 'arabic'.tr();
  static String get arabicLanguage => 'arabic_language'.tr();
  static String get normalMode => 'normal_mode'.tr();
  static String get defaultSystem => 'default_system'.tr();
  static String get darkModeAr => 'dark_mode_ar'.tr();
  static String get nightMode => 'night_mode'.tr();
  static String get system => 'system'.tr();
  static String get chooseUniversity => 'choose_university'.tr();
  static String get searchUniversity => 'search_university'.tr();
  
  // Additional missing translations
  static String get courseContent => 'course_content'.tr();
  static String get year => 'year'.tr();
  static String get assignmentDetails => 'assignment_details'.tr();
  static String get quizDetails => 'quiz_details'.tr();
  static String get startQuiz => 'start_quiz'.tr();
  static String get start => 'start'.tr();
  static String get newPassword => 'new_password'.tr();
  static String get confirmNewPassword => 'confirm_new_password'.tr();
  static String get searchCountry => 'search_country'.tr();
  static String get pleaseEnterPhone => 'please_enter_phone'.tr();
  static String get pleaseEnterValidPhone => 'please_enter_valid_phone'.tr();
  static String get pleaseEnterFullName => 'please_enter_full_name'.tr();
  static String get pleaseEnterEmail => 'please_enter_email'.tr();
  static String get pleaseSelectUniversity => 'please_select_university'.tr();
  static String get pleaseEnterPassword => 'please_enter_password'.tr();
  
  // Additional missing translations
  static String get pleaseEnterPhoneNumber => 'please_enter_phone_number'.tr();
  static String get pleaseEnterValidPhoneNumber => 'please_enter_valid_phone_number'.tr();
  static String get phoneNumberTooLong => 'phone_number_too_long'.tr();
  static String get pleaseEnterNewPassword => 'please_enter_new_password'.tr();
  static String get passwordMustBeAtLeast6 => 'password_must_be_at_least_6'.tr();
  static String get pleaseConfirmNewPassword => 'please_confirm_new_password'.tr();
  static String get passwordsDoNotMatch => 'passwords_do_not_match'.tr();
  static String get pleaseConfirmPassword => 'please_confirm_password'.tr();
  static String get questions => 'questions'.tr();
  static String get duration => 'duration'.tr();
  static String get attempts => 'attempts'.tr();
  static String get bestScore => 'best_score'.tr();
  static String get instructions => 'instructions'.tr();
  static String get youHaveMinutesQuiz => 'you_have_minutes_quiz'.tr();
  static String get quizContainsQuestionsCount => 'quiz_contains_questions_count'.tr();
  static String get timerCannotBePaused => 'timer_cannot_be_paused'.tr();
  static String get reviewAnswersBeforeSubmitting => 'review_answers_before_submitting'.tr();
  static String get deadline => 'deadline'.tr();
  static String get retakeQuiz => 'retake_quiz'.tr();
  static String get viewPreviousAttempt => 'view_previous_attempt'.tr();
  static String get viewResults => 'view_results'.tr();
  static String get quizNotAvailable => 'quiz_not_available'.tr();
  static String get areYouReadyStart => 'are_you_ready_start'.tr();
  static String get searchUniversityPlaceholder => 'search_university_placeholder'.tr();
  
  // Welcome screen
  static String get welcomeSubtitle => 'welcome_subtitle'.tr();
  
  // Common
  static String get or => 'or'.tr();
  
  // Onboarding
  static String get skip => 'skip'.tr();
  static String get previous => 'previous'.tr();
  static String get next => 'next'.tr();
  static String get getStarted => 'get_started'.tr();
  static String get onboardingTitle1 => 'onboarding_title_1'.tr();
  static String get onboardingDescription1 => 'onboarding_description_1'.tr();
  static String get onboardingTitle2 => 'onboarding_title_2'.tr();
  static String get onboardingDescription2 => 'onboarding_description_2'.tr();
  static String get onboardingTitle3 => 'onboarding_title_3'.tr();
  static String get onboardingDescription3 => 'onboarding_description_3'.tr();
}

