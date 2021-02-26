
import 'package:equatable/equatable.dart';
import 'package:flutter_unit/user_system/model/user.dart';



///********************************校验状态********************************
//
abstract class AuthenticState extends Equatable {
  @override
  List<Object> get props => [];
}


class AuthInitial extends AuthenticState {}



class AuthFailure extends AuthenticState {

}


class LogOuted extends AuthenticState {}

class AuthSuccess extends AuthenticState {
  final User user;

  AuthSuccess(this.user);

  @override
  String toString() {
    return 'AuthSuccess{loginResult: $user}';
  }
}

class AuthLoading extends AuthenticState {

}