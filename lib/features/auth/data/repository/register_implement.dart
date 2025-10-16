import '../../../../core/constants/api_end_point.dart';
import '../../../../core/errors/server_failures.dart';
import '../models/register_model.dart';
import 'package:dartz/dartz.dart';
import 'register_repo.dart';

class RegisterImplement extends RegisterRepo {
  @override
  Future<Either<Failures, void>> register({
    required RegisterModel loginModel,
  }) async {
    try {
      const url = "${APIEndPoint.url}${APIEndPoint.register}";
      await dio.post(url, data: loginModel.toJson());
      return right(null);
    } catch (e) {
      return left(returnDioException(e));
    }
  }
}
