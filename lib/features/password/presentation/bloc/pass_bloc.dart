import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:click_to_food/core/router/app_routes.dart';
import 'package:click_to_food/core/utils/global_function.dart';
import 'package:click_to_food/core/utils/pref_utils.dart';
import 'package:click_to_food/features/login/data/request/email_body.dart';
import 'package:click_to_food/shared/dialog/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/string_config.dart';
import '../../../login/data/request/LoginBody.dart';
import '../../domain/pass_repo.dart';
import 'pass_event.dart';
import 'pass_state.dart';

class PassBloc extends Bloc<PassEvent, PassState> {
  PassBloc() : super(const PassState()) {
    on<PasswordChanged>(_onPasswordChanged);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<PassState> emit) {
    final password = event.password;
    String? passError;

    // Password validation
    if (password.isEmpty) {
      passError = "Password cannot be empty";
    } else if (password.length < 8) {
      passError = "Passwords must be at least 8 characters.";
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      passError = "Passwords must have at least one non-alphanumeric character.";
    } else if (!RegExp(r'[a-z]').hasMatch(password)) {
      passError = "Passwords must have at least one lowercase ('a'-'z').";
    } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
      passError = "Passwords must have at least one uppercase ('A'-'Z').";
    }

    emit(state.copyWith(password: password, passError: passError));
  }

  void _onTogglePasswordVisibility(TogglePasswordVisibility event, Emitter<PassState> emit) {
    emit(state.copyWith(passwordVisibility: !state.passwordVisibility));
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<PassState> emit) async {
    debugPrint("Updated email _onLoginSubmitted: ${await PrefUtils.getEmail()}");

    if (state.passError != null || state.password.isEmpty) {
      CustomPopUp.showErrorDialog(context: event.context, msg: "Please enter a valid password");
      emit(state.copyWith(isFailure: true));
      return;
    }

    emit(state.copyWith(isSubmitting: true));
    hideKeyboard(event.context);
    try {
      var body = LoginBody(userName: await PrefUtils.getEmail(), password: state.password);
      final response = await PassRepo().loginUser(body);

      if (response.isAuthenticated ?? false) {
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
        CustomPopUp.showSuccessDialog(context: event.context, msg: response.message ?? "LoginSuccess", btnText: "Continue to Dashboard", onBtnPress: () {
          event.context.pop();
          event.context.pushReplacement(RouterPath.dashboardScreenPath);

          decodeJwtToken(response.tokenString ?? "");
          PrefUtils.storeUserID(response.id ?? "");
          PrefUtils.storeToken(response.tokenString ?? "");
          PrefUtils.storeRefreshToken(response.refreshToken ?? "");
          PrefUtils.storeEmail(email: response.userName ?? "");
          PrefUtils.storePassword(state.password);
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

  void decodeJwtToken(String token) {
    try {
      // Split the token into its parts
      final parts = token.split('.');
      if (parts.length != 3) {
        throw Exception('Invalid JWT structure');
      }

      // Decode the payload (2nd part of the token)
      final payload = parts[1];
      final normalized = base64Url.normalize(payload); // Ensure correct Base64 padding
      final decodedBytes = base64Url.decode(normalized);
      final decodedString = utf8.decode(decodedBytes);

      // Parse the JSON string to a Dart Map
      final payloadMap = json.decode(decodedString) as Map<String, dynamic>;

      print("Decoded Payload:");
      print(payloadMap);

      // Access specific claims
      final uniqueName = payloadMap['unique_name'];
      final exp = payloadMap['exp'];
      final expirationDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      PrefUtils.storeTokenExpDateTime("$expirationDate");

      print("Unique Name: $uniqueName");
      print("Expires At: $expirationDate");
    } catch (e) {
      print("Error decoding JWT: $e");
    }
  }

}
