import '../../../../core/errors/server_failures.dart';
import '../../../../core/services/base_service.dart';
import 'package:dartz/dartz.dart';
import '../models/otp_request_model.dart';
import '../models/otp_verify_model.dart';

abstract class OtpRepo extends BaseServices {
  Future<Either<Failures, void>> requestOtp(OtpRequestModel otpRequestModel);
  Future<Either<Failures, void>> verifyOtp(OtpVerifyModel otpVerifyModel);
}
