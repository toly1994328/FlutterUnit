import 'package:equatable/equatable.dart';
import 'package:flutter_unit/user_system/model/user.dart';

/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明: 主页 Widget 列表 状态类

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginError extends LoginState {
  final String message;

  const LoginError(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() {
    return 'LoginError{message: $message}';
  }
}

class LoginSuccess extends LoginState {
  final User user;

  const LoginSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class LoginNone extends LoginState {


  const LoginNone();

  @override
  List<Object> get props => [];
}
