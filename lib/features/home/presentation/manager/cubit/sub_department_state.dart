import 'package:equatable/equatable.dart';
import '../../../data/models/sub_department_model.dart';

abstract class SubDepartmentState extends Equatable {
  const SubDepartmentState();

  @override
  List<Object?> get props => [];
}

class SubDepartmentInitial extends SubDepartmentState {}

class SubDepartmentLoading extends SubDepartmentState {}

class SubDepartmentLoaded extends SubDepartmentState {
  final List<SubDepartmentModel> subDepartments;

  const SubDepartmentLoaded({required this.subDepartments});

  @override
  List<Object?> get props => [subDepartments];
}

class SubDepartmentError extends SubDepartmentState {
  final String error;

  const SubDepartmentError({required this.error});

  @override
  List<Object?> get props => [error];
}
