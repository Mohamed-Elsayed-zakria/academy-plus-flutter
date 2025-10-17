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
