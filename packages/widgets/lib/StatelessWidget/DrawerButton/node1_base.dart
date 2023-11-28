import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2023/11/28
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 276,
//      "priority": 1,
//      "name": "DrawerButton 基本使用",
//      "subtitle": "【onPressed】 : 点击事件  【VoidCallback?】\n"
//          "【style】: 按钮样式   【ButtonStyle?】\n"
//          "onPressed 为空时，点击时会打开左抽屉。",
//    }

class DrawerButtonDemo extends StatelessWidget {
  const DrawerButtonDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  DrawerButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
        iconColor: Colors.white,
      ),
    );
  }
}
