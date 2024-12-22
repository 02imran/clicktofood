import 'package:bloc/bloc.dart';
import 'package:click_to_food/core/config/string_config.dart';
import 'package:click_to_food/core/utils/pref_utils.dart';
import 'package:click_to_food/shared/dialog/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/global_function.dart';
import '../../data/request/RegisterBody.dart';
import '../../domain/reg_repo.dart';
import 'reg_event.dart';
import 'reg_state.dart';

class RegBloc extends Bloc<RegEvent, RegState> {
  RegBloc() : super(const RegState()) {
    on<FullNameChanged>(_onFullNameChanged);
    on<LoadEmail>(_onLoadEmail);
    on<EmailChanged>(_onEmailChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<UserRegister>(_onUserRegister);
  }

  String? nameErrorCheck;
  String? emailErrorCheck;
  String? phoneErrorCheck;
  String? passwordErrorCheck;
  String? confirmPasswordErrorCheck;

  void _onFullNameChanged(FullNameChanged event, Emitter<RegState> emit) {
    final name = event.name;
    String? nameError;

    // name validation
    if (name.isEmpty) {
      nameError = "Full name cannot be empty";
    } else if (!RegExp(r'^\S+\s+\S+').hasMatch(name)) {
      nameError = "Full name must contain at least two words";
    }

    nameErrorCheck = nameError;
    emit(state.copyWith(name: name, nameError: nameError));
    debugPrint("Updated name: ${state.name}");
  }

  Future<void> _onLoadEmail(LoadEmail event, Emitter<RegState> emit) async {
    try {
      final email = await PrefUtils.getEmail();
      if (email.isNotEmpty) {
        emit(state.copyWith(email: email));
        debugPrint("Loaded email: $email");
      }
    } catch (e) {
      debugPrint("Error loading email: $e");
    }
  }

  void _onEmailChanged(EmailChanged event, Emitter<RegState> emit) {
    final email = event.email;
    String? emailError;

    // Simple email validation
    if (email.isEmpty) {
      emailError = "Email cannot be empty";
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      emailError = "Invalid email format";
    }

    emailErrorCheck = emailError;
    emit(state.copyWith(email: email, emailError: emailError));
    debugPrint("Updated email: ${state.email}");
  }

  void _onPhoneChanged(PhoneChanged event, Emitter<RegState> emit) {
    final phone = event.phone;
    String? phoneError;

    //Phone validation
    if (phone.isEmpty) {
      phoneError = "Phone number cannot be empty";
    } else if (phone.length < 10) {
      phoneError = "Phone number must be 10digits";
    }

    phoneErrorCheck = phoneError;
    emit(state.copyWith(phone: phone, phoneError: phoneError));
    debugPrint("Updated phone: ${state.phone}");
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<RegState> emit) {
    final password = event.password;
    String? passwordError;

    // Password validation
    if (password.isEmpty) {
      passwordError = "Password cannot be empty";
    } else if (password.length < 8) {
      passwordError = "Passwords must be at least 8 characters.";
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      passwordError = "Passwords must have at least one non-alphanumeric character.";
    } else if (!RegExp(r'[a-z]').hasMatch(password)) {
      passwordError = "Passwords must have at least one lowercase ('a'-'z').";
    } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
      passwordError = "Passwords must have at least one uppercase ('A'-'Z').";
    }

    emit(state.copyWith(password: password, passwordError: passwordError));
    debugPrint("Updated password: ${state.password}");
  }


  void _onConfirmPasswordChanged(ConfirmPasswordChanged event, Emitter<RegState> emit) {
    final confirmPass = event.confirmPassword;
    String? confirmPasswordError;

    //confirm password validation
    if (confirmPass.isEmpty) {
      confirmPasswordError = "Confirm Password cannot be empty";
    } else if (confirmPass.length < 8) {
      confirmPasswordError = "Confirm Passwords must be at least 8 characters.";
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(confirmPass)) {
      confirmPasswordError = "Confirm Passwords must have at least one non-alphanumeric character.";
    } else if (!RegExp(r'[a-z]').hasMatch(confirmPass)) {
      confirmPasswordError = "Confirm Passwords must have at least one lowercase ('a'-'z').";
    } else if (!RegExp(r'[A-Z]').hasMatch(confirmPass)) {
      confirmPasswordError = "Confirm Passwords must have at least one uppercase ('A'-'Z').";
    } else if (confirmPass != state.password) {
      confirmPasswordError = "Confirm Password does not match with password";
    }

    confirmPasswordErrorCheck = confirmPasswordError;
    emit(state.copyWith(confirmPassword: confirmPass, confirmPasswordError: confirmPasswordError));
    debugPrint("Updated pass: ${state.password}");
    debugPrint("Updated confirmPass: ${state.confirmPassword}");
    debugPrint("Updated confirmPassError: ${state.confirmPasswordError}");
  }

  void _onTogglePasswordVisibility(TogglePasswordVisibility event, Emitter<RegState> emit) {
    emit(state.copyWith(passwordVisibility: !state.passwordVisibility));
  }

  void _onUserRegister(UserRegister event, Emitter<RegState> emit) async {
    debugPrint("Updated name: ${state.name}");
    debugPrint("Updated nameError: $nameErrorCheck");
    debugPrint("Updated email: ${state.email}");
    debugPrint("Updated emailError: $emailErrorCheck");
    debugPrint("Updated phone: ${state.phone}");
    debugPrint("Updated phoneError: $phoneErrorCheck");
    debugPrint("Updated password: ${state.password}");
    debugPrint("Updated passwordError: $passwordErrorCheck");
    debugPrint("Updated confirmPassword: ${state.confirmPassword}");
    debugPrint("Updated confirmPasswordError: $confirmPasswordErrorCheck");
    debugPrint("------------------------------------------------------------------");

    if (nameErrorCheck != null || state.name.isEmpty) {
      CustomPopUp.showErrorDialog(context: event.context, msg: "Please enter a valid full name");
      emit(state.copyWith(isFailure: true));
      return;
    } else if (emailErrorCheck != null || state.email.isEmpty) {
      CustomPopUp.showErrorDialog(context: event.context, msg: "Please enter a valid email address");
      emit(state.copyWith(isFailure: true));
      return;
    } else if (phoneErrorCheck != null || state.phone.isEmpty) {
      CustomPopUp.showErrorDialog(context: event.context, msg: "Please enter a valid phone number");
      emit(state.copyWith(isFailure: true));
      return;
    } else if (passwordErrorCheck != null || state.password.isEmpty) {
      CustomPopUp.showErrorDialog(context: event.context, msg: "Please enter a valid password");
      emit(state.copyWith(isFailure: true));
      return;
    } else if (confirmPasswordErrorCheck != null || state.confirmPassword.isEmpty) {
      CustomPopUp.showErrorDialog(context: event.context, msg: "Please enter a valid confirm password");
      emit(state.copyWith(isFailure: true));
      return;
    }

    emit(state.copyWith(isSubmitting: true));
    hideKeyboard(event.context);
    try {
      var body = RegisterBody(userName: state.name, email: state.email, mobile: state.phone, password: state.password);
      final response = await RegRepo().registerUser(body);

      if (response.status == 200) {
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
        CustomPopUp.showSuccessDialog(context: event.context, msg: response.message ?? "Registration Success", btnText: StringConfig.logIn, onBtnPress: () {
          GoRouter.of(event.context).replace(RouterPath.welcomeScreenPath);
        });
      } else {
        CustomPopUp.showErrorDialog(context: event.context, msg: response.message ?? "An unexpected error occurred. Please try again.");
        emit(state.copyWith(isSubmitting: false, isSuccess: false, isFailure: true));
      }
    } catch (e) {
      CustomPopUp.showErrorDialog(context: event.context, msg: "An unexpected error occurred. Please try again.");
      emit(state.copyWith(isSubmitting: false, isFailure: true));
    }
  }

}
