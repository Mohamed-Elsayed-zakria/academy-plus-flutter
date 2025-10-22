import '../../../../universities/data/models/university_model.dart';
import '../../../data/models/login_model.dart';

abstract class RegisterState {}

final class RegisterInitial extends RegisterState {
  final String name;
  final String password;
  final String confirmPassword;
  final String phone;
  final String selectedDialCode;
  final UniversityModel? selectedUniversity;
  final bool hasAttemptedSubmit;

  RegisterInitial({
    this.name = '',
    this.password = '',
    this.confirmPassword = '',
    this.phone = '',
    this.selectedDialCode = '+20',
    this.selectedUniversity,
    this.hasAttemptedSubmit = false,
  });

  RegisterInitial copyWith({
    String? name,
    String? password,
    String? confirmPassword,
    String? phone,
    String? selectedDialCode,
    UniversityModel? selectedUniversity,
    bool? hasAttemptedSubmit,
  }) {
    return RegisterInitial(
      name: name ?? this.name,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      phone: phone ?? this.phone,
      selectedDialCode: selectedDialCode ?? this.selectedDialCode,
      selectedUniversity: selectedUniversity ?? this.selectedUniversity,
      hasAttemptedSubmit: hasAttemptedSubmit ?? this.hasAttemptedSubmit,
    );
  }
}

final class RegisterLoading extends RegisterState {
  final String name;
  final String password;
  final String confirmPassword;
  final String phone;
  final String selectedDialCode;
  final UniversityModel? selectedUniversity;
  final bool hasAttemptedSubmit;

  RegisterLoading({
    required this.name,
    required this.password,
    required this.confirmPassword,
    required this.phone,
    required this.selectedDialCode,
    required this.selectedUniversity,
    required this.hasAttemptedSubmit,
  });
}

final class RegisterSuccess extends RegisterState {
  final String name;
  final String password;
  final String confirmPassword;
  final String phone;
  final String selectedDialCode;
  final UniversityModel? selectedUniversity;
  final bool hasAttemptedSubmit;
  final LoginResponseModel? loginResponse;

  RegisterSuccess({
    required this.name,
    required this.password,
    required this.confirmPassword,
    required this.phone,
    required this.selectedDialCode,
    required this.selectedUniversity,
    required this.hasAttemptedSubmit,
    this.loginResponse,
  });
}

final class RegisterError extends RegisterState {
  final String error;
  final String name;
  final String password;
  final String confirmPassword;
  final String phone;
  final String selectedDialCode;
  final UniversityModel? selectedUniversity;
  final bool hasAttemptedSubmit;

  RegisterError({
    required this.error,
    required this.name,
    required this.password,
    required this.confirmPassword,
    required this.phone,
    required this.selectedDialCode,
    required this.selectedUniversity,
    required this.hasAttemptedSubmit,
  });
}