import 'package:shared_preferences/shared_preferences.dart';

class UniversityService {
  static const String _universityIdKey = 'university_id';

  // Save university ID
  static Future<void> saveUniversityId(String universityId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_universityIdKey, universityId);
    print('University ID saved: $universityId');
  }

  // Get university ID
  static Future<String?> getUniversityId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_universityIdKey);
  }

  // Clear university ID
  static Future<void> clearUniversityId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_universityIdKey);
    print('University ID cleared');
  }

  // Check if university ID exists
  static Future<bool> hasUniversityId() async {
    final universityId = await getUniversityId();
    return universityId != null && universityId.isNotEmpty;
  }
}
