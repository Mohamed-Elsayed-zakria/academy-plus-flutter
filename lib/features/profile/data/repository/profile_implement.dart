import '../../../../core/constants/api_end_point.dart';
import '../../../../core/errors/server_failures.dart';
import '../models/user_profile_model.dart';
import 'package:dartz/dartz.dart';
import 'profile_repo.dart';

class ProfileImplement extends ProfileRepo {
  @override
  Future<Either<Failures, UserProfileModel>> getUserProfile() async {
    try {
      const url = "${APIEndPoint.url}${APIEndPoint.userProfile}";

      final response = await dio.get(url);

      if (response.statusCode == 200) {
        // Extract data from the nested structure
        final responseData = response.data;
        if (responseData['success'] == true && responseData['data'] != null) {
          final userProfile = UserProfileModel.fromJson(responseData['data']);
          return right(userProfile);
        } else {
          return left(ServerFailures(errMessage: 'Invalid response format'));
        }
      } else {
        return left(ServerFailures(errMessage: 'Failed to fetch user profile'));
      }
    } catch (e) {
      print('Get Profile Error: $e');
      return left(returnDioException(e));
    }
  }

  @override
  Future<Either<Failures, UserProfileModel>> updateUserProfile(
    UserProfileModel profile,
  ) async {
    try {
      const url = "${APIEndPoint.url}${APIEndPoint.userProfile}";
      final requestData = profile.toJson();

      print('Update Profile Request:');
      print('URL: $url');
      print('Data: $requestData');

      final response = await dio.put(url, data: requestData);

      print('Update Profile Response:');
      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final updatedProfile = UserProfileModel.fromJson(response.data);
        return right(updatedProfile);
      } else {
        return left(
          ServerFailures(errMessage: 'Failed to update user profile'),
        );
      }
    } catch (e) {
      print('Update Profile Error: $e');
      return left(returnDioException(e));
    }
  }
}
