import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/server_failures.dart';
import '../../data/models/course_model.dart';
import '../../data/repository/course_repo.dart';
import 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit(this._courseRepo) : super(CourseInitial());
  final CourseRepo _courseRepo;

  Future<void> getAllCourses() async {
    emit(CourseLoading());
    Either<Failures, List<CourseModel>> result = await _courseRepo.getAllCourses();
    result.fold(
      (failures) => emit(CourseError(error: failures.errMessage)),
      (courses) => emit(CourseLoaded(courses: courses)),
    );
  }

  Future<void> getCoursesBySubDepartment(String subDepartmentId) async {
    emit(CourseLoading());
    Either<Failures, List<CourseModel>> result = await _courseRepo.getCoursesBySubDepartment(subDepartmentId);
    result.fold(
      (failures) => emit(CourseError(error: failures.errMessage)),
      (courses) => emit(CourseLoaded(courses: courses)),
    );
  }

  Future<void> getCourseById(String courseId) async {
    emit(CourseLoading());
    Either<Failures, CourseModel> result = await _courseRepo.getCourseById(courseId);
    result.fold(
      (failures) => emit(CourseError(error: failures.errMessage)),
      (course) => emit(CourseLoaded(courses: [course])),
    );
  }
}
