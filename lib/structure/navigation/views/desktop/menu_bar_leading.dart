// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-05-13
// Contact Me:  1981462002@qq.com

import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuBarLeading extends StatelessWidget {
  const MenuBarLeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20,bottom: 20),
      child: Column(
        children: [
          const Wrap(
            direction: Axis.vertical,
            spacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              CircleImage(
                image: AssetImage('assets/images/icon_head.webp'),
                size: 60,
              ),
              Text(
                '张风捷特烈',
                style: TextStyle(color: Colors.white70),
              )
            ],
          ),
          _buildIcons(),
          const Divider(
            color: Colors.white,
            height: 1,
            endIndent: 20,
          ),
          const SizedBox(height: 16,),
        ],
      ),
    );
  }

  Widget _buildIcons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 16),
      child: Wrap(
        spacing: 8,
        children: [
          FeedbackWidget(
            onPressed: () =>
                _launchURL("https://github.com/toly1994328/FlutterUnit"),
            child: const Icon(
              TolyIcon.icon_github,
              color: Colors.white,
            ),
          ),
          FeedbackWidget(
            onPressed: () =>
                _launchURL("https://juejin.im/user/5b42c0656fb9a04fe727eb37"),
            child: const Icon(
              TolyIcon.icon_juejin,
              color: Colors.white,
            ),
          ),
          FeedbackWidget(
            onPressed: () => _launchURL("http://blog.toly1994.com"),
            child: const Icon(
              TolyIcon.icon_item,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      // throw Exception('Could not launch $url');
    }
  }
}
