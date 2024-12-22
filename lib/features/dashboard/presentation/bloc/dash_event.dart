import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class DashEvent extends Equatable {
  const DashEvent();

  @override
  List<Object?> get props => [];
}

class StartTimer extends DashEvent {
  final BuildContext context;

  const StartTimer(this.context);

  @override
  List<Object?> get props => [context];
}

class StopTimer extends DashEvent {}

class RefreshToken extends DashEvent {
  final BuildContext context;

  const RefreshToken(this.context);

  @override
  List<Object?> get props => [context];
}

class Logout extends DashEvent {
  final BuildContext context;

  const Logout(this.context);

  @override
  List<Object?> get props => [context];
}

class StartScrolling extends DashEvent {
  final BuildContext context;

  const StartScrolling(this.context);

  @override
  List<Object?> get props => [context];
}

class StopScrolling extends DashEvent {}