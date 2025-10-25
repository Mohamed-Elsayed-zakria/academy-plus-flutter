import '../../../../core/errors/server_failures.dart';
import '../../../../core/services/base_service.dart';
import 'package:dartz/dartz.dart';
import '../models/coupon_validation_response.dart';

abstract class CouponRepo extends BaseServices {
  Future<Either<Failures, CouponValidationResponse>> validateCoupon(String couponCode);
}
