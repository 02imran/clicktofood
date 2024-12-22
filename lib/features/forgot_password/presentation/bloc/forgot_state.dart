import 'package:equatable/equatable.dart';

class ForgotState extends Equatable {
  final String forgotEmail;
  final String? forgotEmailError;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const ForgotState({
    this.forgotEmail = '',
    this.forgotEmailError,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
  });

  ForgotState copyWith({String? forgotEmail, String? forgotEmailError, bool? isSubmitting, bool? isSuccess, bool? isFailure}) {
    return ForgotState(
      forgotEmail: forgotEmail ?? this.forgotEmail,
      forgotEmailError: forgotEmailError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  List<Object?> get props => [forgotEmail, forgotEmailError, isSubmitting, isSuccess, isFailure];
}
