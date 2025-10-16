import '../../../../core/errors/server_failures.dart';
import '../../../../core/services/base_service.dart';
import 'package:dartz/dartz.dart';
import '../models/university_model.dart';

abstract class UniversitiesRepo extends BaseServices {
  Future<Either<Failures, List<UniversityModel>>> getUniversities();
}
