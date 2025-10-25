import '../../../../core/constants/api_end_point.dart';
import '../../../../core/errors/server_failures.dart';
import '../models/user_profile_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'dart:io';
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
      return left(returnDioException(e));
    }
  }

  @override
  Future<Either<Failures, UserProfileModel>> updateUserProfile(
    UserProfileModel profile,
  ) async {
    try {
      const url = "${APIEndPoint.url}${APIEndPoint.userProfile}";

      // Create FormData for the request
      final formData = FormData.fromMap({
        'full_name': profile.name,
        // Note: profile_image will be handled separately if needed
      });

      final response = await dio.put(url, data: formData);

      if (response.statusCode == 200) {
        // Extract data from the nested structure
        final responseData = response.data;
        if (responseData['success'] == true && responseData['data'] != null) {
          final updatedProfile = UserProfileModel.fromJson(responseData['data']);
          return right(updatedProfile);
        } else {
          return left(ServerFailures(errMessage: 'Invalid response format'));
        }
      } else {
        return left(
          ServerFailures(errMessage: 'Failed to update user profile'),
        );
      }
    } catch (e) {
      return left(returnDioException(e));
    }
  }

  @override
  Future<Either<Failures, UserProfileModel>> updateUserProfileWithImage(
    String name,
    File? profileImage,
  ) async {
    try {
      const url = "${APIEndPoint.url}${APIEndPoint.userProfile}";

      // Create FormData for the request
      final Map<String, dynamic> formDataMap = {
        'full_name': name,
      };

      // Add image if provided
      if (profileImage != null) {
        formDataMap['profile_image'] = await MultipartFile.fromFile(
          profileImage.path,
          filename: 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg',
        );
      }

      final formData = FormData.fromMap(formDataMap);

      final response = await dio.put(url, data: formData);

      if (response.statusCode == 200) {
        // Extract data from the nested structure
        final responseData = response.data;
        if (responseData['success'] == true && responseData['data'] != null) {
          final updatedProfile = UserProfileModel.fromJson(responseData['data']);
          return right(updatedProfile);
        } else {
          return left(ServerFailures(errMessage: 'Invalid response format'));
        }
      } else {
        return left(
          ServerFailures(errMessage: 'Failed to update user profile'),
        );
      }
    } catch (e) {
      return left(returnDioException(e));
    }
  }

  @override
  Future<Either<Failures, bool>> logout() async {
    try {
      const url = "${APIEndPoint.url}${APIEndPoint.logout}";

      final response = await dio.post(url);

      if (response.statusCode == 200) {
        // Check if logout was successful
        final responseData = response.data;
        if (responseData['success'] == true) {
          return right(true);
        } else {
          return left(ServerFailures(errMessage: 'Logout failed'));
        }
      } else {
        return left(ServerFailures(errMessage: 'Failed to logout'));
      }
    } catch (e) {
      return left(returnDioException(e));
    }
  }
}
