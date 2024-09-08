// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-06-29
// Contact Me:  1981462002@qq.com

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:layout/src/views/playground/view/form_item/value_input.dart';
import 'package:tolyui/tolyui.dart';

import '../../data/wrap_attr.dart';
import '../form_item/item_selector.dart';
import '../form_item/item_size_input.dart';

class WrapOpTool extends StatefulWidget {
  final ValueChanged<Size> onAddBox;
  final VoidCallback onDelete;
  final WrapAttr attr;
  final ValueChanged<WrapAttr> onAttrChange;
  final VoidCallback onReset;

  const WrapOpTool({
    super.key,
    required this.onAddBox,
    required this.onDelete,
    required this.onReset,
    required this.attr,
    required this.onAttrChange,
  });

  @override
  State<WrapOpTool> createState() => _WrapOpToolState();
}

class _WrapOpToolState extends State<WrapOpTool> {
  final TextEditingController widthCtrl = TextEditingController(text: '24');
  final TextEditingController heightCtrl = TextEditingController(text: '64');
  final TextEditingController spacingCtrl = TextEditingController(text: "0");
  final TextEditingController rubSpacingCtrl = TextEditingController(text: "0");

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = TextStyle(color: Color(0xff61666d), fontSize: 12);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Wrap 操作面板',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
          child: Row(
            children: [
              Text('增删操作', style: labelStyle.copyWith(fontWeight: FontWeight.bold)),
              Spacer(),
              TolyAction(child: Icon(CupertinoIcons.add, size: 18), onTap: _handleAdd),
              TolyAction(child: Icon(CupertinoIcons.delete, size: 16), onTap: widget.onDelete),
            ],
          ),
        ),
        ItemSizeInput(
          widthCtrl: widthCtrl,
          heightCtrl: heightCtrl,
        ),
        const SizedBox(height: 12),
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
          child: Row(
            children: [
              Text('属性操作', style: labelStyle.copyWith(fontWeight: FontWeight.bold)),
              Spacer(),
              TolyAction(
                  child: const Icon(CupertinoIcons.refresh, size: 16), onTap: widget.onReset),
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
        ItemSelector<WrapAlignment>(
          label: '主轴对齐:',
          subTitle: 'mainAlignment',
          selectIndex: widget.attr.mainAlignment.index,
          data: WrapAlignment.values,
          calcFun: (WrapAlignment data) => data.name,
          onSelect: (WrapAlignment value) {
            widget.onAttrChange(widget.attr.copyWith(mainAlignment: value));
          },
        ),
        ItemSelector<WrapCrossAlignment>(
          label: '交叉轴对齐:',
          subTitle: 'crossAxisAlignment',
          selectIndex: widget.attr.crossAxisAlignment.index,
          data: WrapCrossAlignment.values,
          calcFun: (WrapCrossAlignment data) => data.name,
          onSelect: (WrapCrossAlignment value) {
            widget.onAttrChange(widget.attr.copyWith(crossAxisAlignment: value));
          },
        ),
        ItemSelector<WrapAlignment>(
          label: '叉轴对齐:',
          subTitle: 'runAlignment',
          selectIndex: widget.attr.runAlignment.index,
          data: WrapAlignment.values,
          calcFun: (WrapAlignment data) => data.name,
          onSelect: (WrapAlignment value) {
            widget.onAttrChange(widget.attr.copyWith(runAlignment: value));
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
        ValueInput(
          label: '主轴间距:',
          subtitle: 'spacing',
          onChange: (String v) {
            widget.onAttrChange(widget.attr.copyWith(spacing: double.tryParse(v)));
          },
        ),
        ValueInput(
          label: '叉轴间距:',
          subtitle: 'runSpacing',
          onChange: (String v) {
            widget.onAttrChange(widget.attr.copyWith(runSpacing: double.parse(v)));
          },
        ),
      ],
    );
  }

  void _handleAdd() {
    final double? width = double.tryParse(widthCtrl.text);
    final double? height = double.tryParse(heightCtrl.text);
    if (width == null || height == null) {
      $message.warning(message: '请输入合法宽高数字!');
      return;
    }
    widget.onAddBox(Size(width, height));
  }
}
