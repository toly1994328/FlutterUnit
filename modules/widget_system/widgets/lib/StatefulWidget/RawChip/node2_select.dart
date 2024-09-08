import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 153,
//      "name": 'RawChip选中和删除效果',
//      "priority": 2,
//      "subtitle":
//          "【selected】: 是否选中   【bool】\n"
//          "【deleteIconColor】: 尾部图标色   【Color】\n"
//          "【selectedColor】: 选中色   【Color】\n"
//          "【deleteIcon】: 尾部组件   【Widget】\n"
//           "【onSelected】: 选中事件   【Function(bool)】\n"
//          "【onDeleted】 : 尾部事件  【Function()】",
//    }
class SelectRawChip extends StatefulWidget {
  const SelectRawChip({Key? key}) : super(key: key);

  @override
  _SelectRawChipState createState() => _SelectRawChipState();
}

class _SelectRawChipState extends State<SelectRawChip> {
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    return RawChip(
      selected: _selected,
      padding: const EdgeInsets.all(5),
      labelPadding: const EdgeInsets.all(3),
      deleteIconColor: Colors.red,
      selectedColor: Colors.orangeAccent.withAlpha(44),
      label: const Text('张风捷特烈'),
      avatar: Image.asset("assets/images/icon_head.webp"),
      elevation: 3,
      pressElevation: 5,
      shadowColor: Colors.orangeAccent,
      onSelected: (v)=> setState(() => _selected=v),
      onDeleted: () =>  Navigator.of(context).pushNamed('AboutMePage'),
    );
  }
}