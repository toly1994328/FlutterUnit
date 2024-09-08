import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 18,
//      "priority": 1,
//      "name": "SwitchListTile的基本表现如下",
//      "subtitle": "【secondary】: 左侧组件   【Widget】\n"
//          "【title】: 中间上组件   【Widget】\n"
//          "【subtitle】: 中间下组件   【Widget】\n"
//          "【inactiveThumbColor】: 未选中时圆圈颜色   【Color】\n"
//          "【inactiveTrackColor】: 未选中滑槽颜色   【Color】\n"
//          "【activeColor】: 选中时圆圈颜色   【Color】\n"
//          "【activeTrackColor】: 选中滑槽颜色   【Color】\n"
//          "【onChanged】: 选中事件   【Function(bool)】",
//    }
class CustomSwitchListTile extends StatefulWidget {
  const CustomSwitchListTile({Key? key}) : super(key: key);

  @override
  _CustomSwitchListTileState createState() => _CustomSwitchListTileState();
}

class _CustomSwitchListTileState extends State<CustomSwitchListTile> {
  var _value=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      color: Colors.grey.withAlpha(22),
      child: SwitchListTile(
        value: _value,
        inactiveThumbColor:Colors.cyanAccent ,
        inactiveTrackColor: Colors.blue.withAlpha(88),
        activeColor: Colors.orangeAccent,
        activeTrackColor: Colors.orange,
        secondary: Image.asset("assets/images/icon_head.webp"),
        title: const Text("张风捷特烈"),
        subtitle: const Text("@万花过尽知无物"),
        onChanged: (v) => setState(() => _value = !_value),
      ),
    );
  }
}
