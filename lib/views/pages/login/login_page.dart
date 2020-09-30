import 'package:flutter/material.dart';
import 'package:flutter_unit/app/res/toly_icon.dart';

import 'arc_clipper.dart';
import 'login_form.dart';

/// create by 张风捷特烈 on 2020/4/24
/// contact me by email 1981462002@qq.com
/// 说明:

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return

//      BlocListener<AuthenticBloc, AuthenticState>(
//      listener: (context, state) {
//        if (state is AuthSuccess) {
//          Navigator.of(context).pushReplacementNamed(Router.nav);
//        }
//      },
//      child:

      Scaffold(
          body: SingleChildScrollView(
            child: Wrap(children: [
        arcBackground(),
        Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
            child:
//
//          BlocBuilder<LoginBloc, LoginState>(
//            builder: (_, state) {
//              return

                  Stack(
                  alignment: Alignment.center,
                  children: [
                    LoginFrom(),
//                  if (state is LoginFailure)
//                    Positioned(
//                        bottom: 0,
//                        child: ErrorMsg(
//                          error: state.error,
//                        )),
//                  if (state is LoginLoading)
//                    LoadingView(
//                      text: "登录中...",
//                    )
                  ],

                  )
//              );
//            },
//          ),
//        )
//      ]
                  )]
//        ),
    ),
          ));
  }

  Widget arcBackground() {
    return ArcBackground(
      image: AssetImage("assets/images/caver.webp"),
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.blue.withAlpha(88), shape: BoxShape.circle),
          child: Icon(TolyIcon.icon_github,size: 100,)
        ),
      ),
    );
  }
}

class ArcBackground extends StatelessWidget {
  final Widget child;
  final ImageProvider image;

  ArcBackground({this.child, this.image});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ArcClipper(),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: image,
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
