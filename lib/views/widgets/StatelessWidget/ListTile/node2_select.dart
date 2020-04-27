import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 16,
//      "priority": 2,
//      "name": "ListTile选中效果和长按事件",
//      "subtitle": "【selected】: 是否选中   【bool】\n"
//          "【onTap】: 点击事件   【Function()】",
//    }
class SelectListTile extends StatefulWidget {
  @override
  _SelectListTileState createState() => _SelectListTileState();
}

class _SelectListTileState extends State<SelectListTile> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      color: Colors.grey.withAlpha(22),
      child: ListTile(
        leading: Image.asset("assets/images/icon_head.png"),
        selected: _selected,
        title: Text("以梦为马"),
        subtitle: Text("海子"),
        contentPadding: EdgeInsets.all(5),
        trailing: Icon(Icons.more_vert),
        onTap: () => setState(() => _selected = !_selected),
      ),
    );
  }
}