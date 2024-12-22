import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object?> get props => [];
}

class OTPOnChanged extends OtpEvent {
  final String otp;

  const OTPOnChanged(this.otp);

  @override
  List<Object?> get props => [otp];
}

class OTPCheck extends OtpEvent {
  final BuildContext context;

  const OTPCheck(this.context);

  @override
  List<Object?> get props => [context];
}

class ResendOTP extends OtpEvent {
  final BuildContext context;

  const ResendOTP(this.context);

  @override
  List<Object?> get props => [context];
}
