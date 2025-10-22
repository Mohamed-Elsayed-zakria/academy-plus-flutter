import 'package:dio/dio.dart';
import '../../../../core/constants/api_end_point.dart';
import '../../../../core/errors/server_failures.dart';
import '../models/update_profile_model.dart';
import 'package:dartz/dartz.dart';
import 'profile_repo.dart';

class ProfileImplement extends ProfileRepo {
  @override
  Future<Either<Failures, void>> updateProfile(UpdateProfileModel updateProfileModel) async {
    try {
      const url = "${APIEndPoint.url}${APIEndPoint.userProfile}";
      final formData = FormData.fromMap({
        if (updateProfileModel.fullName != null) 'full_name': updateProfileModel.fullName!,
        if (updateProfileModel.profileImage != null)
          'profile_image': await MultipartFile.fromFile(
            updateProfileModel.profileImage!.path,
            filename: 'profile_image.jpg',
          ),
      });
      final response = await dio.put(url, data: formData);
      if (response.statusCode == 200) {
        return right(null);
      } else {
        return left(ServerFailures(errMessage: 'Failed to update profile'));
      }
    } catch (e) {
      return left(returnDioException(e));
    }
  }
}
