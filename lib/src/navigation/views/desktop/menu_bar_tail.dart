// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-05-13
// Contact Me:  1981462002@qq.com

import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toly_ui/toly_ui.dart';

import 'theme_model_switch_icon.dart';

enum ActionType{
  settings(path: '/settings'),
  collection(path: '/collection');
  final String path;
  const ActionType({required this.path});
}

class MenuBarTail extends StatelessWidget {
  const MenuBarTail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(indent: 20, color: Colors.white, height: 1),
        Wrap(
          spacing: 12,
          children: [
            FeedbackWidget(
              onPressed: () {
                context.push(ActionType.settings.path);
              },
              child: const Padding(
                padding: EdgeInsets.only(bottom: 16, top: 16),
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),
            ),
            FeedbackWidget(
              onPressed: () => context.push(ActionType.collection.path),
              child: const Padding(
                padding: EdgeInsets.only(bottom: 16, top: 16),
                child: Icon(
                  TolyIcon.icon_collect,
                  color: Colors.white,
                ),
              ),
            ),
            const ThemeModelSwitchIcon(),
          ],
        ),
      ],
    );
  }
}
