// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-06-23
// Contact Me:  1981462002@qq.com

import 'package:flutter/material.dart';
import 'package:tolyui/tolyui.dart';

import '../../cons.dart';
import '../../data/flex_attr.dart';
import '../../data/stack_attr.dart';
import '../display_item.dart';
import 'stack_op_panel.dart';

class StackPlayground extends StatefulWidget {
  const StackPlayground({super.key});

  @override
  State<StackPlayground> createState() => _StackPlaygroundState();
}

class _StackPlaygroundState extends State<StackPlayground> {
  List<DisplayItem> _data = [];
  StackAttr _attr = StackAttr();
  int _selectIndex = -1;

  @override
  void initState() {
    super.initState();
    _data = [
      DisplayItem(width: 80, height: 80, color: kColors[3]),
      DisplayItem(width: 60, height: 60, color: kColors[2]),
      DisplayItem(width: 40, height: 40, color: kColors[1]),
      DisplayItem(width: 20, height: 20, color: kColors[0]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: ColoredBox(
                    color: Colors.grey.withOpacity(0.1),
                    child: StackDisplay(
                      items: _data,
                      attr: _attr,
                      selectIndex: _selectIndex,
                      onSelectChanged: _onSelectChanged,
                    )),
              ),
            )),
        const VerticalDivider(),
        SizedBox(
            width: 200,
            child: StackOpTool(
              attr: _attr,
              onReset: ()=>_onAttrChange(StackAttr()),
              onAddBox: _onAddBox,
              onDelete: _deleteSelectIndex,
              onAttrChange: _onAttrChange,
            )),
      ],
    );
  }

  void _onAttrChange(StackAttr attr) {
    setState(() {
      _attr = attr;
    });
  }

  void _onAddBox(Size size) {
    int index = _data.length + 1;
    Color color = kColors[index % kColors.length];
    _data.add(DisplayItem(width: size.width, height: size.height, color: color));
    print(size);
    setState(() {});
  }

  void _onSelectChanged(int value) {
    if (_selectIndex == value) {
      _selectIndex = -1;
    } else {
      _selectIndex = value;
    }
    setState(() {});
  }

  void _deleteSelectIndex() {
    if (_selectIndex < 0 || _selectIndex >= _data.length) {
      $message.warning(message: '请先选择删除的色块!');
      return;
    }
    _data.removeAt(_selectIndex);
    _selectIndex = -1;
    setState(() {});
  }
}

class StackDisplay extends StatelessWidget {
  final List<DisplayItem> items;
  final StackAttr attr;
  final int selectIndex;
  final ValueChanged<int> onSelectChanged;

  const StackDisplay({
    super.key,
    required this.items,
    required this.attr,
    required this.selectIndex,
    required this.onSelectChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: attr.fit,
      alignment: attr.alignment.value,
      textDirection: attr.textDirection,
      children: items.asMap().keys.map((int index) {
        bool active = selectIndex == index;
        return GestureDetector(
          onTap: () => onSelectChanged(index),
          child: DisplayPlayItem(item: items[index], selected: active),
        );
      }).toList(),
    );
  }
}
