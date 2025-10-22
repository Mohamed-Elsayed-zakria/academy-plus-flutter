abstract class APIEndPoint {
  static const url = "http://192.168.0.104:4000";
  static const register = "/api/auth/register";
  static const login = "/api/auth/login";
  static const logout = "/api/auth/logout";
  static const universities = "/api/universities";
  static const departments = "/api/departments";
  static const subDepartments = "/api/sub-departments";
  static const courses = "/api/courses";
  static const otpRequest = "/api/auth/otp/request";
  static const otpVerify = "/api/auth/otp/verify";
  static const forgotPassword = "/api/auth/forgot-password";
  static const resetPassword = "/api/auth/reset-password";
  static const userProfile = "/api/users/profile";
  static const ads = "/api/ads";
  static const adsByUniversity = "/api/ads/university";
}
