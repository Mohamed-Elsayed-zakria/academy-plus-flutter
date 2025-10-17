import 'package:dartz/dartz.dart';
import '../../../../core/constants/api_end_point.dart';
import '../../../../core/errors/server_failures.dart';
import '../models/department_model.dart';
import 'department_repo.dart';

class DepartmentImplement extends DepartmentRepo {
  @override
  Future<Either<Failures, List<DepartmentModel>>> getAllDepartments() async {
    try {
      final response = await dio.get(
        '${APIEndPoint.url}${APIEndPoint.departments}?withObjects=false',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] != null) {
          final List<dynamic> departmentsJson = data['data'];
          final List<DepartmentModel> departments = departmentsJson
              .map((json) => DepartmentModel.fromJson(json))
              .toList();
          return Right(departments);
        } else {
          return Left(ServerFailures(errMessage: data['message'] ?? 'Failed to fetch departments'));
        }
      } else {
        return Left(ServerFailures(errMessage: 'Failed to fetch departments'));
      }
    } catch (e) {
      return Left(returnDioException(e));
    }
  }

  @override
  Future<Either<Failures, List<DepartmentModel>>> getDepartmentsByUniversity(String universityId) async {
    try {
      final response = await dio.get(
        '${APIEndPoint.url}${APIEndPoint.departments}?university_id=$universityId&withObjects=false',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] != null) {
          final List<dynamic> departmentsJson = data['data'];
          final List<DepartmentModel> departments = departmentsJson
              .map((json) => DepartmentModel.fromJson(json))
              .toList();
          return Right(departments);
        } else {
          return Left(ServerFailures(errMessage: data['message'] ?? 'Failed to fetch departments'));
        }
      } else {
        return Left(ServerFailures(errMessage: 'Failed to fetch departments'));
      }
    } catch (e) {
      return Left(returnDioException(e));
    }
  }

  @override
  Future<Either<Failures, DepartmentModel>> getDepartmentById(String departmentId) async {
    try {
      final response = await dio.get(
        '${APIEndPoint.url}${APIEndPoint.departments}/$departmentId',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] != null) {
          final DepartmentModel department = DepartmentModel.fromJson(data['data']);
          return Right(department);
        } else {
          return Left(ServerFailures(errMessage: data['message'] ?? 'Failed to fetch department'));
        }
      } else {
        return Left(ServerFailures(errMessage: 'Failed to fetch department'));
      }
    } catch (e) {
      return Left(returnDioException(e));
    }
  }
}
