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
      
      print('Update Profile Request:');
      print('URL: $url');
      print('Profile Name: $name');
      print('Has Image: ${profileImage != null}');

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

      print('Update Profile Response:');
      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

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
      print('Update Profile Error: $e');
      return left(returnDioException(e));
    }
  }
}
