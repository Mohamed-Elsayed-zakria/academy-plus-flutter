import 'package:equatable/equatable.dart';
import '../../data/models/course_model.dart';

abstract class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object?> get props => [];
}

class CourseInitial extends CourseState {}

class CourseLoading extends CourseState {}

class CourseLoaded extends CourseState {
  final List<CourseModel> courses;

  const CourseLoaded({required this.courses});

  @override
  List<Object?> get props => [courses];
}

class CourseError extends CourseState {
  final String error;

  const CourseError({required this.error});

  @override
  List<Object?> get props => [error];
}

// Cart-related states
class CourseAddingToCart extends CourseState {
  final String courseId;
  final List<CourseModel> courses;

  const CourseAddingToCart({
    required this.courseId,
    required this.courses,
  });

  @override
  List<Object?> get props => [courseId, courses];
}

class CourseAddedToCart extends CourseState {
  final String courseId;
  final List<CourseModel> courses;
  final String message;

  const CourseAddedToCart({
    required this.courseId,
    required this.courses,
    required this.message,
  });

  @override
  List<Object?> get props => [courseId, courses, message];
}

class CourseCartError extends CourseState {
  final String courseId;
  final List<CourseModel> courses;
  final String error;

  const CourseCartError({
    required this.courseId,
    required this.courses,
    required this.error,
  });

  @override
  List<Object?> get props => [courseId, courses, error];
}