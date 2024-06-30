// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-06-29
// Contact Me:  1981462002@qq.com

import 'package:flutter/material.dart';


class WrapAttr {
  final Axis direction;
  final WrapAlignment mainAlignment;
  final WrapCrossAlignment crossAxisAlignment;
  final double spacing;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;
  final WrapAlignment runAlignment;
  final double runSpacing;

  const WrapAttr({
    this.direction = Axis.horizontal,
    this.mainAlignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.center,
    this.spacing = 0.0,
    this.textDirection = TextDirection.ltr,
    this.verticalDirection = VerticalDirection.down,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing =0.0,
  });

  WrapAttr copyWith({
    Axis? direction,
    WrapAlignment? mainAlignment,
    WrapCrossAlignment? crossAxisAlignment,
    double? spacing,
    TextDirection?textDirection,
    VerticalDirection? verticalDirection,
    WrapAlignment?runAlignment,
    Clip? clipBehavior,
    double ?runSpacing,

  }) =>
      WrapAttr(
        direction: direction ?? this.direction,
        mainAlignment: mainAlignment ?? this.mainAlignment,
        crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
        spacing: spacing ?? this.spacing,
        textDirection: textDirection ?? this.textDirection,
        verticalDirection: verticalDirection ?? this.verticalDirection,
        runAlignment: runAlignment ?? this.runAlignment,
        runSpacing: runSpacing??this.runSpacing,
      );
}
