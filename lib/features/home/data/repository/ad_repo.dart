import '../../../../core/errors/server_failures.dart';
import '../../../../core/services/base_service.dart';
import 'package:dartz/dartz.dart';
import '../models/ad_model.dart';

abstract class AdRepo extends BaseServices {
  Future<Either<Failures, List<AdModel>>> getAllAds();
  Future<Either<Failures, List<AdModel>>> getAdsByUniversity(String universityId);
  Future<Either<Failures, AdModel>> getAdById(String adId);
}
