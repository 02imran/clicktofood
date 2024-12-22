import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class PassEvent extends Equatable {
  const PassEvent();

  @override
  List<Object?> get props => [];
}

class PasswordChanged extends PassEvent {
  final String password;

  const PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class TogglePasswordVisibility extends PassEvent {}

class LoginSubmitted extends PassEvent {
  final BuildContext context;

  const LoginSubmitted(this.context);

  @override
  List<Object?> get props => [context];
}
