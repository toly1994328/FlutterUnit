import 'dart:async';
import 'dart:convert';

import 'package:app/app.dart';
import 'package:authentication/authentication.dart';
import 'package:authentication/models/user.dart';
import 'package:bloc/bloc.dart';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utils/utils.dart';

import 'event.dart';
import 'state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthRepository repository;

  AuthBloc({required this.repository}) : super(const AuthInitial()){
    on<AppStarted>(_onAppStarted);
    on<AuthByPassword>(_onAuthByPassword);
    on<AuthByRegister>(_onAuthByRegister);
    on<Logout>(_onLoggedOut);
  }

  void _onAppStarted(AuthEvent event,  Emitter<AuthState> emit) async{
    SharedPreferences sp = await SharedPreferences.getInstance();

    if (event is AppStarted) {
      String? token =  sp.getString(SpKey.tokenKey);
      String? userJson =  sp.getString(SpKey.userKey);
      if (token != null && userJson != null) {
        bool disable = JwtDecoder.isExpired(token);
        if (!disable) {
          HttpUtil.instance.setToken(token);
          emit(AuthSuccess(User.fromJson(json.decode(userJson))));
        }else{
          // 说明 token 过期
          await _removeToken(sp);
          await _removeUser(sp);
        }
      }
    }

    if (event is Logout) {

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



  FutureOr<void> _onAuthByPassword(AuthByPassword event, Emitter<AuthState> emit) async{
    emit (AuthLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    TaskResult<User> result = await repository.login(username: event.username, password: event.password);

    if (result.success&& result.data!=null) {
      // 登录成功
      SharedPreferences sp = await SharedPreferences.getInstance();
      HttpUtil.instance.setToken(result.msg);
      await _persistToken(result.msg,sp);
      await _persistUser(result.data!,sp);
      emit (AuthSuccess(result.data!));
    } else {
      emit (const AuthFailure('用户名和密码不匹配'));
    }
  }

  FutureOr<void> _onAuthByRegister(AuthByRegister event, Emitter<AuthState> emit) async{
    emit(AuthLoading());
    TaskResult<bool> result = await repository.register(email: event.email, code: event.code);

    // if(result.data == null){
    //   emit(const RegisterError('注册失败'));
    // }else{
    //   if (result.data!=null&&result.data!) {
    //     // 注册成功
    //     emit( RegisterSuccess(event.email));
    //   }else{
    //     emit( RegisterError(result.msg));
    //   }
    // }
  }

  FutureOr<void> _onLoggedOut(Logout event, Emitter<AuthState> emit) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(SpKey.tokenKey);
    emit(const AuthInitial());
  }
}
