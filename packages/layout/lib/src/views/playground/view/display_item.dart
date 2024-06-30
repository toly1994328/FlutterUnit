// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-06-29
// Contact Me:  1981462002@qq.com

import 'package:flutter/material.dart';

class DisplayItem {
  final double width;
  final double height;
  final Color color;

  DisplayItem({
    required this.width,
    required this.height,
    required this.color,
  });
}


class DisplayPlayItem extends StatefulWidget {
  final DisplayItem item;
  final bool selected;
  const DisplayPlayItem({
    super.key,
    required this.item,
    required this.selected,
  });

  @override
  State<DisplayPlayItem> createState() => _DisplayPlayItemState();
}

class _DisplayPlayItemState extends State<DisplayPlayItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.item.width,
      height: widget.item.height,
      decoration: BoxDecoration(
        border: widget.selected ? Border.all() : null,
        color: widget.item.color,
      ),
    );
  }
}
