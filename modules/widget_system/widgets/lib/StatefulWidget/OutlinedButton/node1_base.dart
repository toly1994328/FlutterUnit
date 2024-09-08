import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 355 OutlinedButton Material风格的边线按钮，表现和OutlineButton类似。可通过样式更改边框、颜色、阴影等属性。
//    {
//      "widgetId": 355,
//      "name": 'OutlinedButton基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 是否具有滚动主体   【Widget】\n"
//          "【onPressed】 : 点击事件   【VoidCallback】\n"
//          "【onLongPress】 : 长按事件   【VoidCallback】",
//    }

class OutlinedButtonDemo extends StatelessWidget {
  const OutlinedButtonDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 60,
        child: Wrap(
          spacing: 20,
          children: [
            OutlinedButton(
              child: const Text('OutlinedButton'),
              onPressed: _onPressed,
              onLongPress: _onLongPress,
            ),
            const OutlinedButton(
              child: Text('禁用按钮'),
              onPressed: null,
              onLongPress: null,
            ),
          ],
        ));
  }

  void _onPressed() {}

  void _onLongPress() {}
}
