import 'package:bloc/bloc.dart';
import 'package:click_to_food/core/config/string_config.dart';
import 'package:click_to_food/core/utils/global_function.dart';
import 'package:click_to_food/features/login/data/request/LoginBody.dart';
import 'package:click_to_food/features/login/data/request/email_body.dart';
import 'package:click_to_food/features/password/data/LoginResponse.dart';
import 'package:click_to_food/shared/dialog/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/pref_utils.dart';
import '../../domain/set_pass_repo.dart';
import 'set_pass_event.dart';
import 'set_pass_state.dart';

class SetPassBloc extends Bloc<SetPassEvent, SetPassState> {
  SetPassBloc() : super(const SetPassState()) {
    on<PassChanged>(_onPassChanged);
    on<ConfirmPassChanged>(_onPassConfirmChanged);
    on<SetNewPass>(_onForgotPasswordOtpRequest);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
  }

  void _onPassChanged(PassChanged event, Emitter<SetPassState> emit) {
    final password = event.pass;
    String? passwordError;

    // Simple password validation
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

    emit(state.copyWith(pass: password, passError: passwordError));
    debugPrint("Updated pass: ${state.pass}");
    debugPrint("Updated confirmPassError: ${state.passError}");
  }

  void _onPassConfirmChanged(ConfirmPassChanged event, Emitter<SetPassState> emit) {
    final confirmPass = event.confirmPass;
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
    } else if (confirmPass != state.pass) {
      confirmPasswordError = "Confirm Password does not match with password";
    }

    emit(state.copyWith(confirmPass: confirmPass, confirmPassError: confirmPasswordError));
    debugPrint("Updated pass: ${state.pass}");
    debugPrint("Updated confirmPass: ${state.confirmPass}");
    debugPrint("Updated confirmPassError: ${state.confirmPassError}");
  }

  void _onTogglePasswordVisibility(TogglePasswordVisibility event, Emitter<SetPassState> emit) {
    emit(state.copyWith(passwordVisibility: !state.passwordVisibility));
  }

  void _onForgotPasswordOtpRequest(SetNewPass event, Emitter<SetPassState> emit) async {
    debugPrint("Updated email _onForgotPasswordOtpRequest: ${state.pass}");

    if (state.passError != null || state.pass.isEmpty) {
      CustomPopUp.showErrorDialog(context: event.context, msg: "Please enter a valid password");
      emit(state.copyWith(isFailure: true));
      return;
    }
    if (state.confirmPassError != null || state.confirmPass.isEmpty) {
      CustomPopUp.showErrorDialog(context: event.context, msg: "Please enter a valid confirm password");
      emit(state.copyWith(isFailure: true));
      return;
    }
    if (state.pass != state.confirmPass) {
      CustomPopUp.showErrorDialog(context: event.context, msg: "Password does not match");
      emit(state.copyWith(isFailure: true));
      return;
    }

    emit(state.copyWith(isSubmitting: true));
    hideKeyboard(event.context);
    try {
      var body = LoginBody(email: await PrefUtils.getEmail(), password: state.pass);
      final response = await SetPassRepo().setNewPass(body);

      if (response.succeeded ?? false) {
        PrefUtils.storeEmail(email: state.pass);
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
        CustomPopUp.showSuccessDialog(context: event.context, msg: response.message ?? "Password set successful", btnText: StringConfig.logIn, onBtnPress: () {
          event.context.pop();
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
