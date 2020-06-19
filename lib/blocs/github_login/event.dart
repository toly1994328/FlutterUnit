part of 'bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class EventLogin extends LoginEvent {
  final String username;
  final String password;

  const EventLogin({
    @required this.username,
    @required this.password
  });

  @override
  List<Object> get props => [username, password];

  @override
  String toString() => 'EventLogin { username: $username, password: $password }';
}
