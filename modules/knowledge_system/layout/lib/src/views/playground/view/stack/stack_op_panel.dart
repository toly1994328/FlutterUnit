// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-06-29
// Contact Me:  1981462002@qq.com

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tolyui/tolyui.dart';

import '../../data/stack_attr.dart';
import '../form_item/item_selector.dart';
import '../form_item/item_size_input.dart';


class StackOpTool extends StatefulWidget {
  final ValueChanged<Size> onAddBox;
  final VoidCallback onDelete;
  final VoidCallback onReset;
  final StackAttr attr;
  final ValueChanged<StackAttr> onAttrChange;

  const StackOpTool({
    super.key,
    required this.onAddBox,
    required this.onDelete,
    required this.onReset,
    required this.attr,
    required this.onAttrChange,
  });

  @override
  State<StackOpTool> createState() => _StackOpToolState();
}

class _StackOpToolState extends State<StackOpTool> {
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
              TolyAction(child: const Icon(CupertinoIcons.add, size: 18), onTap: _handleAdd),
              TolyAction(child: const Icon(CupertinoIcons.delete, size: 16), onTap: widget.onDelete),
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
              Spacer(),
              TolyAction(child: const Icon(CupertinoIcons.refresh, size: 16), onTap: widget.onReset),

            ],
          ),
        ),
        ItemSelector<AttrAlignment>(
          label: '对齐方式:',
          subTitle: 'direction',
          selectIndex: widget.attr.alignment.index,
          data: AttrAlignment.values,
          calcFun: (AttrAlignment data) => data.name,
          onSelect: (AttrAlignment value) {
            widget.onAttrChange(widget.attr.copyWith(alignment: value));
          },
        ),
        ItemSelector<StackFit>(
          label: '适应模式:',
          subTitle: 'fit',
          selectIndex: widget.attr.fit.index,
          data: StackFit.values,
          calcFun: (StackFit data) => data.name,
          onSelect: (StackFit value) {
            widget.onAttrChange(widget.attr.copyWith(fit: value));
          },
        ),
        ItemSelector<TextDirection>(
          label: '文章方向:',
          subTitle: 'textDirection',
          selectIndex: widget.attr.textDirection.index,
          data: TextDirection.values,
          calcFun: (TextDirection data) => data.name,
          onSelect: (TextDirection value) {
            widget.onAttrChange(widget.attr.copyWith(textDirection: value));
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
