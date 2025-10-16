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
}
