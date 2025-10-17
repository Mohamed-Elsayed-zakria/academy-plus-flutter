import 'package:dartz/dartz.dart';
import '../../../../core/constants/api_end_point.dart';
import '../../../../core/errors/server_failures.dart';
import '../models/course_model.dart';
import 'course_repo.dart';

class CourseImplement extends CourseRepo {
  @override
  Future<Either<Failures, List<CourseModel>>> getAllCourses() async {
    try {
      final response = await dio.get(
        '${APIEndPoint.url}${APIEndPoint.courses}',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] != null) {
          final List<dynamic> coursesJson = data['data'];
          final List<CourseModel> courses = coursesJson
              .map((json) => CourseModel.fromJson(json))
              .toList();
          return Right(courses);
        } else {
          return Left(ServerFailures(errMessage: data['message'] ?? 'Failed to fetch courses'));
        }
      } else {
        return Left(ServerFailures(errMessage: 'Failed to fetch courses'));
      }
    } catch (e) {
      return Left(returnDioException(e));
    }
  }

  @override
  Future<Either<Failures, List<CourseModel>>> getCoursesBySubDepartment(String subDepartmentId) async {
    try {
      final response = await dio.get(
        '${APIEndPoint.url}${APIEndPoint.courses}/sub-department/$subDepartmentId',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] != null) {
          final List<dynamic> coursesJson = data['data'];
          final List<CourseModel> courses = coursesJson
              .map((json) => CourseModel.fromJson(json))
              .toList();
          return Right(courses);
        } else {
          return Left(ServerFailures(errMessage: data['message'] ?? 'Failed to fetch courses'));
        }
      } else {
        return Left(ServerFailures(errMessage: 'Failed to fetch courses'));
      }
    } catch (e) {
      return Left(returnDioException(e));
    }
  }

  @override
  Future<Either<Failures, CourseModel>> getCourseById(String courseId) async {
    try {
      final response = await dio.get(
        '${APIEndPoint.url}${APIEndPoint.courses}/$courseId',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] != null) {
          final CourseModel course = CourseModel.fromJson(data['data']);
          return Right(course);
        } else {
          return Left(ServerFailures(errMessage: data['message'] ?? 'Failed to fetch course'));
        }
      } else {
        return Left(ServerFailures(errMessage: 'Failed to fetch course'));
      }
    } catch (e) {
      return Left(returnDioException(e));
    }
  }
}
