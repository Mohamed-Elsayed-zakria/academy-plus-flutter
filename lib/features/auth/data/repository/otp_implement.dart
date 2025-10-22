import '../../../../core/constants/api_end_point.dart';
import '../../../../core/errors/server_failures.dart';
import '../models/otp_request_model.dart';
import '../models/otp_verify_model.dart';
import '../models/forgot_password_model.dart';
import '../models/reset_password_model.dart';
import 'package:dartz/dartz.dart';
import 'otp_repo.dart';

class OtpImplement extends OtpRepo {
  @override
  Future<Either<Failures, void>> requestOtp(OtpRequestModel otpRequestModel) async {
    try {
      const url = "${APIEndPoint.url}${APIEndPoint.otpRequest}";
      final requestData = otpRequestModel.toJson();
      
      print('OTP Request:');
      print('URL: $url');
      print('Data: $requestData');
      
      final response = await dio.post(url, data: requestData);
      
      print('OTP Request Response:');
      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
      
      if (response.statusCode == 200) {
        return right(null);
      } else {
        return left(ServerFailures(errMessage: 'Failed to request OTP'));
      }
    } catch (e) {
      print('OTP Request Error: $e');
      return left(returnDioException(e));
    }
  }

  @override
  Future<Either<Failures, void>> verifyOtp(OtpVerifyModel otpVerifyModel) async {
    try {
      const url = "${APIEndPoint.url}${APIEndPoint.otpVerify}";
      final requestData = otpVerifyModel.toJson();
      
      print('OTP Verify Request:');
      print('URL: $url');
      print('Data: $requestData');
      
      final response = await dio.post(url, data: requestData);
      
      print('OTP Verify Response:');
      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
      
      if (response.statusCode == 200) {
        return right(null);
      } else {
        return left(ServerFailures(errMessage: 'Invalid OTP code'));
      }
    } catch (e) {
      print('OTP Verify Error: $e');
      return left(returnDioException(e));
    }
  }

  @override
  Future<Either<Failures, void>> forgotPassword(ForgotPasswordModel forgotPasswordModel) async {
    try {
      const url = "${APIEndPoint.url}${APIEndPoint.forgotPassword}";
      final requestData = forgotPasswordModel.toJson();
      
      print('Forgot Password Request:');
      print('URL: $url');
      print('Data: $requestData');
      
      final response = await dio.post(url, data: requestData);
      
      print('Forgot Password Response:');
      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
      
      if (response.statusCode == 200) {
        return right(null);
      } else {
        return left(ServerFailures(errMessage: 'Failed to send password reset code'));
      }
    } catch (e) {
      print('Forgot Password Error: $e');
      return left(returnDioException(e));
    }
  }

  @override
  Future<Either<Failures, void>> resetPassword(ResetPasswordModel resetPasswordModel) async {
    try {
      const url = "${APIEndPoint.url}${APIEndPoint.resetPassword}";
      final requestData = resetPasswordModel.toJson();
      
      print('Reset Password Request:');
      print('URL: $url');
      print('Data: $requestData');
      
      final response = await dio.post(url, data: requestData);
      
      print('Reset Password Response:');
      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
      
      if (response.statusCode == 200) {
        return right(null);
      } else {
        return left(ServerFailures(errMessage: 'Failed to reset password'));
      }
    } catch (e) {
      print('Reset Password Error: $e');
      return left(returnDioException(e));
    }
  }
}
