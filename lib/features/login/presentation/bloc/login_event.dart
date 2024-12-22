import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class EmailChanged extends LoginEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class UserCheckIfExists extends LoginEvent {
  final BuildContext context;

  const UserCheckIfExists(this.context);

  @override
  List<Object?> get props => [context];
}

class RequestOTPForNewUser extends LoginEvent {
  final BuildContext context;

  const RequestOTPForNewUser(this.context);

  @override
  List<Object?> get props => [context];
}