import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/user_system/api/user_api.dart';
import 'package:flutter_unit/app/utils/http_utils/result_bean.dart';
import 'package:flutter_unit/user_system/bloc/authentic/bloc.dart';
import 'package:flutter_unit/user_system/bloc/authentic/event.dart';
import 'package:flutter_unit/user_system/model/user.dart';

import 'event.dart';
import 'state.dart';

/// create by 张风捷特烈 on 2021/1/17
/// contact me by email 1981462002@qq.com
/// 说明:

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticBloc authenticBloc;

  LoginBloc({ required this.authenticBloc}) : super(LoginNone()){
    on<LoginEvent>(_onLoginEvent);
  }

  void _onLoginEvent(LoginEvent event,Emitter<LoginState> emit) async {
    if (event is DoLogin) {
      emit (LoginLoading());
      await Future.delayed(Duration(milliseconds: 500));
      ResultBean<User> result = await UserApi.login(username: event.username, password: event.password);

      if (result.status&& result.data!=null) {
        // 注册成功
        authenticBloc.add(LoginOver(token: result.msg,user: result.data!));
        emit (LoginSuccess(result.data!));
      } else {
        emit (LoginError('用户名和密码不匹配'));
      }
    }
  }
}
