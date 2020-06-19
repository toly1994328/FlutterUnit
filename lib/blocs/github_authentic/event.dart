
part of 'bloc.dart';

///********************************验证行为********************************

abstract class GithubAuthEvent extends Equatable {
  const GithubAuthEvent();

  @override
  List<Object> get props => [];
}

class CheckGithubAuth extends GithubAuthEvent {}

class LoginOver extends GithubAuthEvent {
  final RepResult result;
  const LoginOver({this.result});

  @override
  List<Object> get props => [result];

  @override
  String toString() => 'LoggedIn { token: $result }';
}

class LoggedOut extends GithubAuthEvent {}