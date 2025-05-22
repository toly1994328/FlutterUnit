// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-05-13
// Contact Me:  1981462002@qq.com

import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:tolyui/tolyui.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuBarLeading extends StatelessWidget {
  const MenuBarLeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Column(
        children: [
          Wrap(
            direction: Axis.vertical,
            spacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              GestureDetector(
                onDoubleTap: () {
                  sendEvent(1);
                },
                child: const CircleImage(
                  image: AssetImage('assets/images/icon_head.webp'),
                  size: 60,
                ),
              ),
              const Text(
                '张风捷特烈',
                style: TextStyle(color: Colors.white70),
              )
            ],
          ),
          _buildIcons(),
          const Divider(color: Colors.white, height: 1, endIndent: 20),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

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
        children: menus
            .map((menu) => TolyAction(
                  style: const ActionStyle.dark(),
                  onTap: menu.launch,
                  child: Icon(menu.icon, color: Colors.white, size: 22),
                ))
            .toList(),
      ),
    );
  }
}

class LinkIconMenu {
  final IconData icon;
  final String url;

  const LinkIconMenu(this.icon, this.url);

  void launch() => _launchUrl(url);

  void _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {}
  }
}
