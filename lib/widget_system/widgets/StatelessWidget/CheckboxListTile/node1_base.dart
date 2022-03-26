
/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 17,
//      "priority": 1,
//      "name": "CheckBoxListTile的基本表现如下",
//      "subtitle": "【secondary】: 左侧组件   【Widget】\n"
//          "【checkColor】: ✔️颜色   【Color】\n"
//          "【activeColor】: 选中时外框颜色   【Color】\n"
//          "【title】: 中间上组件   【Widget】\n"
//          "【subtitle】: 中间下组件   【Widget】\n"
//          "【onChanged】: 选中事件   【Function(bool)】",
//    }
import 'package:flutter/material.dart';

class CustomCheckBoxListTile extends StatefulWidget {
  const CustomCheckBoxListTile({Key? key}) : super(key: key);

  @override
  _CustomCheckBoxListTileState createState() => _CustomCheckBoxListTileState();
}

class _CustomCheckBoxListTileState extends State<CustomCheckBoxListTile> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      color: Colors.grey.withAlpha(22),
      child: CheckboxListTile(
        value: _selected,
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