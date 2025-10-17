import '../../../../core/errors/server_failures.dart';
import '../../../../core/services/base_service.dart';
import 'package:dartz/dartz.dart';
import '../models/sub_department_model.dart';

abstract class SubDepartmentRepo extends BaseServices {
  Future<Either<Failures, List<SubDepartmentModel>>> getAllSubDepartments();
  Future<Either<Failures, List<SubDepartmentModel>>> getSubDepartmentsByDepartment(String departmentId);
  Future<Either<Failures, SubDepartmentModel>> getSubDepartmentById(String subDepartmentId);
}
