import '../../../../core/constants/api_end_point.dart';
import '../../../../core/errors/server_failures.dart';
import '../models/university_model.dart';
import 'package:dartz/dartz.dart';
import 'universities_repo.dart';

class UniversitiesImplement extends UniversitiesRepo {
  @override
  Future<Either<Failures, List<UniversityModel>>> getUniversities() async {
    try {
      const url = "${APIEndPoint.url}${APIEndPoint.universities}";
      final response = await dio.get(url);
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        final universities = data
            .map((json) => UniversityModel.fromJson(json))
            .toList();
        return right(universities);
      } else {
        return left(ServerFailures(errMessage: 'Failed to fetch universities'));
      }
    } catch (e) {
      return left(returnDioException(e));
    }
  }
}
