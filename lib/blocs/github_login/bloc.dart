import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_unit/repositories/github_user_repository.dart';
import '../github_authentic/bloc.dart';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'event.dart';

part 'state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GithubAuthenticBloc authenticationBloc;

  LoginBloc({
    @required this.authenticationBloc,
  }):assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  GithubUserRepository get userRepository => authenticationBloc.userRepository;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EventLogin) {
      yield LoginLoading();
      try {
        final result = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );
        if (result.status) {
          authenticationBloc.add(LoginOver(result: result));
          // 本地存储用户信息
//          userRepository.setLocalUser(result.user);
        }else{
          yield LoginFailure(error: result.msg);
        }
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
