import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com
/// 说明:
//      {
//      "widgetId": 14,
//      "priority": 1,
//      "name": "可以接受点击、删除事件",
//      "subtitle": "【onPressed】: 点击事件   【Function()】\n"
//          "【onDeleted】: 删除事件   【Function()】",
//      }

class PressInputChip extends StatefulWidget {
  const PressInputChip({Key? key}) : super(key: key);

  @override
  _PressInputChipState createState() => _PressInputChipState();
}

class _PressInputChipState extends State<PressInputChip> {
  bool _delete = false;

  @override
  Widget build(BuildContext context) {
    return InputChip(
        padding: const EdgeInsets.all(5),
        labelPadding: const EdgeInsets.all(3),
        label: Text(
            !_delete ?
            "This is a InputChip." :
            "You are clicked delete icon."),
        backgroundColor: Colors.grey.withAlpha(66),
        avatar: Image.asset("assets/images/icon_head.webp"),
        selectedColor: Colors.orangeAccent.withAlpha(88),
        selectedShadowColor: Colors.blue,
        shadowColor: Colors.orangeAccent,
        elevation: 3,
        onPressed: () =>  Navigator.of(context).pushNamed('AboutMePage'),
        onDeleted: () => setState(() => _delete = !_delete));
  }
}