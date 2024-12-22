import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SetPassEvent extends Equatable {
  const SetPassEvent();

  @override
  List<Object?> get props => [];
}

class PassChanged extends SetPassEvent {
  final String pass;

  const PassChanged(this.pass);

  @override
  List<Object?> get props => [pass];
}

class ConfirmPassChanged extends SetPassEvent {
  final String confirmPass;

  const ConfirmPassChanged(this.confirmPass);

  @override
  List<Object?> get props => [confirmPass];
}

class TogglePasswordVisibility extends SetPassEvent {}

class SetNewPass extends SetPassEvent {
  final BuildContext context;

  const SetNewPass(this.context);

  @override
  List<Object?> get props => [context];
}
