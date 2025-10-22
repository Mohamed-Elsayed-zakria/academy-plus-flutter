import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/server_failures.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/services/auth_service.dart';
import '../../../../../core/services/auth_manager.dart';
import '../../../data/models/register_model.dart';
import '../../../data/models/login_model.dart';
import '../../../data/repository/register_repo.dart';
import '../../../../universities/data/models/university_model.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._registerRepo) : super(RegisterInitial());
  final RegisterRepo _registerRepo;

  // Form controllers and key
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Future<void> close() {
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    return super.close();
  }

  // Update form fields
  void updateName(String name) {
    if (state is RegisterInitial) {
      final currentState = state as RegisterInitial;
      emit(currentState.copyWith(name: name));
    }
  }

  void updatePassword(String password) {
    if (state is RegisterInitial) {
      final currentState = state as RegisterInitial;
      emit(currentState.copyWith(password: password));
    }
  }

  void updateConfirmPassword(String confirmPassword) {
    if (state is RegisterInitial) {
      final currentState = state as RegisterInitial;
      emit(currentState.copyWith(confirmPassword: confirmPassword));
    }
  }

  void updatePhone(String phone) {
    if (state is RegisterInitial) {
      final currentState = state as RegisterInitial;
      emit(currentState.copyWith(phone: phone));
    }
  }

  // Validate and register
  void validateAndRegister() {
    if (formKey.currentState!.validate()) {
      // Update cubit with current form values
      updateName(nameController.text);
      updatePassword(passwordController.text);
      updateConfirmPassword(confirmPasswordController.text);
      updatePhone(phoneController.text);
      
      // Register user
      register();
    }
  }

  void updateDialCode(String dialCode) {
    if (state is RegisterInitial) {
      final currentState = state as RegisterInitial;
      emit(currentState.copyWith(selectedDialCode: dialCode));
    }
  }

  void updateSelectedUniversity(UniversityModel? university) {
    if (state is RegisterInitial) {
      final currentState = state as RegisterInitial;
      emit(currentState.copyWith(
        selectedUniversity: university,
        hasAttemptedSubmit: false,
      ));
    }
  }

  void setAttemptedSubmit(bool attempted) {
    if (state is RegisterInitial) {
      final currentState = state as RegisterInitial;
      emit(currentState.copyWith(hasAttemptedSubmit: attempted));
    }
  }

  // Validation methods
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.pleaseEnterFullName;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return AppLocalizations.passwordMustBeAtLeast6;
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.pleaseConfirmPassword;
    }
    if (value != password) {
      return AppLocalizations.passwordsDoNotMatch;
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.pleaseEnterPhone;
    }
    return null;
  }

  String? validateUniversity(UniversityModel? university, bool hasAttemptedSubmit) {
    if (hasAttemptedSubmit && university == null) {
      return 'Please select your university';
    }
    return null;
  }

  // Check if form is valid
  bool isFormValid() {
    if (state is RegisterInitial) {
      final currentState = state as RegisterInitial;
      return validateName(currentState.name) == null &&
          validatePassword(currentState.password) == null &&
          validateConfirmPassword(currentState.confirmPassword, currentState.password) == null &&
          validatePhone(currentState.phone) == null &&
          validateUniversity(currentState.selectedUniversity, currentState.hasAttemptedSubmit) == null;
    }
    return false;
  }

  Future<void> register() async {
    // Allow retry from RegisterError state
    if (state is! RegisterInitial && state is! RegisterError) return;
    
    RegisterInitial currentState;
    if (state is RegisterInitial) {
      currentState = state as RegisterInitial;
    } else {
      // If coming from RegisterError, create new initial state
      final errorState = state as RegisterError;
      currentState = RegisterInitial(
        name: errorState.name,
        password: errorState.password,
        confirmPassword: errorState.confirmPassword,
        phone: errorState.phone,
        selectedDialCode: errorState.selectedDialCode,
        selectedUniversity: errorState.selectedUniversity,
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
    emit(RegisterLoading(
      name: currentState.name,
      password: currentState.password,
      confirmPassword: currentState.confirmPassword,
      phone: currentState.phone,
      selectedDialCode: currentState.selectedDialCode,
      selectedUniversity: currentState.selectedUniversity!,
      hasAttemptedSubmit: true,
    ));

    // Prepare phone number with country code
    final fullPhoneNumber = '${currentState.selectedDialCode}${currentState.phone}';

    // Register user
    Either<Failures, LoginResponseModel> result = await _registerRepo.register(
      loginModel: RegisterModel(
        name: currentState.name,
        phone: fullPhoneNumber,
        password: currentState.password,
        universityId: currentState.selectedUniversity!.id,
      ),
    );

    result.fold(
      (failures) => emit(RegisterError(
        error: failures.errMessage,
        name: currentState.name,
        password: currentState.password,
        confirmPassword: currentState.confirmPassword,
        phone: currentState.phone,
        selectedDialCode: currentState.selectedDialCode,
        selectedUniversity: currentState.selectedUniversity!,
        hasAttemptedSubmit: true,
      )),
      (loginResponse) async {
        // Save login data to SharedPreferences
        await AuthService.saveLoginData(loginResponse);
        
        // Update AuthManager
        AuthManager.updateUserData(loginResponse);
        
        emit(RegisterSuccess(
          name: currentState.name,
          password: currentState.password,
          confirmPassword: currentState.confirmPassword,
          phone: currentState.phone,
          selectedDialCode: currentState.selectedDialCode,
          selectedUniversity: currentState.selectedUniversity!,
          hasAttemptedSubmit: true,
          loginResponse: loginResponse,
        ));
      },
    );
  }
}
