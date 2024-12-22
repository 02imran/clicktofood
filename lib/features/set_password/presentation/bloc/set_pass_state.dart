import 'package:equatable/equatable.dart';

class SetPassState extends Equatable {
  final String pass;
  final String confirmPass;
  final String? passError;
  final String? confirmPassError;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool passwordVisibility;

  const SetPassState({
    this.pass = '',
    this.confirmPass = '',
    this.passError,
    this.confirmPassError,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.passwordVisibility = false,
  });

  SetPassState copyWith({String? pass, String? confirmPass, String? passError, String? confirmPassError, bool? isSubmitting, bool? isSuccess, bool? isFailure, bool? passwordVisibility}) {
    return SetPassState(
      pass: pass ?? this.pass,
      confirmPass: confirmPass ?? this.confirmPass,
      confirmPassError: confirmPassError,
      passError: passError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      passwordVisibility: passwordVisibility ?? this.passwordVisibility,
    );
  }

  @override
  List<Object?> get props => [pass, confirmPass, confirmPassError, passError, isSubmitting, isSuccess, isFailure, passwordVisibility];
}
