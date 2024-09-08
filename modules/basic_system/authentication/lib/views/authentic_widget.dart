import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication.dart';

/// create by 张风捷特烈 on 2021/2/24
/// contact me by email 1981462002@qq.com
/// 说明:

class AuthenticWidget extends StatelessWidget {
  final Widget authentic;
  final Widget noAuthentic;

   const AuthenticWidget(
      {Key? key, required this.authentic, required this.noAuthentic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
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
