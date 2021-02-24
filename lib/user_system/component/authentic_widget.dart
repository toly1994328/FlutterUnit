import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/user_system/bloc/authentic/bloc.dart';
import 'package:flutter_unit/user_system/bloc/authentic/state.dart';

/// create by 张风捷特烈 on 2021/2/24
/// contact me by email 1981462002@qq.com
/// 说明:

class AuthenticWidget extends StatelessWidget {
  final Widget authentic;
  final Widget noAuthentic;

  const AuthenticWidget({this.authentic, this.noAuthentic});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticBloc, AuthenticState>(
        builder: (_, state) {
          return state is AuthSuccess ? authentic : noAuthentic;
        });
  }

  factory AuthenticWidget.just(Widget authentic){
    return AuthenticWidget(
      authentic: authentic,
      noAuthentic: const SizedBox(),
    );
  }
}
