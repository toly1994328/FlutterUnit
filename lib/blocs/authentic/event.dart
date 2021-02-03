import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/user_system/model/user.dart';



///********************************验证行为********************************

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoginOver extends AuthEvent {
  final String token;
  final User user;

  const LoginOver({@required this.token,this.user});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'LoginOver { token: $token }';
}

class LoggedOut extends AuthEvent {

  final bool clearUser;
  final bool tokenDisable;

  LoggedOut({this.clearUser=true,this.tokenDisable=false});
}

class TokenDisabled extends AuthEvent {

  TokenDisabled();
}