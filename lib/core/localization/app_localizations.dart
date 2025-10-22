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
  static String get createNewPassword => 'create_new_password'.tr();
  static String get enterNewPasswordBelow => 'enter_new_password_below'.tr();
  static String get createStrongPassword => 'create_strong_password'.tr();
  static String get otpVerifiedFor => 'otp_verified_for'.tr();
  static String get resetting => 'resetting'.tr();
  static String get resetPasswordButton => 'reset_password_button'.tr();
  
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
  static String get noAssignments => 'no_assignments'.tr();
  static String get noAssignmentsDescription => 'no_assignments_description'.tr();
  static String get noQuizzes => 'no_quizzes'.tr();
  static String get noQuizzesDescription => 'no_quizzes_description'.tr();
  
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
  
  // Cart specific
  static String get cart => 'cart'.tr();
  static String get emptyCartTitle => 'empty_cart_title'.tr();
  static String get emptyCartDescription => 'empty_cart_description'.tr();
  static String get browseCourses => 'browse_courses'.tr();
  static String get subtotal => 'subtotal'.tr();
  static String get tax => 'tax'.tr();
  static String get proceedToCheckout => 'proceed_to_checkout'.tr();
  static String get removeItem => 'remove_item'.tr();
  static String get clearCartTitle => 'clear_cart_title'.tr();
  static String get clearCartMessage => 'clear_cart_message'.tr();
  static String get delete => 'delete'.tr();
  static String get checkoutMessage => 'checkout_message'.tr();
  static String get originalTotal => 'original_total'.tr();
  static String get discountAmount => 'discount_amount'.tr();
  
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
  
  // Add Assignment/Quiz
  static String get addAssignment => 'add_assignment'.tr();
  static String get addQuiz => 'add_quiz'.tr();
  static String get subject => 'subject'.tr();
  static String get assignmentTitle => 'assignment_title'.tr();
  static String get quizTitle => 'quiz_title'.tr();
  static String get description => 'description'.tr();
  static String get dueDate => 'due_date'.tr();
  static String get quizDate => 'quiz_date'.tr();
  static String get adminUsername => 'admin_username'.tr();
  static String get adminPassword => 'admin_password'.tr();
  static String get selectSubject => 'select_subject'.tr();
  static String get save => 'save'.tr();
  static String get addFirstAssignment => 'add_first_assignment'.tr();
  static String get addFirstQuiz => 'add_first_quiz'.tr();
  static String get newCourseAvailable => 'new_course_available'.tr();
  static String get assignmentDueSoon => 'assignment_due_soon'.tr();
  static String get newLectureAdded => 'new_lecture_added'.tr();
  static String get quizAvailable => 'quiz_available'.tr();
  static String get checkNewCourse => 'check_new_course'.tr();
  static String get assignmentDueMessage => 'assignment_due_message'.tr();
  static String get lectureAddedMessage => 'lecture_added_message'.tr();
  static String get quizReadyMessage => 'quiz_ready_message'.tr();
  static String hoursAgo(int hours) => 'hours_ago'.tr(namedArgs: {'hours': hours.toString()});
  static String daysAgo(int days) => 'days_ago'.tr(namedArgs: {'days': days.toString()});
  static String get dayAgo => 'day_ago'.tr();
  static String get advancedProgramming => 'advanced_programming'.tr();
  static String get dataStructures => 'data_structures'.tr();
  static String get webDevelopment => 'web_development'.tr();
  static String get drSarahJohnson => 'dr_sarah_johnson'.tr();
  static String get drMichaelBrown => 'dr_michael_brown'.tr();
  static String get drEmilyDavis => 'dr_emily_davis'.tr();
  static String get courseDuration => 'course_duration'.tr();
  static String get startDate => 'start_date'.tr();
  static String get endDate => 'end_date'.tr();
  static String get subscriptionDetails => 'subscription_details'.tr();
  static String get viewCourse => 'view_course'.tr();
  static String get continueLearning => 'continue_learning'.tr();
  static String get pleaseSelectSubject => 'please_select_subject'.tr();
  static String get pleaseEnterTitle => 'please_enter_title'.tr();
  static String get pleaseEnterDescription => 'please_enter_description'.tr();
  static String get pleaseSelectDate => 'please_select_date'.tr();
  static String get pleaseEnterAdminUsername => 'please_enter_admin_username'.tr();
  static String get pleaseEnterAdminPassword => 'please_enter_admin_password'.tr();
  static String get codeSentTo => 'code_sent_to'.tr();
  static String get phoneNumberDisplay => 'phone_number_display'.tr();
}

