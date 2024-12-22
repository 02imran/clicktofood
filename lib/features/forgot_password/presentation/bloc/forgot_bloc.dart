import 'package:bloc/bloc.dart';
import 'package:click_to_food/core/config/app_constant_config.dart';
import 'package:click_to_food/core/utils/global_function.dart';
import 'package:click_to_food/features/login/data/request/email_body.dart';
import 'package:click_to_food/shared/dialog/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/pref_utils.dart';
import '../../domain/forgot_pass_repo.dart';
import 'forgot_event.dart';
import 'forgot_state.dart';

class ForgotBloc extends Bloc<ForgotEvent, ForgotState> {
  ForgotBloc() : super(const ForgotState()) {
    on<ForgotEmailChanged>(_onForgotEmailChanged);
    on<ForgotPasswordOtpRequest>(_onForgotPasswordOtpRequest);
  }

  void _onForgotEmailChanged(ForgotEmailChanged event, Emitter<ForgotState> emit) {
    final forgotEmail = event.forgotEmail;
    String? forgotEmailError;

    // Simple email validation for forgot password
    if (forgotEmail.isEmpty) {
      forgotEmailError = "Email cannot be empty";
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(forgotEmail)) {
      forgotEmailError = "Invalid email format";
    }





    emit(state.copyWith(forgotEmail: forgotEmail, forgotEmailError: forgotEmailError));
    debugPrint("Updated email: ${state.forgotEmail}");
  }

  void _onForgotPasswordOtpRequest(ForgotPasswordOtpRequest event, Emitter<ForgotState> emit) async {
    debugPrint("Updated email _onForgotPasswordOtpRequest: ${state.forgotEmail}");

    if (state.forgotEmailError != null || state.forgotEmail.isEmpty) {
      CustomPopUp.showErrorDialog(context: event.context, msg: "Please enter a valid email");
      emit(state.copyWith(isFailure: true));
      return;
    }

    emit(state.copyWith(isSubmitting: true));
    hideKeyboard(event.context);
    try {
      var body = EmailBody(email: state.forgotEmail);
      final response = await ForgotPassRepo().forgotOtpRequest(body);

      if ((response.message ?? "").contains("OTP sent successfully")) {
        PrefUtils.storeEmail(email: state.forgotEmail);
        AppConstantConfig.isForgetPass = true;
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
        event.context.push(RouterPath.otpScreenPath);
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
