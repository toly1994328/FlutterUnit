import 'package:equatable/equatable.dart';

/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明:

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

// 发送 邮箱验证
class DoLogin extends LoginEvent {
  final String username;
  final String password;

  DoLogin({this.username, this.password});
}
