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
import '../display_item.dart';
import 'flex_op_panel.dart';

class FlexPlayground extends StatefulWidget {
  const FlexPlayground({super.key});

  @override
  State<FlexPlayground> createState() => _FlexPlaygroundState();
}

class _FlexPlaygroundState extends State<FlexPlayground> {
  List<DisplayItem> _data = [];
  late FlexAttr _attr;
  int _selectIndex = -1;

  @override
  void initState() {
    super.initState();
    _reset(init: true);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Center(
              child: ColoredBox(
                  color: Colors.grey.withOpacity(0.1),
                  child: FlexDisplay(
                    items: _data,
                    attr: _attr,
                    selectIndex: _selectIndex,
                    onSelectChanged: _onSelectChanged,
                  )),
            )),
        const VerticalDivider(),
        SizedBox(
            width: 200,
            child: FlexOpTool(
              attr: _attr,
              onReset: _reset,
              onAddBox: _onAddBox,
              onDelete: _deleteSelectIndex,
              onAttrChange: _onAttrChange,
            )),
      ],
    );
  }

  void _reset({bool init=false}){
    _attr = FlexAttr(direction: Axis.horizontal);
    _data = [
      DisplayItem(width: 20, height: 20, color: kColors[0]),
      DisplayItem(width: 10, height: 80, color: kColors[1]),
      DisplayItem(width: 40, height: 30, color: kColors[2]),
      DisplayItem(width: 60, height: 20, color: kColors[3]),
    ];
    if(init) return;
    setState(() {});
  }

  void _onAttrChange(FlexAttr attr) {
    setState(() {
      _attr = attr;
    });
  }

  void _onAddBox(Size size) {
    int index = _data.length + 1;
    Color color = kColors[index % kColors.length];
    _data.add(DisplayItem(width: size.width, height: size.height, color: color));
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

  void _onSelectChanged(int value) {
    if (_selectIndex == value) {
      _selectIndex = -1;
    } else {
      _selectIndex = value;
    }
    setState(() {});
  }


}

class FlexDisplay extends StatelessWidget {
  final List<DisplayItem> items;
  final FlexAttr attr;
  final int selectIndex;
  final ValueChanged<int> onSelectChanged;

  const FlexDisplay({
    super.key,
    required this.items,
    required this.attr,
    required this.selectIndex,
    required this.onSelectChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: attr.direction,
      mainAxisAlignment: attr.mainAxisAlignment,
      crossAxisAlignment: attr.crossAxisAlignment,
      mainAxisSize: attr.mainAxisSize,
      textDirection: attr.textDirection,
      verticalDirection: attr.verticalDirection,
      textBaseline: TextBaseline.alphabetic,
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
