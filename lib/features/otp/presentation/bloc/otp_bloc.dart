import 'package:bloc/bloc.dart';
import 'package:click_to_food/core/utils/global_function.dart';
import 'package:click_to_food/features/login/data/request/email_body.dart';
import 'package:click_to_food/features/otp/domain/otp_repo.dart';
import 'package:click_to_food/shared/common_widgets/common_toast.dart';
import 'package:click_to_food/shared/dialog/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/app_constant_config.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/pref_utils.dart';
import '../../data/request/otp_body.dart';
import 'otp_event.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(const OtpState()) {
    on<OTPOnChanged>(_onOTPChanged);
    on<OTPCheck>(_onOTPCheck);
    on<ResendOTP>(_onResendOTP);
  }

  void _onOTPChanged(OTPOnChanged event, Emitter<OtpState> emit) {
    final otp = event.otp;
    String? otpError;

    // Otp validation
    if (otp.isEmpty) {
      otpError = "OTP cannot be empty";
    } else if (otp.length < 5) {
      otpError = "Please Enter 6Digit OTP";
    }

    emit(state.copyWith(otp: otp, otpError: otpError));
    debugPrint("Updated Otp: ${state.otp}");
  }

  void _onOTPCheck(OTPCheck event, Emitter<OtpState> emit) async {
    debugPrint("Updated otp _onOTPCheck: ${state.otp}");

    if (state.otpError != null || state.otp.isEmpty || state.otp.length < 6) {
      CustomPopUp.showErrorDialog(context: event.context, msg: "Please enter a valid OTP");
      emit(state.copyWith(isFailure: true));
      return;
    }

    emit(state.copyWith(isSubmitting: true));
    hideKeyboard(event.context);
    try {
      var body = OtpBody(otp: state.otp, email: await PrefUtils.getEmail());
      final response = await OtpRepo().checkOtp(body);

      if ((response.message ?? "").contains("OTP has Matched")) {
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
        if (AppConstantConfig.isForgetPass) {
          AppConstantConfig.isForgetPass = false;
          event.context.push(RouterPath.setPasswordScreenPath);
        } else {
          event.context.push(RouterPath.registrationScreenPath);
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

  void _onResendOTP(ResendOTP event, Emitter<OtpState> emit) async {
    debugPrint("Updated otp _onResendOTP: ${state.otp}");

    emit(state.copyWith(isSubmittingResend: true));
    hideKeyboard(event.context);
    try {
      var body = EmailBody(email: await PrefUtils.getEmail());
      final response = await OtpRepo().requestOtp(body);

      if ((response.message ?? "").contains("OTP sent successfully")) {
        emit(state.copyWith(
          isSubmittingResend: false,
          isSuccess: true,
          otp: '', // Clear the OTP
          otpError: null, // Clear any OTP errors
        ));
        CommonToast.showSuccessToast(response.message ?? "OTP resent successfully, please check your email");
        emit(state.copyWith(isSubmittingResend: false, isSuccess: true));
      } else {
        CustomPopUp.showErrorDialog(context: event.context, msg: response.message ?? "An unexpected error occurred. Please try again.");
        emit(state.copyWith(isSubmittingResend: false, isSuccess: false, isFailure: true));
      }
    } catch (e) {
      CustomPopUp.showErrorDialog(context: event.context, msg: "An unexpected error occurred. Please try again.");
      emit(state.copyWith(isSubmittingResend: false, isFailure: true));
    }
  }

}
