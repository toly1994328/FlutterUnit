import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:


//    {
//      "widgetId": 2,
//      "priority": 4,
//      "name": "文字对齐方式",
//      "subtitle": "【textAlign】: 对齐方式   【TextAlign】\n"
//          "下面依次是:left、right、center、justify、start、end ",
//    }
class TextAlignText extends StatelessWidget {
  const TextAlignText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: TextAlign.values
          .map((TextAlign textAlign) => Container(
        width: 120,
        color: Colors.cyanAccent.withAlpha(33),
        height: 120 * 0.618,
        child: Text(
          " 张风捷特烈 toly " * 3,
          textAlign: textAlign,
        ),
      ))
          .toList(),
    );
  }
}