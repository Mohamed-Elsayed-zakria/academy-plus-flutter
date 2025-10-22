import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/server_failures.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/services/auth_service.dart';
import '../../../../../core/services/auth_manager.dart';
import '../../../data/models/login_model.dart';
import '../../../data/repository/login_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginRepo) : super(LoginInitial());
  final LoginRepo _loginRepo;

  // Form controllers and key
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Future<void> close() {
    phoneController.dispose();
    passwordController.dispose();
    return super.close();
  }

  // Update form fields
  void updatePhone(String phone) {
    if (state is LoginInitial) {
      final currentState = state as LoginInitial;
      emit(currentState.copyWith(phone: phone));
    }
  }

  void updatePassword(String password) {
    if (state is LoginInitial) {
      final currentState = state as LoginInitial;
      emit(currentState.copyWith(password: password));
    }
  }

  // Validate and login
  void validateAndLogin() {
    if (formKey.currentState!.validate()) {
      // Update cubit with current form values
      updatePhone(phoneController.text);
      updatePassword(passwordController.text);
      
      // Login user
      login();
    }
  }

  void updateDialCode(String dialCode) {
    if (state is LoginInitial) {
      final currentState = state as LoginInitial;
      emit(currentState.copyWith(selectedDialCode: dialCode));
    }
  }

  void setAttemptedSubmit(bool attempted) {
    if (state is LoginInitial) {
      final currentState = state as LoginInitial;
      emit(currentState.copyWith(hasAttemptedSubmit: attempted));
    }
  }

  // Validation methods
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.pleaseEnterPhone;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.pleaseEnterPassword;
    }
    return null;
  }

  // Check if form is valid
  bool isFormValid() {
    if (state is LoginInitial) {
      final currentState = state as LoginInitial;
      return validatePhone(currentState.phone) == null &&
          validatePassword(currentState.password) == null;
    }
    return false;
  }

  Future<void> login() async {
    // Allow retry from LoginError state
    if (state is! LoginInitial && state is! LoginError) return;
    
    LoginInitial currentState;
    if (state is LoginInitial) {
      currentState = state as LoginInitial;
    } else {
      // If coming from LoginError, create new initial state
      final errorState = state as LoginError;
      currentState = LoginInitial(
        phone: errorState.phone,
        password: errorState.password,
        selectedDialCode: errorState.selectedDialCode,
        hasAttemptedSubmit: false,
      );
    }
    
    // Set attempted submit to true
    emit(currentState.copyWith(hasAttemptedSubmit: true));
    
    // Check if form is valid
    if (!isFormValid()) {
      return;
    }

    // Emit loading state
    emit(LoginLoading(
      phone: currentState.phone,
      password: currentState.password,
      selectedDialCode: currentState.selectedDialCode,
      hasAttemptedSubmit: true,
    ));

    // Prepare phone number with country code
    final fullPhoneNumber = '${currentState.selectedDialCode}${currentState.phone}';

    // Login user
    Either<Failures, LoginResponseModel> result = await _loginRepo.login(
      LoginModel(phoneNumber: fullPhoneNumber, password: currentState.password),
    );

    result.fold(
      (failures) => emit(LoginError(
        error: failures.errMessage,
        phone: currentState.phone,
        password: currentState.password,
        selectedDialCode: currentState.selectedDialCode,
        hasAttemptedSubmit: true,
      )),
      (loginResponse) async {
        // Save login data to SharedPreferences
        await AuthService.saveLoginData(loginResponse);
        
        // Update AuthManager
        AuthManager.updateUserData(loginResponse);
        
        emit(LoginSuccess(
          loginResponse: loginResponse,
          phone: currentState.phone,
          password: currentState.password,
          selectedDialCode: currentState.selectedDialCode,
          hasAttemptedSubmit: true,
        ));
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
