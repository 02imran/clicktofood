import 'package:bloc/bloc.dart';
import 'package:click_to_food/core/router/app_routes.dart';
import 'package:click_to_food/core/utils/global_function.dart';
import 'package:click_to_food/core/utils/pref_utils.dart';
import 'package:click_to_food/features/login/data/request/email_body.dart';
import 'package:click_to_food/shared/dialog/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/request/LoginBody.dart';
import '../../domain/login_repo.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<UserCheckIfExists>(_onUserCheckIfExists);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    final email = event.email;
    String? emailError;

    // Simple email validation
    if (email.isEmpty) {
      emailError = "Email cannot be empty";
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      emailError = "Invalid email format";
    }

    emit(state.copyWith(email: email, emailError: emailError));
    debugPrint("Updated email: ${state.email}");
  }

  void _onUserCheckIfExists(UserCheckIfExists event, Emitter<LoginState> emit) async {
    debugPrint("Updated email _onUserCheckIfExists: ${state.email}");

    if (state.emailError != null || state.email.isEmpty) {
      CustomPopUp.showErrorDialog(context: event.context, msg: "Please enter a valid email address");
      emit(state.copyWith(isFailure: true));
      return;
    }

    emit(state.copyWith(isSubmitting: true));
    hideKeyboard(event.context);
    try {
      var body = EmailBody(email: state.email);
      final response = await LoginRepo().checkUserAvailability(body);

      if (response.status == 200) {
        PrefUtils.storeEmail(email: state.email);
        if (response.message == "User Not Found") {
          emit(state.copyWith(isSubmitting: false, isFailure: true));
          CustomPopUp.showUserNotFoundDialog(context: event.context, msg: "Please enter a valid email address", onCreateAccountPressed: () {
            event.context.pop();
            _callRequestOTPForNewUser(event.context, emit);
          });
        } else {
          emit(state.copyWith(isSubmitting: false, isSuccess: true));
          event.context.push(RouterPath.passwordScreenPath);
        }
      } else {
        CustomPopUp.showErrorDialog(context: event.context, msg: response.message ?? "An unexpected error occurred. Please try again.");
        emit(state.copyWith(isSubmitting: false, isSuccess: false, isFailure: true));
      }
    } catch (e) {
      CustomPopUp.showErrorDialog(context: event.context, msg: "An unexpected error occurred. Please try again.");
      emit(state.copyWith(isSubmitting: false, isFailure: true));
    }
  }

  void _callRequestOTPForNewUser(BuildContext context, Emitter<LoginState> emit) async {
    try {
      var body = EmailBody(email: state.email);
      final response = await LoginRepo().requestOtp(body);

      if ((response.message ?? "").contains("OTP sent successfully")) {
        context.push(RouterPath.otpScreenPath);
      } else {
        CustomPopUp.showErrorDialog(context: context, msg: response.message ?? "Failed to send OTP. Please try again.");
      }
    } catch (e) {
      CustomPopUp.showErrorDialog(context: context, msg: "An unexpected error occurred while requesting OTP. Please try again.");
    }
  }

}
