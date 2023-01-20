import 'package:equatable/equatable.dart';



///********************************验证行为********************************

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {
  const AppStarted();
}

// 发送 邮箱验证
class AuthByPassword extends AuthEvent {
  final String username;
  final String password;

  const AuthByPassword({required this.username,required this.password});

  @override
  List<Object> get props => [username,password];
}


class LoggedOut extends AuthEvent {

  final bool clearUser;
  final bool tokenDisable;

  const LoggedOut({this.clearUser=true,this.tokenDisable=false});
}

class TokenDisabled extends AuthEvent {

  const TokenDisabled();
}