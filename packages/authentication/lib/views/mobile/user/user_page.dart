import 'package:app/app.dart';
import 'package:components/project_ui/project_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:components/toly_ui/toly_ui.dart';


import '../../../authentication.dart';
import 'page_item.dart';

/// create by 张风捷特烈 on 2020/4/26
/// contact me by email 1981462002@qq.com
/// 说明:

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppStyle style = context.read<AppBloc>().state.appStyle;
    return Scaffold(
      backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value:const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark
          ),
          child: Column(
      children: [
          Stack(
            children: [
              Container(
                height: 180,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(bottom: 40),
                child: Image.asset(
                  style == AppStyle.standard
                      ? 'assets/images/base_draw.webp'
                      : 'assets/images/sabar_bar.webp',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 50,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4)),
                    child: const Icon(
                      Icons.color_lens_outlined,
                      color: Colors.white,
                      size: 20,
                    )),
              ),
              Positioned(
                bottom: 0,
                left: 40,
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: _buildAvatarByState,
                ),
              ),
              Positioned(
                  bottom: 5,
                  right: 30,
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: _buildByState,
                  ))
            ],
          ),
          const Expanded(child: MePageItem())
      ],
    ),
        ));
  }

  Widget _buildByState(BuildContext context, AuthState state) {
    if (state is AuthSuccess) {
      if (state.user.isHonour) {
        return HonourWrapper(username: state.user.username);
      }

      return Text(
        state.user.username,
        style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
      );
    }
    return Text(
      '张风捷特烈',
      style: TextStyle(
          fontSize: 18,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold),
    );
  }

  Widget _buildAvatarByState(BuildContext context, AuthState state) {
    if (state is AuthSuccess) {
      return FeedbackWidget(
        onEnd: () {
          // Navigator.of(context).pushNamed(UnitRouter.login);
        },
        child: CircleImage(
          size: 80,
          shadowColor: Theme.of(context).primaryColor.withAlpha(33),
          // image: NetworkImage(state.user.userAvatar),
          image: const AssetImage("assets/images/icon_head.webp"),
        ),
      );
    }
    return FeedbackWidget(
      onEnd: () {
        // Navigator.of(context).pushNamed(UnitRouter.login);
      },
      child: CircleImage(
        size: 80,
        shadowColor: Theme.of(context).primaryColor.withAlpha(33),
        image: const AssetImage("assets/images/icon_head.webp"),
      ),
    );
  }
}
