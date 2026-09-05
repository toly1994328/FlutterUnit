// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-05-13
// Contact Me:  1981462002@qq.com

import 'package:app/app.dart';
import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_user_session/fx_user_session.dart';
import 'package:tolyui/tolyui.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuBarLeading extends StatelessWidget {
  const MenuBarLeading({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FxUserSessionCubit, FxUserSession>(
      buildWhen: _shouldRebuildUserSummary,
      builder: _buildLeading,
    );
  }

  Widget _buildLeading(BuildContext context, FxUserSession session) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Column(
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _openUserEntry(context, session),
            onDoubleTap: _sendAvatarEvent,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Wrap(
                direction: Axis.vertical,
                spacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  const SizedBox.square(
                    dimension: 80,
                    child: Center(
                      child: SessionUserAvatar(
                        size: 60,
                        showShadow: false,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 116,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            _displayName(session),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ),
                        EquippedBadges(
                          size: 14,
                          onTap: () => context.go(AppRoute.honors.url),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          _buildIcons(),
          const Divider(color: Colors.white, height: 1, endIndent: 20),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  /// 导航栏中展示的外部链接入口。
  final List<LinkIconMenu> menus = const [
    LinkIconMenu(
        TolyIcon.icon_github, "https://github.com/toly1994328/FlutterUnit"),
    LinkIconMenu(TolyIcon.icon_juejin,
        'https://juejin.im/user/5b42c0656fb9a04fe727eb37'),
    LinkIconMenu(TolyIcon.icon_item, 'http://toly1994.com'),
  ];

  Widget _buildIcons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 8),
      child: Wrap(
        spacing: 8,
        children: menus.map(_buildLinkAction).toList(),
      ),
    );
  }

  Widget _buildLinkAction(LinkIconMenu menu) {
    return TolyAction(
      style: const ActionStyle.dark(),
      onTap: menu.launch,
      child: Icon(menu.icon, color: Colors.white, size: 22),
    );
  }

  /// 根据登录状态进入用户中心或打开桌面登录弹框。
  void _openUserEntry(BuildContext context, FxUserSession session) {
    if (session is FxAuthed) {
      context.go(AppRoute.honors.url);
      return;
    }
    openUserLogin(context);
  }

  void _sendAvatarEvent() {
    sendEvent(1);
  }

  bool _shouldRebuildUserSummary(
    FxUserSession previous,
    FxUserSession current,
  ) {
    return previous.runtimeType != current.runtimeType ||
        _displayName(previous) != _displayName(current);
  }

  String _displayName(FxUserSession session) {
    if (session is! FxAuthed) return '登录/注册';
    return session.user.displayName ?? session.user.id;
  }
}

class LinkIconMenu {
  /// 外部链接对应的图标。
  final IconData icon;

  /// 点击后打开的外部地址。
  final String url;

  const LinkIconMenu(this.icon, this.url);

  void launch() => _launchUrl(url);

  Future<void> _launchUrl(String url) async {
    await launchUrl(Uri.parse(url));
  }
}
