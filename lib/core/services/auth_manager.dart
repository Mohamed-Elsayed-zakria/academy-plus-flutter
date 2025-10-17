import 'auth_service.dart';
import 'dio_service.dart';
import '../../features/auth/data/models/login_model.dart';

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
        print('🔐 Auth initialized - User logged in: ${_currentUser?.fullName}');
      }
    } else {
      print('🔓 Auth initialized - No user logged in');
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
    print('🔄 AuthManager.isLoggedInAsync() - Starting verification...');
    
    // First check local variables
    print('🔍 Local check - _currentUser: ${_currentUser != null}, _currentToken: ${_currentToken != null}');
    
    if (_currentUser != null && _currentToken != null) {
      // Double-check with SharedPreferences
      final isLoggedInPrefs = await AuthService.isLoggedIn();
      print('🔍 SharedPreferences check - isLoggedIn: $isLoggedInPrefs');
      
      if (!isLoggedInPrefs) {
        // Clear local data if SharedPreferences says user is not logged in
        print('⚠️ SharedPreferences says user is not logged in, clearing local data...');
        clearUserData();
        print('🔍 After clearing - isLoggedIn: false');
        return false;
      }
      print('✅ User is logged in (verified with SharedPreferences)');
      return true;
    }
    
    print('🔍 User is not logged in (no local data)');
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

  // Get user role
  static String get userRole => _currentUser?.role ?? 'Student';

  // Get user ID
  static String? get userId => _currentUser?.id;

  // Get university ID
  static String? get universityId => _currentUser?.universityId;
}
