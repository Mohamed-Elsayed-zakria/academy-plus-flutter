import '../../../../core/constants/api_end_point.dart';
import '../../../../core/errors/server_failures.dart';
import '../models/ad_model.dart';
import 'package:dartz/dartz.dart';
import 'ad_repo.dart';

class AdImplement extends AdRepo {
  @override
  Future<Either<Failures, List<AdModel>>> getAllAds() async {
    try {
      const url = "${APIEndPoint.url}${APIEndPoint.ads}";

      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['success'] == true && responseData['data'] != null) {
          final List<dynamic> adsJson = responseData['data'];
          final List<AdModel> ads = adsJson.map((json) => AdModel.fromJson(json)).toList();
          return right(ads);
        } else {
          return left(ServerFailures(errMessage: 'Invalid response format'));
        }
      } else {
        return left(ServerFailures(errMessage: 'Failed to fetch ads'));
      }
    } catch (e) {
      return left(returnDioException(e));
    }
  }

  @override
  Future<Either<Failures, List<AdModel>>> getAdsByUniversity(String universityId) async {
    try {
      final url = "${APIEndPoint.url}${APIEndPoint.adsByUniversity}/$universityId";

      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['success'] == true && responseData['data'] != null) {
          final List<dynamic> adsJson = responseData['data'];
          final List<AdModel> ads = adsJson.map((json) => AdModel.fromJson(json)).toList();
          return right(ads);
        } else {
          return left(ServerFailures(errMessage: 'Invalid response format'));
        }
      } else {
        return left(ServerFailures(errMessage: 'Failed to fetch ads by university'));
      }
    } catch (e) {
      return left(returnDioException(e));
    }
  }

  @override
  Future<Either<Failures, AdModel>> getAdById(String adId) async {
    try {
      final url = "${APIEndPoint.url}${APIEndPoint.ads}/$adId";

      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['success'] == true && responseData['data'] != null) {
          final ad = AdModel.fromJson(responseData['data']);
          return right(ad);
        } else {
          return left(ServerFailures(errMessage: 'Invalid response format'));
        }
      } else {
        return left(ServerFailures(errMessage: 'Failed to fetch ad'));
      }
    } catch (e) {
      return left(returnDioException(e));
    }
  }
}
