import '../../../../core/errors/server_failures.dart';
import '../../../../core/services/base_service.dart';
import 'package:dartz/dartz.dart';
import '../models/department_model.dart';

abstract class DepartmentRepo extends BaseServices {
  Future<Either<Failures, List<DepartmentModel>>> getAllDepartments();
  Future<Either<Failures, List<DepartmentModel>>> getDepartmentsByUniversity(String universityId);
  Future<Either<Failures, DepartmentModel>> getDepartmentById(String departmentId);
}
