abstract class APIEndPoint {
  static const url = "http://192.168.0.106:3000";
  static const register = "/api/auth/register";
  static const login = "/api/auth/login";
  static const logout = "/api/auth/logout";
  static const universities = "/api/universities";
  static const departments = "/api/departments";
  static const otpRequest = "/api/auth/otp/request";
  static const otpVerify = "/api/auth/otp/verify";
  static const userProfile = "/api/users/profile";
  static const ads = "/api/ads";
  static const adsByUniversity = "/api/ads/university";
}
