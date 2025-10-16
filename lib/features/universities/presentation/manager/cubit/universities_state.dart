import '../../../data/models/university_model.dart';

abstract class UniversitiesState {}

final class UniversitiesInitial extends UniversitiesState {}

final class UniversitiesLoading extends UniversitiesState {}

final class UniversitiesSuccess extends UniversitiesState {
  final List<UniversityModel> universities;

  UniversitiesSuccess({required this.universities});
}

final class UniversitiesError extends UniversitiesState {
  final String error;

  UniversitiesError({required this.error});
}
