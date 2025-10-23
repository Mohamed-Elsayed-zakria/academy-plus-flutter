abstract class APIEndPoint {
  static const url = "https://academy-plus.vercel.app";
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
  
  // Cart endpoints
  static const cartItems = "/api/cart/items";
  static const cartSummary = "/api/cart/summary";
  static const cartTotal = "/api/cart/total";
  static const cartClear = "/api/cart/clear";
}
