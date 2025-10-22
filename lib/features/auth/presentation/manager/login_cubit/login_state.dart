import '../../../data/models/login_model.dart';

abstract class LoginState {}

final class LoginInitial extends LoginState {
  final String phone;
  final String password;
  final String selectedDialCode;
  final bool hasAttemptedSubmit;

  LoginInitial({
    this.phone = '',
    this.password = '',
    this.selectedDialCode = '+20',
    this.hasAttemptedSubmit = false,
  });

  LoginInitial copyWith({
    String? phone,
    String? password,
    String? selectedDialCode,
    bool? hasAttemptedSubmit,
  }) {
    return LoginInitial(
      phone: phone ?? this.phone,
      password: password ?? this.password,
      selectedDialCode: selectedDialCode ?? this.selectedDialCode,
      hasAttemptedSubmit: hasAttemptedSubmit ?? this.hasAttemptedSubmit,
    );
  }
}

final class LoginLoading extends LoginState {
  final String phone;
  final String password;
  final String selectedDialCode;
  final bool hasAttemptedSubmit;

  LoginLoading({
    required this.phone,
    required this.password,
    required this.selectedDialCode,
    required this.hasAttemptedSubmit,
  });
}

final class LoginSuccess extends LoginState {
  final LoginResponseModel loginResponse;
  final String phone;
  final String password;
  final String selectedDialCode;
  final bool hasAttemptedSubmit;

  LoginSuccess({
    required this.loginResponse,
    required this.phone,
    required this.password,
    required this.selectedDialCode,
    required this.hasAttemptedSubmit,
  });
}

final class LoginError extends LoginState {
  final String error;
  final String phone;
  final String password;
  final String selectedDialCode;
  final bool hasAttemptedSubmit;

  LoginError({
    required this.error,
    required this.phone,
    required this.password,
    required this.selectedDialCode,
    required this.hasAttemptedSubmit,
  });
}
