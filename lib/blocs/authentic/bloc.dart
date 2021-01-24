import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_unit/app/utils/http_utils/http_util.dart';
import 'package:flutter_unit/blocs/authentic/state.dart';

import 'event.dart';

class AuthenticBloc extends Bloc<AuthEvent, AuthenticState> {
  AuthenticBloc() : super(AuthInitial());

  @override
  Stream<AuthenticState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {}

    if (event is LoginOver) {
      HttpUtil.getInstance().setToken(event.token);
      yield AuthSuccess(event.user);
    }

    if (event is LoggedOut) {}
  }
}
