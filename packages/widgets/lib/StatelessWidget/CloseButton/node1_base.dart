import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 32,
//      "priority": 1,
//      "name": "CloseButton点击事件",
//      "subtitle": "【onPressed】 : 点击事件  【VoidCallback?】\n"
//          "【style】: 按钮样式   【ButtonStyle?】\n"
//          "【color】: 颜色   【Color】\n"
//          "onPressed 为空时，点击时会退出当前界面。",
//    }

class CustomCloseButton extends StatelessWidget {
  const CustomCloseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CloseButton();
  }
}
