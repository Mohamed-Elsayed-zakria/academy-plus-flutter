import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/server_failures.dart';
import '../../../data/models/university_model.dart';
import '../../../data/repository/universities_repo.dart';
import 'universities_state.dart';

class UniversitiesCubit extends Cubit<UniversitiesState> {
  UniversitiesCubit(this._universitiesRepo) : super(UniversitiesInitial());
  final UniversitiesRepo _universitiesRepo;

  Future<void> getUniversities() async {
    emit(UniversitiesLoading());
    Either<Failures, List<UniversityModel>> result = await _universitiesRepo.getUniversities();
    result.fold(
      (failures) => emit(UniversitiesError(error: failures.errMessage)),
      (universities) => emit(UniversitiesSuccess(universities: universities)),
    );
  }
}
