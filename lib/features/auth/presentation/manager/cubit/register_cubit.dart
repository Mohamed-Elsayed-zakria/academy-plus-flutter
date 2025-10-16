import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/server_failures.dart';
import '../../../data/models/register_model.dart';
import '../../../data/repository/register_repo.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._registerRepo) : super(RegisterInitial());
  final RegisterRepo _registerRepo;

  Future<void> register({required RegisterModel registerModel}) async {
    emit(RegisterLoading());
    Either<Failures, void> result = await _registerRepo.register(
      loginModel: registerModel,
    );
    result.fold(
      (failures) => emit(RegisterError(error: failures.errMessage)),
      (result) => emit(RegisterSuccess()),
    );
  }
}
