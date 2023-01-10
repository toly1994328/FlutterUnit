import 'dart:async';
import 'dart:convert';

import 'package:app_config/app_config.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_unit/app/utils/http_utils/http_util.dart';

import 'package:flutter_unit/user_system/model/user.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'event.dart';
import 'state.dart';

class AuthenticBloc extends Bloc<AuthEvent, AuthenticState> {
  AuthenticBloc() : super(AuthInitial()){
    on<AppStarted>(_onAppStarted);
  }

  void _onAppStarted(AuthEvent event,  Emitter<AuthenticState> emit) async{
    SharedPreferences sp = await SharedPreferences.getInstance();

    if (event is AppStarted) {
      String? token =  sp.getString(SpKey.tokenKey);
      String? userJson =  sp.getString(SpKey.userKey);
      if (token != null && userJson != null) {
        bool disable = JwtDecoder.isExpired(token);
        if (!disable) {
          HttpUtil.getInstance().setToken(token);
          emit(AuthSuccess(User.fromJson(json.decode(userJson))));
        }else{
          // 说明 token 过期
          await _removeToken(sp);
          await _removeUser(sp);
        }
      }
    }

    if (event is LoginOver) {
      HttpUtil.getInstance().setToken(event.token);
      await _persistToken(event.token,sp);
      await _persistUser(event.user,sp);
      emit(AuthSuccess(event.user));
    }

    if (event is LoggedOut) {

    }
  }

  // 持久化 token
  Future<void> _persistToken(String token,SharedPreferences sp) async {
    await sp.setString(SpKey.tokenKey, token);
  }


  // 持久化 token
  Future<void> _removeToken(SharedPreferences sp) async {
    await sp.remove(SpKey.tokenKey);
  }

  // 持久化 token
  Future<void> _removeUser(SharedPreferences sp) async {
    await sp.remove(SpKey.userKey);
  }

  // 持久化 user
  Future<void> _persistUser(User user,SharedPreferences sp) async {
    await sp.setString(SpKey.userKey, json.encode(user));
  }


}
