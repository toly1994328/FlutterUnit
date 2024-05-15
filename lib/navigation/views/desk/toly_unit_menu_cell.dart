// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-05-13
// Contact Me:  1981462002@qq.com

import 'package:flutter/material.dart';
import 'package:tolyui_navigation/tolyui_navigation.dart';

final Tween<double> _widthTween = Tween(begin: 0.82, end: 0.95);
final Tween<double> _sizeTween = Tween(begin: 18.0, end: 22.0);
final Tween<double> _fontSizeTween = Tween(begin: 14.0, end: 15);

class FlutterUnitMenuCell extends StatelessWidget {
  final MenuMeta menu;
  final DisplayMeta display;

  const FlutterUnitMenuCell.create(this.menu, this.display, {super.key});

  Color? get foregroundColor => display.selected ? Colors.white : Colors.white70;

  @override
  Widget build(BuildContext context) {
    double height = 42;

    double anim = display.rate;
    Color? color = ColorTween(
            begin: Colors.white.withAlpha(33),
            end: Theme.of(context).primaryColor)
        .transform(anim);

    double iconSize = _sizeTween.transform(anim);
    double fontSize = _fontSizeTween.transform(anim);

    TextStyle style = TextStyle(color: foregroundColor, fontSize: fontSize);
    Radius radius = Radius.circular(height / 2);
    BorderRadius br = BorderRadius.only(topRight: radius, bottomRight: radius);

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: color, borderRadius: br),
        width: _widthTween.transform(anim) * 130,
        height: height,
        child: Wrap(
          spacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(menu.icon, color: foregroundColor, size: iconSize),
            Text(menu.label, style: style),
          ],
        ),
      ),
    );
  }
}
