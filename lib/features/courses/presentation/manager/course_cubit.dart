import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/server_failures.dart';
import '../../../../../core/services/service_locator.dart';
import '../../data/models/course_model.dart';
import '../../data/repository/course_repo.dart';
import '../../../cart/data/repository/cart_repo.dart';
import 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit(this._courseRepo) : super(CourseInitial());
  final CourseRepo _courseRepo;
  final CartRepo _cartRepo = SetupLocator.locator<CartRepo>();

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

  // Add course to cart
  Future<void> addCourseToCart(CourseModel course) async {
    // Get current courses list
    List<CourseModel> currentCourses = [];
    if (state is CourseLoaded) {
      currentCourses = (state as CourseLoaded).courses;
    }

    // Emit adding to cart state
    emit(CourseAddingToCart(
      courseId: course.id,
      courses: currentCourses,
    ));

    try {
      final result = await _cartRepo.addItemToCart(
        itemType: 'course',
        itemId: course.id,
      );

      result.fold(
        (failure) {
          emit(CourseCartError(
            courseId: course.id,
            courses: currentCourses,
            error: failure.errMessage,
          ));
        },
        (response) {
          emit(CourseAddedToCart(
            courseId: course.id,
            courses: currentCourses,
            message: 'تم إضافة "${course.titleAr}" إلى السلة',
          ));
        },
      );
    } catch (e) {
      emit(CourseCartError(
        courseId: course.id,
        courses: currentCourses,
        error: 'حدث خطأ غير متوقع',
      ));
    }
  }
}
