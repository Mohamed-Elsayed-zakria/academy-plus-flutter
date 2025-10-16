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

  // Logout - clear all data
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
    await prefs.setBool(_isLoggedInKey, false);
    
    print('User logged out successfully');
  }

  // Helper method to convert UserModel to JSON string
  static String _userToJson(UserModel user) {
    return '{"id":"${user.id}","full_name":"${user.fullName}","phone_number":"${user.phoneNumber}","phone_verified":${user.phoneVerified},"role":"${user.role}"}';
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
    };
    
    return UserModel.fromJson(userMap);
  }
}
