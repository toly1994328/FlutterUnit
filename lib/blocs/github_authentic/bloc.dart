import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_unit/app/utils/http/rep_result.dart';
import 'package:flutter_unit/model/github/github_user.dart';
import 'package:flutter_unit/repositories/github_authentic_repository.dart';
import 'package:flutter_unit/repositories/github_user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

part 'event.dart';

part 'state.dart';

// 验证的bloc 需要一个 UserRepository

// 在程序开始时会触发 AppStarted 事件
// 此时bloc会用 UserRepository 查看是否存在token
// 来返回状态AuthSuccess 或 AuthFailure
// AuthFailure之后出现登录界面,  AuthSuccess后会到主页

// 在登录完成后会触发LoginOver事件
// 此时bloc会通过userRepository.persistToken对token进行持久化

class GithubAuthenticBloc extends Bloc<GithubAuthEvent, AuthenticState> {
  final GithubAuthenticRepository authenticationRepository;
  final GithubUserRepository userRepository;

  GithubAuthenticBloc(
      {@required this.authenticationRepository,
        @required this.userRepository})
      : assert(authenticationRepository != null);

  @override
  AuthenticState get initialState => AuthInitial();

  String get token => authenticationRepository.token;

  GithubUser get user {
    if (state is AuthSuccess) {
      return (state as AuthSuccess).user;
    }
    return null;
  }

  @override
  Stream<AuthenticState> mapEventToState(
    GithubAuthEvent event,
  ) async* {
    if (event is CheckGithubAuth) {
      final bool hasToken = await authenticationRepository.hasToken();
//      await LocalDao.dao.initLocalStorage();
      if (hasToken) {
        var user = await userRepository.getLocalUser();
        yield AuthSuccess(token: authenticationRepository.token,user: user);
      } else {
        yield AuthFailure();
      }
    }

    if (event is LoginOver) {
      yield AuthLoading();
      await authenticationRepository.persistToken(event.result.msg);
      yield AuthSuccess(user: event.result.data,token: event.result.msg);
    }

    if (event is LoggedOut) {
      yield AuthLoading();
      await userRepository.deleteLocalUser();
      await authenticationRepository.deleteToken();
      yield AuthFailure();
    }
  }
}
