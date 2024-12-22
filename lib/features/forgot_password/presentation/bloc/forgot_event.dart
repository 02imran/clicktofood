import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ForgotEvent extends Equatable {
  const ForgotEvent();

  @override
  List<Object?> get props => [];
}

class ForgotEmailChanged extends ForgotEvent {
  final String forgotEmail;

  const ForgotEmailChanged(this.forgotEmail);

  @override
  List<Object?> get props => [forgotEmail];
}

class ForgotPasswordOtpRequest extends ForgotEvent {
  final BuildContext context;

  const ForgotPasswordOtpRequest(this.context);

  @override
  List<Object?> get props => [context];
}
