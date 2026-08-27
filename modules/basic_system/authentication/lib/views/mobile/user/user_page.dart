import 'package:app/app.dart';
import 'package:authentication/views/mobile/user/user_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_user_session/fx_user_session.dart';

import 'package:toly_ui/toly_ui.dart';

import '../../../authentication.dart';
import 'page_item.dart';

/// create by 张风捷特烈 on 2020/4/26
/// contact me by email 1981462002@qq.com
/// 说明:

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    String image = isDark ? 'anim_draw.webp' : 'base_draw.webp';
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).appBarTheme.systemOverlayStyle!,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 180,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(bottom: 40),
                child: Image.asset(
                  'assets/images/$image',
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
                child: FeedbackWidget(
                  onPressed: () => _openAccountEntry(context),
                  child: const SessionUserAvatar(
                    size: 80,
                    showBorder: true,
                  ),
                ),
              ),
              Positioned(
                  bottom: 5,
                  right: 30,
                  child: BlocBuilder<FxUserSessionCubit, FxUserSession>(
                    builder: _buildByState,
                  ))
            ],
          ),
          const Expanded(child: MePageItem())
        ],
      ),
    ));
  }

  Widget _buildByState(BuildContext context, FxUserSession state) {
    if (state is FxAuthed) {
      return Text(
        state.user.displayName ?? state.user.id,
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

  void _openAccountEntry(BuildContext context) {
    final FxUserSession state = context.read<FxUserSessionCubit>().state;
    if (state is FxAuthed) {
      Navigator.of(context).push(SlidePageRoute(child: UserAccountPage()));
      return;
    }
    context.push(AppRoute.login.url);
  }
}
