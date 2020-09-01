
/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 17,
//      "priority": 2,
//      "name": "CheckBoxListTile的选中效果",
//      "subtitle": "【selected】: 是否选中   【bool】",
//    }
import 'package:flutter/material.dart';

class SelectCheckBoxListTile extends StatefulWidget {
  @override
  _SelectCheckBoxListTileState createState() => _SelectCheckBoxListTileState();
}

class _SelectCheckBoxListTileState extends State<SelectCheckBoxListTile> {
  var _selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      color: Colors.grey.withAlpha(22),
      child: CheckboxListTile(
        value: _selected,
        selected: _selected,
        checkColor: Colors.yellow,
        activeColor: Colors.orangeAccent,
        secondary: Image.asset("assets/images/icon_head.webp"),
        title: Text("张风捷特烈"),
        subtitle: Text("@万花过尽知无物"),
        onChanged: (v) => setState(() => _selected = !_selected),
      ),
    );
  }
}