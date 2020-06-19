

part of 'bloc.dart';

///********************************校验状态********************************
//
abstract class AuthenticState extends Equatable {
  const AuthenticState();

  @override
  List<Object> get props => [];
}


class AuthInitial extends AuthenticState {}

class AuthSuccess extends AuthenticState {
  final String token;
  final GithubUser user;
  const AuthSuccess({this.token,this.user});
}

class AuthFailure extends AuthenticState {}

class AuthLoading extends AuthenticState {}