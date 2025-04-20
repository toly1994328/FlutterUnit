// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-05-23
// Contact Me:  1981462002@qq.com

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tolyui/tolyui.dart';

class AlgoMenuMetaExt extends Extra {
  final String? subtitle;
  final String? tag;
  final bool? isFlutter;

  const AlgoMenuMetaExt({
    required this.subtitle,
    required this.tag,
    required this.isFlutter,
  });

  factory AlgoMenuMetaExt.fromMap(Map<String, dynamic> map) {
    return AlgoMenuMetaExt(
      subtitle: map['subtitle'],
      tag: map['tag'],
      isFlutter: map['isFlutter'],
    );
  }
}

class AlgoMenuCell extends StatelessWidget {
  final MenuNode menuNode;
  final DisplayMeta display;
  final MenuTreeCellStyle? style;

  const AlgoMenuCell({
    super.key,
    required this.menuNode,
    required this.display,
    this.style,
  });

  MenuTreeCellStyle get effectStyle =>
      style ??
      (display.isDark ? MenuTreeCellStyle.dark() : MenuTreeCellStyle.light());

  Color? effectForegroundColor(MenuTreeCellStyle style) {
    if (display.selected) {
      return display.isDark ? Colors.white : style.activeForegroundColor;
    }
    if (display.hovered) {
      return display.isDark ? Colors.white : style.hoverForegroundColor;
    }
    return style.inactiveForegroundColor;
  }

  double get anim => display.anima ?? 1;

  Color? backgroundColor(MenuTreeCellStyle style) {
    if (hasChild) return null;
    if (selectOrPlaying) {
      return style.activeBackgroundColor.withOpacity(anim);
    }
    if (display.hovered) {
      return style.hoverBackgroundColor;
    }
    return null;
  }

  bool get selectOrPlaying => (display.selected || display.playing);

  bool get hasChild => menuNode.children.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    MenuTreeCellStyle effectStyle = style ??
        (display.isDark ? MenuTreeCellStyle.dark() : MenuTreeCellStyle.light());

    Color? bgColor = backgroundColor(effectStyle);
    Color? fgColor = effectForegroundColor(effectStyle);
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 2);

    IconData? icon;
    if (menuNode.data is IconMenu) {
      icon = (menuNode.data as IconMenu).icon;
    }
    Widget cell = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: bgColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                left: 12.0 + (28 * menuNode.depth),
                top: ext?.subtitle == null ? 8 : 8,
                bottom: ext?.subtitle == null ? 8 : 8,
              ),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (icon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(icon, size: 20, color: fgColor),
                    ),
                  _buildTitle(fgColor)
                ],
              ),
            ),
          ),
          if (ext?.tag != null) _buildTag(ext),
          if (menuNode.children.isNotEmpty)
            _buildExpandIndicator(display.expanded, fgColor)
        ],
      ),
    );
    if (selectOrPlaying && effectStyle.showIndicator && !hasChild) {
      cell = Stack(
        alignment: Alignment.centerLeft,
        children: [
          cell,
          LineIndicator(progress: anim, color: fgColor),
        ],
      );
    }
    return Padding(padding: padding, child: cell);
  }

  AlgoMenuMetaExt? get ext => menuNode.data.ext?.me<AlgoMenuMetaExt>();

  Widget _buildTitle(Color? fgColor) {
    TextStyle subStyle = const TextStyle(fontSize: 12, color: Colors.grey);
    TextStyle titleStyle = TextStyle(color: fgColor);
    Widget child = Text(
      menuNode.data.label,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: titleStyle,
    );
    if (ext?.isFlutter ?? false) {
      child = Wrap(
        spacing: 4,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [child, const FlutterLogo(size: 14)],
      );
    }
    if (ext?.subtitle != null) {
      child = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [child, Text(ext!.subtitle!, style: subStyle)],
      );
    }
    return child;
  }

  Widget _buildTag(AlgoMenuMetaExt? ext) {
    TextStyle tagStyle =
        const TextStyle(color: Colors.white, height: 1, fontSize: 10);
    Widget child = Text('${ext?.tag}',
        overflow: TextOverflow.ellipsis, maxLines: 1, style: tagStyle);
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.8),
              borderRadius: BorderRadius.circular(4)),
          child: child),
    );
  }

  Widget _buildExpandIndicator(bool expanded, Color? color) {
    return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Transform.rotate(
            angle: display.rate * pi,
            child: Icon(CupertinoIcons.chevron_down, size: 16, color: color)));
  }
}
