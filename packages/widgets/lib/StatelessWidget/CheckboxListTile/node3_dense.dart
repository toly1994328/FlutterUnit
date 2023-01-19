/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 17,
//      "priority": 3,
//      "name": "CheckBoxListTile的密排属性",
//      "subtitle": "【dense】: 是否密排   【bool】",
//    }

import 'package:flutter/material.dart';

class DenseCheckBoxListTile extends StatefulWidget {
  const DenseCheckBoxListTile({Key? key}) : super(key: key);

  @override
  _DenseCheckBoxListTileState createState() => _DenseCheckBoxListTileState();
}

class _DenseCheckBoxListTileState extends State<DenseCheckBoxListTile> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      color: Colors.grey.withAlpha(22),
      child: CheckboxListTile(
        value: _selected,
        dense: true,
        checkColor: Colors.yellow,
        activeColor: Colors.orangeAccent,
        secondary: Image.asset("assets/images/icon_head.webp"),
        title: const Text("张风捷特烈"),
        subtitle: const Text("@万花过尽知无物"),
        onChanged: (v) => setState(() => _selected = !_selected),
      ),
    );
  }
}