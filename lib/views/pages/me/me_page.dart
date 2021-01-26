import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/router/unit_router.dart';
import 'package:flutter_unit/blocs/authentic/bloc.dart';
import 'package:flutter_unit/blocs/authentic/state.dart';
import 'package:flutter_unit/views/components/permanent/circle_image.dart';
import 'package:flutter_unit/views/components/permanent/feedback_widget.dart';

import 'page_item.dart';

/// create by 张风捷特烈 on 2020/4/26
/// contact me by email 1981462002@qq.com
/// 说明:

class MePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 40),
              child: Image.asset(
                'assets/images/sabar_bar.webp',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 40,
              child: FeedbackWidget(
                onEnd: () {
                  Navigator.of(context).pushNamed(UnitRouter.login);
                },
                child: CircleImage(
                  size: 80,
                  shadowColor: Theme.of(context).primaryColor.withAlpha(33),
                  image: AssetImage("assets/images/icon_head.webp"),
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                right: 20,
                child: BlocBuilder<AuthenticBloc, AuthenticState>(
                  builder: _buildByState,
                ))
          ],
        ),
        Expanded(child: MePageItem())
      ],
    ));
  }

  Widget _buildByState(BuildContext context, AuthenticState state) {
    if (state is AuthSuccess) {
      return Text(
        state.user.username,
        style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
      );
    }
    return Text(
      '张风捷特烈',
      style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
    );
  }
}
