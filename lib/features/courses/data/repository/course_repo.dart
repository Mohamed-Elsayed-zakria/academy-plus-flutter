import '../../../../core/errors/server_failures.dart';
import '../../../../core/services/base_service.dart';
import 'package:dartz/dartz.dart';
import '../models/course_model.dart';

abstract class CourseRepo extends BaseServices {
  Future<Either<Failures, List<CourseModel>>> getAllCourses();
  Future<Either<Failures, List<CourseModel>>> getCoursesBySubDepartment(String subDepartmentId);
  Future<Either<Failures, CourseModel>> getCourseById(String courseId);
}
