import '../../../../core/errors/server_failures.dart';
import '../../../../core/services/base_service.dart';
import 'package:dartz/dartz.dart';
import '../models/otp_request_model.dart';
import '../models/otp_verify_model.dart';
import '../models/forgot_password_model.dart';
import '../models/reset_password_model.dart';

abstract class OtpRepo extends BaseServices {
  Future<Either<Failures, void>> requestOtp(OtpRequestModel otpRequestModel);
  Future<Either<Failures, void>> verifyOtp(OtpVerifyModel otpVerifyModel);
  Future<Either<Failures, void>> forgotPassword(ForgotPasswordModel forgotPasswordModel);
  Future<Either<Failures, void>> resetPassword(ResetPasswordModel resetPasswordModel);
}
