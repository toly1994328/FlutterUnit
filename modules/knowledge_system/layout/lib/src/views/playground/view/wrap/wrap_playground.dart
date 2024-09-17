// Copyright 2014 The 星星 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      星星
// CreateTime:  2024-06-25
// Contact Me:  1981462002@qq.com

// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-06-23
// Contact Me:  1981462002@qq.com

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tolyui/tolyui.dart';

import '../../data/wrap_attr.dart';
import '../display_item.dart';
import '../form_item/item_size_input.dart';
import 'wrap_op_panel.dart';

const List<Color> kColors = [
  Color(0xffd23eb9),
  Color(0xff2164c7),
  Color(0xffd5a213),
  Color(0xff16e848),
];

class WrapPlayground extends StatefulWidget {
  const WrapPlayground({super.key});

  @override
  State<WrapPlayground> createState() => _WrapPlaygroundState();
}

class _WrapPlaygroundState extends State<WrapPlayground> {
  List<DisplayItem> _data = [];
  late WrapAttr _attr;
  int _selectIndex = -1;

  @override
  void initState() {
    super.initState();
    _reset();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Center(
                child: ColoredBox(
                    color: Colors.grey.withOpacity(0.1),
                    child: WrapDisplay(
                      items: _data,
                      attr: _attr,
                      selectIndex: _selectIndex,
                      onSelectChanged: _onSelectChanged,
                    )))),
        const VerticalDivider(),
        SizedBox(
            width: 210,
            child: WrapOpTool(
              attr: _attr,
              onAddBox: _onAddBox,
              onDelete: _deleteSelectIndex,
              onAttrChange: _onAttrChange,
              onReset: _reset,
            )),
      ],
    );
  }

  void _reset() {
    _attr = const WrapAttr();
    _data = [
      DisplayItem(width: 20, height: 20, color: kColors[0]),
      DisplayItem(width: 10, height: 80, color: kColors[1]),
      DisplayItem(width: 40, height: 30, color: kColors[2]),
      DisplayItem(width: 60, height: 20, color: kColors[3]),
    ];
    setState(() {});
  }

  void _onAttrChange(WrapAttr attr) {
    _attr = attr;
    setState(() {});
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

class WrapDisplay extends StatelessWidget {
  final List<DisplayItem> items;
  final WrapAttr attr;
  final int selectIndex;
  final ValueChanged<int> onSelectChanged;

  const WrapDisplay({
    super.key,
    required this.items,
    required this.attr,
    required this.selectIndex,
    required this.onSelectChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: attr.direction,
      alignment: attr.mainAlignment,
      crossAxisAlignment: attr.crossAxisAlignment,
      spacing: attr.spacing,
      textDirection: attr.textDirection,
      verticalDirection: attr.verticalDirection,
      runAlignment: attr.runAlignment,
      runSpacing: attr.runSpacing,
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

