import 'package:flutter/material.dart';


/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 353 TextButton Material风格的文字按钮，默认只有文字，点击时有水波纹。可通过样式更改边框、颜色、阴影等属性。
//    {
//      "widgetId": 353,
//      "name": 'TextButton基本使用',
//      "priority": 1,
//      "subtitle": "【child】 : 是否具有滚动主体   【Widget】\n"
//          "【onPressed】 : 点击事件   【VoidCallback】\n"
//          "【onLongPress】 : 长按事件   【VoidCallback】",
//    }

class TextButtonDemo extends StatelessWidget {
  const TextButtonDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 60,
        child: Wrap(
          spacing: 20,
          children: [
            TextButton(
              child: const Text('TextButton 文字'),
              onPressed: _onPressed,
              onLongPress: _onLongPress,
            ),
            const TextButton(
              child: Text('TextButton 禁用'),
              onPressed: null,
              onLongPress: null,
            ),
          ],
        ));
  }

  void _onPressed() {}

  void _onLongPress() {}
}
