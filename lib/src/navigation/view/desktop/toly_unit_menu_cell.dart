// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-05-13
// Contact Me:  1981462002@qq.com

import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tolyui/tolyui.dart';
import 'package:tolyui_navigation/tolyui_navigation.dart';

final Tween<double> _widthTween = Tween(begin: 0.82, end: 0.95);
final Tween<double> _sizeTween = Tween(begin: 18.0, end: 22.0);
final Tween<double> _fontSizeTween = Tween(begin: 14.0, end: 15);

class FlutterUnitMenuCell extends StatelessWidget {
  final MenuMeta menu;
  final bool enableTooltip;
  final DisplayMeta display;

  const FlutterUnitMenuCell.create(this.menu, this.display,
      {super.key, this.enableTooltip = false});

  Color? get foregroundColor =>
      display.selected ? Colors.white : Colors.white70;

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
    IconData? icon;
    if (menu is IconMenu) {
      icon = (menu as IconMenu).icon;
    }
    TextStyle style = TextStyle(color: foregroundColor, fontSize: fontSize);
    Radius radius = Radius.circular(height / 2);
    BorderRadius br = BorderRadius.only(topRight: radius, bottomRight: radius);
    Widget child = Container(
      padding: const EdgeInsets.only(left: 12),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(color: color, borderRadius: br),
      width: _widthTween.transform(anim) * 140,
      height: height,
      child: Row(
        spacing: 6,
        // crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(icon, color: foregroundColor, size: iconSize),
          Expanded(
            child: Text(
              menu.label,
              style: style,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (menu.route == '/account') _buildProgressionBadge(),
          const SizedBox(
            width: 2,
          )
        ],
      ),
    );

    if (enableTooltip) {
      child = TolyTooltip(
        placement: Placement.right,
        message: menu.label,
        child: child,
      );
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: child,
    );
  }

  Widget _buildProgressionBadge() {
    return BlocSelector<ProgressionCubit, ProgressionState, int>(
      selector: (ProgressionState state) => state.claimableTaskCount,
      builder: (BuildContext context, int count) {
        if (count == 0) return const SizedBox.shrink();
        return Align(
          widthFactor: 1,
          heightFactor: 1,
          child: Container(
            height: 16,
            constraints: const BoxConstraints(minWidth: 16),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              count > 99 ? '99+' : '$count',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                height: 1,
              ),
            ),
          ),
        );
      },
    );
  }
}
