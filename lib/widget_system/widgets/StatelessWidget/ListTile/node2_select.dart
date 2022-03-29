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
  const SelectListTile({Key? key}) : super(key: key);

  @override
  _SelectListTileState createState() => _SelectListTileState();
}

class _SelectListTileState extends State<SelectListTile> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      color: Colors.grey.withAlpha(22),
      child: ListTile(
        leading: Image.asset("assets/images/icon_head.webp"),
        selected: _selected,
        title: const Text("以梦为马"),
        subtitle: const Text("海子"),
        contentPadding: const EdgeInsets.all(5),
        trailing: const Icon(Icons.more_vert),
        onTap: () => setState(() => _selected = !_selected),
      ),
    );
  }
}