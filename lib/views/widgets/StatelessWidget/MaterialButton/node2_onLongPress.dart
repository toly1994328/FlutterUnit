import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 23,
//      "priority": 2,
//      "name": "MaterialButton长按事件",
//      "subtitle": "【highlightColor】: 长按高亮色   【Color】\n"
//          "【onLongPress】: 长按事件   【Function】",
//    }

class LongPressMaterialButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        height: 40,
        elevation: 5,
        color: Colors.blue,
        highlightColor: Colors.green,
        textColor: Colors.white,
        padding: EdgeInsets.all(8),
        child: Text("MaterialButton"),
        onLongPress: () =>  Navigator.of(context).pushNamed('AboutMePage'),
        onPressed: () => Navigator.of(context).pushNamed('AboutMePage'));
  }
}