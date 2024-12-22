import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RegEvent extends Equatable {
  const RegEvent();

  @override
  List<Object?> get props => [];
}

class FullNameChanged extends RegEvent {
  final String name;

  const FullNameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class LoadEmail extends RegEvent {}

class EmailChanged extends RegEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class PhoneChanged extends RegEvent {
  final String phone;

  const PhoneChanged(this.phone);

  @override
  List<Object?> get props => [phone];
}

class PasswordChanged extends RegEvent {
  final String password;

  const PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class ConfirmPasswordChanged extends RegEvent {
  final String confirmPassword;

  const ConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object?> get props => [confirmPassword];
}

class TogglePasswordVisibility extends RegEvent {}

class UserRegister extends RegEvent {
  final BuildContext context;

  const UserRegister(this.context);

  @override
  List<Object?> get props => [context];
}