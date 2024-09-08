import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 353,
//      "name": 'TextButton样式',
//      "priority": 2,
//      "subtitle": "【style】 : 按钮样式   【ButtonStyle】\n"
//          "【focusNode】 : 焦点   【FocusNode】\n"
//          "【clipBehavior】 : 裁剪行为   【Clip】\n"
//          "【autofocus】 : 自动聚焦   【bool】",
//    }

class TextButtonStyleDemo extends StatelessWidget {
  const TextButtonStyleDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Wrap(
        spacing: 10,
        children: [
          TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                foregroundColor: Colors.white,
                elevation: 2,
                shadowColor: Colors.orangeAccent),
            child: const Text('TextButton 样式'),
            onPressed: _onPressed,
            onLongPress: _onLongPress,
          ),
          TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                side: const BorderSide(color: Colors.blue, width: 1),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                // elevation: 2,
                shadowColor: Colors.orangeAccent),
            child: const Text('TextButton 边线'),
            autofocus: false,
            onPressed: _onPressed,
            onLongPress: _onLongPress,
          ),
        ],
      ),
    );
  }

  void _onPressed() {}

  void _onLongPress() {}
}
