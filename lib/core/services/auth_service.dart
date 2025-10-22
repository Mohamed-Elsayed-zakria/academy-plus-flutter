import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/data/models/login_model.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';
  static const String _isLoggedInKey = 'is_logged_in';

  // Save login data
  static Future<void> saveLoginData(LoginResponseModel loginResponse) async {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setString(_tokenKey, loginResponse.token);
    await prefs.setString(_userKey, _userToJson(loginResponse.user));
    await prefs.setBool(_isLoggedInKey, true);
    
    print('Login data saved successfully');
    print('Token: ${loginResponse.token}');
    print('User: ${loginResponse.user.fullName}');
    print('University ID: ${loginResponse.user.universityId}');
  }

  // Get auth token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Get user data
  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    
    if (userJson != null) {
      return _userFromJson(userJson);
    }
    return null;
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Update phone verification status
  static Future<void> updatePhoneVerificationStatus(bool isVerified) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    
    if (userJson != null) {
      // Parse current user data
      final user = _userFromJson(userJson);
      
      // Create updated user with new verification status
      final updatedUser = UserModel(
        id: user.id,
        fullName: user.fullName,
        phoneNumber: user.phoneNumber,
        phoneVerified: isVerified,
        role: user.role,
        universityId: user.universityId,
      );
      
      // Save updated user data
      await prefs.setString(_userKey, _userToJson(updatedUser));
      
      print('Phone verification status updated: $isVerified');
    }
  }

  // Logout - clear all data
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    
    print('🔄 AuthService.logout() - Starting logout process...');
    
    // Check current state before clearing
    final currentToken = prefs.getString(_tokenKey);
    final currentIsLoggedIn = prefs.getBool(_isLoggedInKey);
    print('🔍 Before logout - Token exists: ${currentToken != null}, isLoggedIn: $currentIsLoggedIn');
    
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
    await prefs.setBool(_isLoggedInKey, false);
    
    // Verify after clearing
    final tokenAfter = prefs.getString(_tokenKey);
    final isLoggedInAfter = prefs.getBool(_isLoggedInKey);
    print('🔍 After logout - Token exists: ${tokenAfter != null}, isLoggedIn: $isLoggedInAfter');
    
    print('✅ AuthService.logout() - User logged out successfully');
  }

  // Helper method to convert UserModel to JSON string
  static String _userToJson(UserModel user) {
    return '{"id":"${user.id}","full_name":"${user.fullName}","phone_number":"${user.phoneNumber}","phone_verified":${user.phoneVerified},"role":"${user.role}","university_id":"${user.universityId ?? ''}"}';
  }

  // Helper method to convert JSON string to UserModel
  static UserModel _userFromJson(String userJson) {
    // Simple JSON parsing for the stored user data
    final Map<String, dynamic> userMap = {
      'id': userJson.split('"id":"')[1].split('"')[0],
      'full_name': userJson.split('"full_name":"')[1].split('"')[0],
      'phone_number': userJson.split('"phone_number":"')[1].split('"')[0],
      'phone_verified': userJson.split('"phone_verified":')[1].split(',')[0] == 'true',
      'role': userJson.split('"role":"')[1].split('"')[0],
      'university_id': userJson.contains('"university_id":"') ? userJson.split('"university_id":"')[1].split('"')[0] : null,
    };
    
    return UserModel.fromJson(userMap);
  }
}
