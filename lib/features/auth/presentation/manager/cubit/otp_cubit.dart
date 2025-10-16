import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/server_failures.dart';
import '../../../data/models/otp_request_model.dart';
import '../../../data/models/otp_verify_model.dart';
import '../../../data/repository/otp_repo.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this._otpRepo) : super(OtpInitial());
  final OtpRepo _otpRepo;

  Future<void> requestOtp(String phoneNumber) async {
    emit(OtpRequestLoading());
    Either<Failures, void> result = await _otpRepo.requestOtp(
      OtpRequestModel(phoneNumber: phoneNumber),
    );
    result.fold(
      (failures) => emit(OtpRequestError(error: failures.errMessage)),
      (_) => emit(OtpRequestSuccess()),
    );
  }

  Future<void> verifyOtp(String phoneNumber, String otpCode) async {
    emit(OtpVerifyLoading());
    Either<Failures, void> result = await _otpRepo.verifyOtp(
      OtpVerifyModel(phoneNumber: phoneNumber, otpCode: otpCode),
    );
    result.fold(
      (failures) => emit(OtpVerifyError(error: failures.errMessage)),
      (_) => emit(OtpVerifySuccess()),
    );
  }
}
