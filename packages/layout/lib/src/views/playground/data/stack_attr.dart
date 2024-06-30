// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-06-29
// Contact Me:  1981462002@qq.com

import 'package:flutter/material.dart';



class StackAttr {
  final AttrAlignment alignment;
  final StackFit fit;
  final TextDirection textDirection;

  StackAttr({
    this.alignment = AttrAlignment.topStart,
    this.fit = StackFit.loose,
    this.textDirection = TextDirection.ltr,

  });

  StackAttr copyWith({
    AttrAlignment? alignment,
    StackFit? fit,
    TextDirection? textDirection,
  }) =>
      StackAttr(
        alignment: alignment ?? this.alignment,
        fit: fit ?? this.fit,
        textDirection: textDirection ?? this.textDirection,
      );
}

enum AttrAlignment{
  topStart(Alignment.topLeft),
  topCenter(Alignment.topCenter),
  topRight(Alignment.topRight),
  bottomCenter(Alignment.bottomCenter),
  bottomLeft(Alignment.bottomLeft),
  bottomRight(Alignment.bottomRight),
  center(Alignment.center),
  centerLeft(Alignment.centerLeft),
  centerRight(Alignment.centerRight),
  ;
  final Alignment value;
  const AttrAlignment(this.value);
}
