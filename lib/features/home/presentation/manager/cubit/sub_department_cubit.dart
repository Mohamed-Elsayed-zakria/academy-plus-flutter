import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/server_failures.dart';
import '../../../data/models/sub_department_model.dart';
import '../../../data/repository/sub_department_repo.dart';
import 'sub_department_state.dart';

class SubDepartmentCubit extends Cubit<SubDepartmentState> {
  SubDepartmentCubit(this._subDepartmentRepo) : super(SubDepartmentInitial());
  final SubDepartmentRepo _subDepartmentRepo;

  Future<void> getAllSubDepartments() async {
    emit(SubDepartmentLoading());
    Either<Failures, List<SubDepartmentModel>> result = await _subDepartmentRepo.getAllSubDepartments();
    result.fold(
      (failures) => emit(SubDepartmentError(error: failures.errMessage)),
      (subDepartments) => emit(SubDepartmentLoaded(subDepartments: subDepartments)),
    );
  }

  Future<void> getSubDepartmentsByDepartment(String departmentId) async {
    emit(SubDepartmentLoading());
    Either<Failures, List<SubDepartmentModel>> result = await _subDepartmentRepo.getSubDepartmentsByDepartment(departmentId);
    result.fold(
      (failures) => emit(SubDepartmentError(error: failures.errMessage)),
      (subDepartments) => emit(SubDepartmentLoaded(subDepartments: subDepartments)),
    );
  }

  Future<void> getSubDepartmentById(String subDepartmentId) async {
    emit(SubDepartmentLoading());
    Either<Failures, SubDepartmentModel> result = await _subDepartmentRepo.getSubDepartmentById(subDepartmentId);
    result.fold(
      (failures) => emit(SubDepartmentError(error: failures.errMessage)),
      (subDepartment) => emit(SubDepartmentLoaded(subDepartments: [subDepartment])),
    );
  }
}
