import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/server_failures.dart';
import '../../../../../core/services/auth_service.dart';
import '../../../../../core/services/auth_manager.dart';
import '../../../data/models/login_model.dart';
import '../../../data/repository/login_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginRepo) : super(LoginInitial());
  final LoginRepo _loginRepo;

  Future<void> login(String phoneNumber, String password) async {
    emit(LoginLoading());
    Either<Failures, LoginResponseModel> result = await _loginRepo.login(
      LoginModel(phoneNumber: phoneNumber, password: password),
    );
    result.fold(
      (failures) => emit(LoginError(error: failures.errMessage)),
      (loginResponse) async {
        // Save login data to SharedPreferences
        await AuthService.saveLoginData(loginResponse);
        
        // Update AuthManager
        AuthManager.updateUserData(loginResponse);
        
        emit(LoginSuccess(loginResponse: loginResponse));
      },
    );
  }

  Future<void> logout() async {
    // Clear saved data
    await AuthService.logout();
    
    // Clear AuthManager
    AuthManager.clearUserData();
    
    emit(LoginInitial());
  }
}
