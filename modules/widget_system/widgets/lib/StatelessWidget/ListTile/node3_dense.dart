import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 16,
//      "priority": 3,
//      "name": "ListTile的密排属性",
//      "subtitle": "【dense】: 是否密排   【bool】",
//    }
class DenseListTile extends StatefulWidget {
  const DenseListTile({Key? key}) : super(key: key);

  @override
  _DenseListTileState createState() => _DenseListTileState();
}

class _DenseListTileState extends State<DenseListTile> {
  bool _dense = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      color: Colors.grey.withAlpha(22),
      child: ListTile(
        leading: Image.asset("assets/images/icon_head.webp"),
        title: const Text("以梦为马"),
        subtitle: const Text("海子"),
        selected: false,
        contentPadding: const EdgeInsets.all(5),
        trailing: const Icon(Icons.more_vert),
        dense: _dense,
        onTap: () => setState(() => _dense = !_dense),
      ),
    );
  }
}
