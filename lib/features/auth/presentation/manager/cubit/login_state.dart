import '../../../data/models/login_model.dart';

abstract class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final LoginResponseModel loginResponse;
  LoginSuccess({required this.loginResponse});
}

final class LoginError extends LoginState {
  final String error;
  LoginError({required this.error});
}
