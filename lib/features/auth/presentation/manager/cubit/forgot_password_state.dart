abstract class ForgotPasswordState {}

final class ForgotPasswordInitial extends ForgotPasswordState {
  final String phone;
  final String selectedDialCode;
  final bool hasAttemptedSubmit;

  ForgotPasswordInitial({
    this.phone = '',
    this.selectedDialCode = '+20',
    this.hasAttemptedSubmit = false,
  });

  ForgotPasswordInitial copyWith({
    String? phone,
    String? selectedDialCode,
    bool? hasAttemptedSubmit,
  }) {
    return ForgotPasswordInitial(
      phone: phone ?? this.phone,
      selectedDialCode: selectedDialCode ?? this.selectedDialCode,
      hasAttemptedSubmit: hasAttemptedSubmit ?? this.hasAttemptedSubmit,
    );
  }
}

final class ForgotPasswordLoading extends ForgotPasswordState {
  final String phone;
  final String selectedDialCode;
  final bool hasAttemptedSubmit;

  ForgotPasswordLoading({
    required this.phone,
    required this.selectedDialCode,
    required this.hasAttemptedSubmit,
  });
}

final class ForgotPasswordSuccess extends ForgotPasswordState {
  final String phone;
  final String selectedDialCode;
  final bool hasAttemptedSubmit;

  ForgotPasswordSuccess({
    required this.phone,
    required this.selectedDialCode,
    required this.hasAttemptedSubmit,
  });
}

final class ForgotPasswordError extends ForgotPasswordState {
  final String error;
  final String phone;
  final String selectedDialCode;
  final bool hasAttemptedSubmit;

  ForgotPasswordError({
    required this.error,
    required this.phone,
    required this.selectedDialCode,
    required this.hasAttemptedSubmit,
  });
}
