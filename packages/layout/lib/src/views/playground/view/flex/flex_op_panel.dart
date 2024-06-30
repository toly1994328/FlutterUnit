// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-06-29
// Contact Me:  1981462002@qq.com

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tolyui/tolyui.dart';

import '../../data/flex_attr.dart';
import '../form_item/item_selector.dart';
import '../form_item/item_size_input.dart';


class FlexOpTool extends StatefulWidget {
  final ValueChanged<Size> onAddBox;
  final VoidCallback onDelete;
  final VoidCallback onReset;
  final FlexAttr attr;
  final ValueChanged<FlexAttr> onAttrChange;

  const FlexOpTool({
    super.key,
    required this.onAddBox,
    required this.onDelete,
    required this.onReset,
    required this.attr,
    required this.onAttrChange,
  });

  @override
  State<FlexOpTool> createState() => _FlexOpToolState();
}

class _FlexOpToolState extends State<FlexOpTool> {
  final TextEditingController _widthCtrl = TextEditingController(text: '24');
  final TextEditingController _heightCtrl = TextEditingController(text: '64');

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = const TextStyle(color: Color(0xff61666d), fontSize: 12);
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Flex 操作面板',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
          child: Row(
            children: [
              Text('增删操作', style: labelStyle.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              TolyAction(onTap: _handleAdd, child: const Icon(CupertinoIcons.add, size: 18)),
              TolyAction(onTap: widget.onDelete, child: const Icon(CupertinoIcons.delete, size: 16)),
            ],
          ),
        ),
        ItemSizeInput(widthCtrl: _widthCtrl, heightCtrl: _heightCtrl),
        const SizedBox(height: 12),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
          child: Row(
            children: [
              Text('属性操作', style: labelStyle.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              TolyAction(onTap: widget.onReset, child: const Icon(CupertinoIcons.refresh, size: 16)),

            ],
          ),
        ),
        ItemSelector<Axis>(
          label: '排列方向:',
          subTitle: 'direction',
          selectIndex: widget.attr.direction.index,
          data: Axis.values,
          calcFun: (Axis data) => data.name,
          onSelect: (Axis value) {
            widget.onAttrChange(widget.attr.copyWith(direction: value));
          },
        ),
        ItemSelector<MainAxisAlignment>(
          label: '主轴对齐:',
          subTitle: 'mainAxisAlignment',
          selectIndex: widget.attr.mainAxisAlignment.index,
          data: MainAxisAlignment.values,
          calcFun: (MainAxisAlignment data) => data.name,
          onSelect: (MainAxisAlignment value) {
            widget.onAttrChange(widget.attr.copyWith(mainAxisAlignment: value));
          },
        ),
        ItemSelector<MainAxisSize>(
          label: '主轴尺寸:',
          subTitle: 'mainAxisSize',
          selectIndex: widget.attr.mainAxisSize.index,
          data: MainAxisSize.values,
          calcFun: (MainAxisSize data) => data.name,
          onSelect: (MainAxisSize value) {
            widget.onAttrChange(widget.attr.copyWith(mainAxisSize: value));
          },
        ),
        ItemSelector<CrossAxisAlignment>(
          label: '叉轴对齐:',
          subTitle: 'crossAxisAlignment',
          selectIndex: widget.attr.crossAxisAlignment.index,
          data: CrossAxisAlignment.values,
          calcFun: (CrossAxisAlignment data) => data.name,
          onSelect: (CrossAxisAlignment value) {
            widget.onAttrChange(widget.attr.copyWith(crossAxisAlignment: value));
          },
        ),
        ItemSelector<VerticalDirection>(
          label: '垂直方向:',
          subTitle: 'verticalDirection',
          selectIndex: widget.attr.verticalDirection.index,
          data: VerticalDirection.values,
          calcFun: (VerticalDirection data) => data.name,
          onSelect: (VerticalDirection value) {
            widget.onAttrChange(widget.attr.copyWith(verticalDirection: value));
          },
        ),
        ItemSelector<TextDirection>(
          label: '文字方向:',
          subTitle: 'textDirection',
          selectIndex: widget.attr.textDirection.index,
          data: TextDirection.values,
          calcFun: (TextDirection data) => data.name,
          onSelect: (TextDirection value) {
            widget.onAttrChange(widget.attr.copyWith(textDirection: value));
          },
        ),
        ItemSelector<TextBaseline>(
          label: '文字基线:',
          subTitle: 'textBaseline',
          selectIndex: widget.attr.textBaseline.index,
          data: TextBaseline.values,
          calcFun: (TextBaseline data) => data.name,
          onSelect: (TextBaseline value) {
            widget.onAttrChange(widget.attr.copyWith(textBaseline: value));
          },
        ),
      ],
    );
  }

  void _handleAdd() {
    final double? width = double.tryParse(_widthCtrl.text);
    final double? height = double.tryParse(_heightCtrl.text);
    if (width == null || height == null) {
      $message.warning(message: '请输入合法宽高数字!');
      return;
    }
    widget.onAddBox(Size(width, height));
  }

  @override
  void dispose() {
    _widthCtrl.dispose();
    _heightCtrl.dispose();
    super.dispose();
  }
}
