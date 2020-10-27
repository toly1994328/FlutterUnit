
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 18,
//      "priority": 2,
//      "name": "SwitchListTile的选中效果",
//      "subtitle": "【selected】: 是否选中   【bool】\n"
//          "【inactiveThumbImage】: 未选中时圆圈图片   【ImageProvider】\n"
//          "【activeThumbImage】: 选中时圆圈图片   【ImageProvider】",
//    }
class SelectSwitchListTile extends StatefulWidget {
  @override
  _SelectSwitchListTileState createState() => _SelectSwitchListTileState();
}

class _SelectSwitchListTileState extends State<SelectSwitchListTile> {
  var _value=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      color: Colors.grey.withAlpha(22),
      child: SwitchListTile(
        value: _value,
        selected: _value,
        activeColor: Colors.orangeAccent,
        secondary: Image.asset("assets/images/icon_head.webp"),
        inactiveThumbImage: AssetImage("assets/images/pica.gif"),
        activeThumbImage: AssetImage("assets/images/icon_head.webp"),
        title: Text("张风捷特烈"),
        subtitle: Text("@万花过尽知无物"),
        onChanged: (v) => setState(() => _value = !_value),
      ),
    );
  }
}