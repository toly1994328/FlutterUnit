// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-06-23
// Contact Me:  1981462002@qq.com

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tolyui/basic/basic.dart';
import 'package:tolyui/tolyui.dart';

import 'drop_selectable_widget.dart';

const List<Color> kColors = [
  Color(0xffe64032),
  Color(0xff307dee),
  Color(0xfff9c01f),
  Color(0xff309949),
];

class FlexPlayground extends StatefulWidget {
  const FlexPlayground({super.key});

  @override
  State<FlexPlayground> createState() => _FlexPlaygroundState();
}

class _FlexPlaygroundState extends State<FlexPlayground> {
  List<DisplayItem> _data = [];
  FlexAttr _attr = FlexAttr(direction: Axis.horizontal);
  int _selectIndex = -1;

  @override
  void initState() {
    super.initState();
    _data = [
      DisplayItem(width: 20, height: 20, color: kColors[0]),
      DisplayItem(width: 10, height: 80, color: kColors[1]),
      DisplayItem(width: 40, height: 30, color: kColors[2]),
      DisplayItem(width: 60, height: 20, color: kColors[3]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Center(
    child: ColoredBox(
    color: Colors.grey.withOpacity(0.1),
    child:FlexDisplay(
              items: _data,
              attr: _attr,
              selectIndex: _selectIndex,
              onSelectChanged: _onSelectChanged,
            )))),
        VerticalDivider(),
        SizedBox(
            width: 200,
            child: FlexOpTool(
              attr: _attr,
              onAddBox: _onAddBox,
              onDelete: _deleteSelectIndex,
              onAttrChange:_onAttrChange,

            )),
      ],
    );
  }

  void _onAttrChange(FlexAttr attr){
     _attr = attr;
     setState(() {
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

class FlexAttr {
  final Axis direction;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline textBaseline;

  FlexAttr({
    required this.direction,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.textDirection,
    this.textBaseline = TextBaseline.alphabetic,
    this.verticalDirection = VerticalDirection.down,
  });

  FlexAttr copyWith({
    Axis? direction,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    MainAxisSize? mainAxisSize,
    TextDirection? textDirection,
    VerticalDirection? verticalDirection,
    TextBaseline? textBaseline,
  }) =>
      FlexAttr(
        direction: direction ?? this.direction,
        mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
        mainAxisSize: mainAxisSize ?? this.mainAxisSize,
        textDirection: textDirection ?? this.textDirection,
        verticalDirection: verticalDirection ?? this.verticalDirection,
        textBaseline: textBaseline ?? this.textBaseline,
      );
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
    return  Flex(
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
              child: FlexPlayItem(
                item: items[index],
                selected: active,
              ),
            );
          }).toList(),
    );
  }
}

class FlexOpTool extends StatefulWidget {
  final ValueChanged<Size> onAddBox;
  final VoidCallback onDelete;
  final FlexAttr attr;
  final ValueChanged<FlexAttr> onAttrChange;

  const FlexOpTool({
    super.key,
    required this.onAddBox,
    required this.onDelete,
    required this.attr,
    required this.onAttrChange,
  });

  @override
  State<FlexOpTool> createState() => _FlexOpToolState();
}

class _FlexOpToolState extends State<FlexOpTool> {
  final TextEditingController widthCtrl = TextEditingController(text: '24');
  final TextEditingController heightCtrl = TextEditingController(text: '64');


  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = TextStyle(color: Color(0xff61666d), fontSize: 12);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Flex 操作面板',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
          child: Row(
            children: [
              Text('增删操作', style: labelStyle),
              Spacer(),
              TolyAction(child: Icon(CupertinoIcons.add, size: 18), onTap: _handleAdd),
              TolyAction(child: Icon(CupertinoIcons.delete, size: 16), onTap: widget.onDelete),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          child: Row(
            children: [
              Text('宽高: ', style: labelStyle),
              SizedBox(width: 20),
              Expanded(
                child: GridSizeSetting(
                  widthCtrl: widthCtrl,
                  heightCtrl: heightCtrl,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
          child: Row(
            children: [
              Text('属性操作', style: labelStyle),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('排列方向:', style: labelStyle),
                  Text('direction', style: labelStyle.copyWith(fontSize: 8)),
                ],
              ),
              Spacer(),
              TolySelect(
                fontSize: 11,
                data: Axis.values.map((e) => e.name).toList(),
                selectIndex: widget.attr.direction.index,

                iconSize: 16,
                height: 25,
                width: 100,
                onSelected: (int index) async {
                  Axis axis = Axis.values[index];
                  widget.onAttrChange(widget.attr.copyWith(direction: axis));
                },
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('主轴对齐:', style: labelStyle),
                  Text('mainAxisAlignment', style: labelStyle.copyWith(fontSize: 8)),
                ],
              ),
              Spacer(),
              TolySelect(
                fontSize: 11,
                data: MainAxisAlignment.values.map((e) => e.name).toList(),
                selectIndex: widget.attr.mainAxisAlignment.index,
                iconSize: 16,
                height: 25,
                width: 100,
                onSelected: (int index) async {
                  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.values[index];
                  widget.onAttrChange(widget.attr.copyWith(mainAxisAlignment: mainAxisAlignment));
                },
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('主轴尺寸:', style: labelStyle),
                  Text('mainAxisSize', style: labelStyle.copyWith(fontSize: 8)),
                ],
              ),
              Spacer(),
              TolySelect(
                fontSize: 11,
                selectIndex: widget.attr.mainAxisSize.index,
                data: MainAxisSize.values.map((e) => e.name).toList(),
                iconSize: 16,
                height: 25,
                width: 100,
                onSelected: (int index) async {
                  MainAxisSize mainAxisSize = MainAxisSize.values[index];
                  widget.onAttrChange(widget.attr.copyWith(mainAxisSize: mainAxisSize));
                },
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('叉轴对齐:', style: labelStyle),
                  Text('crossAxisAlignment', style: labelStyle.copyWith(fontSize: 8)),
                ],
              ),
              Spacer(),
              TolySelect(
                fontSize: 11,
                selectIndex: widget.attr.crossAxisAlignment.index,

                data: CrossAxisAlignment.values.map((e) => e.name).toList(),
                iconSize: 16,
                height: 25,
                width: 100,
                onSelected: (int index) async {
                  CrossAxisAlignment value = CrossAxisAlignment.values[index];
                  widget.onAttrChange(widget.attr.copyWith(crossAxisAlignment: value));
                },
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('垂直方向:', style: labelStyle),
                  Text('verticalDirection', style: labelStyle.copyWith(fontSize: 8)),
                ],
              ),
              Spacer(),
              TolySelect(
                fontSize: 11,
                data: VerticalDirection.values.map((e) => e.name).toList(),
                selectIndex: widget.attr.verticalDirection.index,
                iconSize: 16,
                height: 25,
                width: 100,
                onSelected: (int index) async {
                  VerticalDirection verticalDirection = VerticalDirection.values[index];
                  widget.onAttrChange(widget.attr.copyWith(verticalDirection: verticalDirection));
                },
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('文字方向:', style: labelStyle),
                  Text('textDirection', style: labelStyle.copyWith(fontSize: 8)),
                ],
              ),
              Spacer(),
              TolySelect(
                fontSize: 11,
                selectIndex: widget.attr.textDirection?.index??0,
                data: TextDirection.values.map((e) => e.name).toList(),
                iconSize: 16,
                height: 25,
                width: 100,
                onSelected: (int index) async {
                  TextDirection textDirection = TextDirection.values[index];
                  widget.onAttrChange(widget.attr.copyWith(textDirection: textDirection));
                },
              )
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('文字基线:', style: labelStyle),
                  Text('textBaseline', style: labelStyle.copyWith(fontSize: 8)),
                ],
              ),
              Spacer(),
              TolySelect(
                fontSize: 11,
                data: TextBaseline.values.map((e) => e.name).toList(),
                selectIndex: widget.attr.textBaseline.index,
                iconSize: 16,
                height: 25,
                width: 100,
                onSelected: (int index) async {
                  TextBaseline value = TextBaseline.values[index];
                  widget.onAttrChange(widget.attr.copyWith(textBaseline: value));
                },
              )
            ],
          ),
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

class FlexPlayItem extends StatefulWidget {
  final DisplayItem item;
  final bool selected;
  const FlexPlayItem({
    super.key,
    required this.item,
    required this.selected,
  });

  @override
  State<FlexPlayItem> createState() => _FlexPlayItemState();
}

class _FlexPlayItemState extends State<FlexPlayItem> {
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

class GridSetting extends StatelessWidget {
  const GridSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class GridSizeSetting extends StatelessWidget {
  final TextEditingController widthCtrl;
  final TextEditingController heightCtrl;
  const GridSizeSetting({
    super.key,
    required this.widthCtrl,
    required this.heightCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CupertinoTextField(
          controller: widthCtrl,
          onChanged: (v) {
            // logic.updateRow(v);
          },
          style: TextStyle(fontSize: 12),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            "x",
            style: TextStyle(fontSize: 12),
          ),
        ),
        Expanded(
            child: CupertinoTextField(
          controller: heightCtrl,
          style: TextStyle(fontSize: 12),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ))
      ],
    );
  }
}
