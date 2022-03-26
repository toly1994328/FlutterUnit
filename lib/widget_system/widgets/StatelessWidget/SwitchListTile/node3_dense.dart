
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 18,
//      "priority": 3,
//      "name": "SwitchListTile的密排属性",
//      "subtitle": "【dense】: 是否密排   【bool】",
//    }
class DenseSwitchListTile extends StatefulWidget {
  const DenseSwitchListTile({Key? key}) : super(key: key);

  @override
  _DenseSwitchListTileState createState() => _DenseSwitchListTileState();
}

class _DenseSwitchListTileState extends State<DenseSwitchListTile> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      color: Colors.grey.withAlpha(22),
      child: SwitchListTile(
        value: _value,
        dense: true,
        selected: _value,
        activeColor: Colors.orangeAccent,
        secondary: Image.asset("assets/images/icon_head.webp"),
        title: const Text("张风捷特烈"),
        subtitle: const Text("@万花过尽知无物"),
        onChanged: (v) => setState(() => _value = !_value),
      ),
    );
  }
}