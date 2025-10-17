import 'package:equatable/equatable.dart';
import '../../../data/models/department_model.dart';

abstract class DepartmentState extends Equatable {
  const DepartmentState();

  @override
  List<Object?> get props => [];
}

class DepartmentInitial extends DepartmentState {}

class DepartmentLoading extends DepartmentState {}

class DepartmentLoaded extends DepartmentState {
  final List<DepartmentModel> departments;

  const DepartmentLoaded({required this.departments});

  @override
  List<Object?> get props => [departments];
}

class DepartmentError extends DepartmentState {
  final String error;

  const DepartmentError({required this.error});

  @override
  List<Object?> get props => [error];
}
