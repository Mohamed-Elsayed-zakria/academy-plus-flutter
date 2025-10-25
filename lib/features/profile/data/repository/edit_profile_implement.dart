import '../../../../core/constants/api_end_point.dart';
import '../../../../core/errors/server_failures.dart';
import '../models/user_profile_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'edit_profile_repo.dart';

class EditProfileImplement extends EditProfileRepo {
  @override
  Future<Either<Failures, UserProfileModel>> updateUserProfile(
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
}
