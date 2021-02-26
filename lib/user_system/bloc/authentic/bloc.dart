import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_unit/app/utils/http_utils/http_util.dart';
import 'package:flutter_unit/storage/dao/local_storage.dart';
import 'package:flutter_unit/user_system/model/user.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'event.dart';
import 'state.dart';

class AuthenticBloc extends Bloc<AuthEvent, AuthenticState> {
  AuthenticBloc() : super(AuthInitial());

  @override
  Stream<AuthenticState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      String token = await LocalStorage.get(LocalStorage.tokenKey);
      String userJson = await LocalStorage.get(LocalStorage.userKey);
      if (token != null && userJson != null) {
        bool disable = JwtDecoder.isExpired(token);
        if (!disable) {
          HttpUtil.getInstance().setToken(token);
          yield AuthSuccess(User.fromJson(json.decode(userJson)));
        }else{
          // 说明 token 过期
          await _removeToken();
          await _removeUser();
        }
      }
    }

    if (event is LoginOver) {
      HttpUtil.getInstance().setToken(event.token);
      await _persistToken(event.token);
      await _persistUser(event.user);
      yield AuthSuccess(event.user);
    }

    if (event is LoggedOut) {}
  }

  // 持久化 token
  Future<void> _persistToken(String token) async {
    await LocalStorage.save(LocalStorage.tokenKey, token);
  }


  // 持久化 token
  Future<void> _removeToken() async {
    await LocalStorage.remove(LocalStorage.tokenKey);
  }

  // 持久化 token
  Future<void> _removeUser() async {
    await LocalStorage.remove(LocalStorage.userKey);
  }

  // 持久化 user
  Future<void> _persistUser(User user) async {
    await LocalStorage.save(LocalStorage.userKey, json.encode(user));
  }


}
