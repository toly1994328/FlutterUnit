import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/user_system/bloc/authentic/bloc.dart';
import 'package:flutter_unit/user_system/bloc/authentic/event.dart';
import 'package:flutter_unit/user_system/bloc/login/bloc.dart';
import 'package:flutter_unit/user_system/bloc/register/bloc.dart';
import 'package:flutter_unit/user_system/pages/register/arc_clipper.dart';

import 'login_form.dart';

/// create by 张风捷特烈 on 2020/4/24
/// contact me by email 1981462002@qq.com
/// 说明:

class AuthenticScope extends StatelessWidget {
  AuthenticScope({Key? key}) : super(key: key);

  final authBloc = AuthenticBloc()..add(const AppStarted());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<RegisterBloc>(create: (_) => RegisterBloc()),
      BlocProvider<LoginBloc>(
          create: (_) =>
              LoginBloc(authenticBloc: context.read<AuthenticBloc>())),
    ], child: const LoginPage());
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size winSize = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
      child: Wrap(children: [
        Stack(children: [
          UnitArcBackground(height: winSize.height * 0.32),
          const Positioned(top: 20, child: BackButton(color: Colors.white)),
        ]),
        Container(
            // color: Colors.green,
            height: winSize.height * 0.68,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
            child: Stack(
              alignment: Alignment.center,
              children: const [
                LoginFrom(),
              ],
            ))
      ]),
    ));
  }
}
