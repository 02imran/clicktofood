import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String email;
  final String? emailError;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const LoginState({
    this.email = '',
    this.emailError,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
  });

  LoginState copyWith({String? email, String? emailError, bool? isSubmitting, bool? isSuccess, bool? isFailure}) {
    return LoginState(
      email: email ?? this.email,
      emailError: emailError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  List<Object?> get props => [email, emailError, isSubmitting, isSuccess, isFailure];
}
