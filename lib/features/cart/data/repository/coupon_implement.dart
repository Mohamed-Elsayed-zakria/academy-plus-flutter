import '../../../../core/constants/api_end_point.dart';
import '../../../../core/errors/server_failures.dart';
import '../models/coupon_validation_response.dart';
import 'package:dartz/dartz.dart';
import 'coupon_repo.dart';

class CouponImplement extends CouponRepo {
  @override
  Future<Either<Failures, CouponValidationResponse>> validateCoupon(String couponCode) async {
    try {
      final url = "${APIEndPoint.url}${APIEndPoint.couponValidate}/$couponCode";
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final validationResponse = CouponValidationResponse.fromJson(response.data);
        return right(validationResponse);
      } else {
        return left(ServerFailures(errMessage: 'Failed to validate coupon'));
      }
    } catch (e) {
      return left(returnDioException(e));
    }
  }
}
