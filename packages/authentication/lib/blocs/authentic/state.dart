
import 'package:authentication/models/user.dart';
import 'package:equatable/equatable.dart';

enum AuthType{
  login,
  register,
  visitor
}

///********************************校验状态********************************
abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
const AuthInitial();
}


class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'AuthFailure{message: $error}';
  }
}


class LogOuted extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess(this.user);

  @override
  String toString() {
    return 'AuthSuccess{loginResult: $user}';
  }
}

class AuthLoading extends AuthState {

}