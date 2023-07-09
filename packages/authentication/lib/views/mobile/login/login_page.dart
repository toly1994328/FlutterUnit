import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../register/arc_clipper.dart';
import 'login_form.dart';

/// create by 张风捷特烈 on 2020/4/24
/// contact me by email 1981462002@qq.com
/// 说明:

// class AuthenticScope extends StatelessWidget {
//   const AuthenticScope({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final AuthRepository repository = context.read<AuthBloc>().repository;
//     return MultiBlocProvider(providers: [
//       BlocProvider<RegisterBloc>(create: (_) => RegisterBloc(repository: repository)),
//     ], child: const LoginPage());
//   }
// }

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size winSize = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
      child: Wrap(children: [
        Stack(children: [
          UnitArcBackground(height: winSize.height * 0.3),
          const Positioned(top: 24, child: BackButton(color: Colors.white)),
        ]),
        Container(
            // color: Colors.green,
            height: winSize.height * 0.68,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
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
