import 'package:equatable/equatable.dart';

class DashState extends Equatable {
  final String password;
  final String? passError;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool passwordVisibility;

  const DashState({
    this.password = '',
    this.passError,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.passwordVisibility = false,
  });

  DashState copyWith({String? email, String? forgotEmail, String? password, String? emailError, String? passError, bool? isSubmitting, bool? isSuccess, bool? isFailure, bool? passwordVisibility}) {
    return DashState(
      password: password ?? this.password,
      passError: passError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      passwordVisibility: passwordVisibility ?? this.passwordVisibility,
    );
  }

  @override
  List<Object?> get props => [password, passError, isSubmitting, isSuccess, isFailure, passwordVisibility];
}
