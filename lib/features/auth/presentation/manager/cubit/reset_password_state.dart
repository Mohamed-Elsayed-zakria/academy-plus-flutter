abstract class ResetPasswordState {}

final class ResetPasswordInitial extends ResetPasswordState {
  final String password;
  final String confirmPassword;
  final bool hasAttemptedSubmit;

  ResetPasswordInitial({
    this.password = '',
    this.confirmPassword = '',
    this.hasAttemptedSubmit = false,
  });

  ResetPasswordInitial copyWith({
    String? password,
    String? confirmPassword,
    bool? hasAttemptedSubmit,
  }) {
    return ResetPasswordInitial(
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      hasAttemptedSubmit: hasAttemptedSubmit ?? this.hasAttemptedSubmit,
    );
  }
}

final class ResetPasswordLoading extends ResetPasswordState {
  final String password;
  final String confirmPassword;
  final bool hasAttemptedSubmit;

  ResetPasswordLoading({
    required this.password,
    required this.confirmPassword,
    required this.hasAttemptedSubmit,
  });
}

final class ResetPasswordSuccess extends ResetPasswordState {
  final String password;
  final String confirmPassword;
  final bool hasAttemptedSubmit;

  ResetPasswordSuccess({
    required this.password,
    required this.confirmPassword,
    required this.hasAttemptedSubmit,
  });
}

final class ResetPasswordError extends ResetPasswordState {
  final String error;
  final String password;
  final String confirmPassword;
  final bool hasAttemptedSubmit;

  ResetPasswordError({
    required this.error,
    required this.password,
    required this.confirmPassword,
    required this.hasAttemptedSubmit,
  });
}
