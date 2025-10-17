import 'package:dartz/dartz.dart';
import '../../../../core/constants/api_end_point.dart';
import '../../../../core/errors/server_failures.dart';
import '../models/sub_department_model.dart';
import 'sub_department_repo.dart';

class SubDepartmentImplement extends SubDepartmentRepo {
  @override
  Future<Either<Failures, List<SubDepartmentModel>>> getAllSubDepartments() async {
    try {
      final response = await dio.get(
        '${APIEndPoint.url}${APIEndPoint.subDepartments}',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] != null) {
          final List<dynamic> subDepartmentsJson = data['data'];
          final List<SubDepartmentModel> subDepartments = subDepartmentsJson
              .map((json) => SubDepartmentModel.fromJson(json))
              .toList();
          return Right(subDepartments);
        } else {
          return Left(ServerFailures(errMessage: data['message'] ?? 'Failed to fetch sub departments'));
        }
      } else {
        return Left(ServerFailures(errMessage: 'Failed to fetch sub departments'));
      }
    } catch (e) {
      return Left(returnDioException(e));
    }
  }

  @override
  Future<Either<Failures, List<SubDepartmentModel>>> getSubDepartmentsByDepartment(String departmentId) async {
    try {
      final response = await dio.get(
        '${APIEndPoint.url}${APIEndPoint.subDepartments}?department_id=$departmentId',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] != null) {
          final List<dynamic> subDepartmentsJson = data['data'];
          final List<SubDepartmentModel> subDepartments = subDepartmentsJson
              .map((json) => SubDepartmentModel.fromJson(json))
              .toList();
          return Right(subDepartments);
        } else {
          return Left(ServerFailures(errMessage: data['message'] ?? 'Failed to fetch sub departments'));
        }
      } else {
        return Left(ServerFailures(errMessage: 'Failed to fetch sub departments'));
      }
    } catch (e) {
      return Left(returnDioException(e));
    }
  }

  @override
  Future<Either<Failures, SubDepartmentModel>> getSubDepartmentById(String subDepartmentId) async {
    try {
      final response = await dio.get(
        '${APIEndPoint.url}${APIEndPoint.subDepartments}/$subDepartmentId',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] != null) {
          final SubDepartmentModel subDepartment = SubDepartmentModel.fromJson(data['data']);
          return Right(subDepartment);
        } else {
          return Left(ServerFailures(errMessage: data['message'] ?? 'Failed to fetch sub department'));
        }
      } else {
        return Left(ServerFailures(errMessage: 'Failed to fetch sub department'));
      }
    } catch (e) {
      return Left(returnDioException(e));
    }
  }
}
