import 'package:equatable/equatable.dart';

class RegState extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;
  final String? nameError;
  final String? emailError;
  final String? phoneError;
  final String? passwordError;
  final String? confirmPasswordError;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool passwordVisibility;

  const RegState({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.password = '',
    this.confirmPassword = '',
    this.nameError,
    this.emailError,
    this.phoneError,
    this.passwordError,
    this.confirmPasswordError,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.passwordVisibility = false,
  });

  RegState copyWith({String? name,String? email,String? phone,String? password,String? confirmPassword,
    String? nameError, String? emailError, String? phoneError, String? passwordError, String? confirmPasswordError,
    bool? isSubmitting, bool? isSuccess, bool? isFailure, bool? passwordVisibility}) {
    return RegState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      nameError: nameError,
      emailError: emailError,
      phoneError: phoneError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      passwordVisibility: passwordVisibility ?? this.passwordVisibility,
    );
  }

  @override
  List<Object?> get props => [name, email, phone, password, confirmPassword, nameError, emailError, phoneError, passwordError, confirmPasswordError, emailError,
    isSubmitting, isSuccess, isFailure, passwordVisibility];
}
