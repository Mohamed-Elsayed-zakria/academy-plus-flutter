import '../../../../core/constants/api_end_point.dart';
import '../../../../core/errors/server_failures.dart';
import '../models/otp_request_model.dart';
import '../models/otp_verify_model.dart';
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
}
