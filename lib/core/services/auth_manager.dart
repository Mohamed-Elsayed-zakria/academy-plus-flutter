import '../../features/auth/data/models/login_model.dart';
import 'auth_service.dart';
import 'dio_service.dart';
import 'dart:developer';

class AuthManager {
  static UserModel? _currentUser;
  static String? _currentToken;

  // Initialize auth state on app start
  static Future<void> initialize() async {
    final isLoggedIn = await AuthService.isLoggedIn();

    if (isLoggedIn) {
      _currentToken = await AuthService.getToken();
      _currentUser = await AuthService.getUser();

      if (_currentToken != null) {
        DioService.updateToken(_currentToken!);
        log('🔐 Auth initialized - User logged in: ${_currentUser?.fullName}');
      }
    } else {
      log('🔓 Auth initialized - No user logged in');
    }
  }

  // Get current user
  static UserModel? get currentUser => _currentUser;

  // Get current token
  static String? get currentToken => _currentToken;

  // Check if user is logged in
  static bool get isLoggedIn => _currentUser != null && _currentToken != null;

  // Check if user is logged in (with SharedPreferences verification)
  static Future<bool> isLoggedInAsync() async {
    log('🔄 AuthManager.isLoggedInAsync() - Starting verification...');

    // First check local variables
    log(
      '🔍 Local check - _currentUser: ${_currentUser != null}, _currentToken: ${_currentToken != null}',
    );

    if (_currentUser != null && _currentToken != null) {
      // Double-check with SharedPreferences
      final isLoggedInPrefs = await AuthService.isLoggedIn();
      log('🔍 SharedPreferences check - isLoggedIn: $isLoggedInPrefs');

      if (!isLoggedInPrefs) {
        // Clear local data if SharedPreferences says user is not logged in
        log(
          '⚠️ SharedPreferences says user is not logged in, clearing local data...',
        );
        clearUserData();
        log('🔍 After clearing - isLoggedIn: false');
        return false;
      }
      log('✅ User is logged in (verified with SharedPreferences)');
      return true;
    }

    log('🔍 User is not logged in (no local data)');
    return false;
  }

  // Update user data after login
  static void updateUserData(LoginResponseModel loginResponse) {
    _currentUser = loginResponse.user;
    _currentToken = loginResponse.token;
    DioService.updateToken(loginResponse.token);
  }

  // Clear user data after logout
  static void clearUserData() {
    _currentUser = null;
    _currentToken = null;
    DioService.clearToken();
  }

  // Check if phone is verified
  static bool get isPhoneVerified => _currentUser?.phoneVerified ?? false;

  // Check if phone verification is needed (for app startup routing)
  static bool get needsPhoneVerification => _currentUser != null && _currentToken != null && !isPhoneVerified;

  // Get user role
  static String get userRole => _currentUser?.role ?? 'Student';

  // Get user ID
  static String? get userId => _currentUser?.id;

  // Get university ID
  static String? get universityId => _currentUser?.universityId;
}
