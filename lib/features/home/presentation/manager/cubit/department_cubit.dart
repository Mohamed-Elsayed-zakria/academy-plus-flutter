import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/server_failures.dart';
import '../../../data/models/department_model.dart';
import '../../../data/repository/department_repo.dart';
import 'department_state.dart';

class DepartmentCubit extends Cubit<DepartmentState> {
  DepartmentCubit(this._departmentRepo) : super(DepartmentInitial());
  final DepartmentRepo _departmentRepo;

  Future<void> getAllDepartments() async {
    emit(DepartmentLoading());
    Either<Failures, List<DepartmentModel>> result = await _departmentRepo.getAllDepartments();
    result.fold(
      (failures) => emit(DepartmentError(error: failures.errMessage)),
      (departments) => emit(DepartmentLoaded(departments: departments)),
    );
  }

  Future<void> getDepartmentsByUniversity(String universityId) async {
    emit(DepartmentLoading());
    Either<Failures, List<DepartmentModel>> result = await _departmentRepo.getDepartmentsByUniversity(universityId);
    result.fold(
      (failures) => emit(DepartmentError(error: failures.errMessage)),
      (departments) => emit(DepartmentLoaded(departments: departments)),
    );
  }

  Future<void> getDepartmentById(String departmentId) async {
    emit(DepartmentLoading());
    Either<Failures, DepartmentModel> result = await _departmentRepo.getDepartmentById(departmentId);
    result.fold(
      (failures) => emit(DepartmentError(error: failures.errMessage)),
      (department) => emit(DepartmentLoaded(departments: [department])),
    );
  }
}
