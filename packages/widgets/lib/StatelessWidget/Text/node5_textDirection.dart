import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:


//    {
//      "widgetId": 2,
//      "priority": 5,
//      "name": "文字方向与最大行数",
//      "subtitle": "【maxLines】 : 最大行数  【int】\n"
//          "【textDirection】 : 文字方向  【TextDirection】\n"
//          "下面依次是:rtl、ltr ",
//    }
class TextDirectionText extends StatelessWidget {
  const TextDirectionText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 40,
      runSpacing: 10,
      children: TextDirection.values
          .map((TextDirection direction) => Container(
        width: 120,
        color: Colors.cyanAccent.withAlpha(33),
        height: 120 * 0.618,
        child: Text(
          " 张风捷特烈 toly " * 10,
          textDirection: direction,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ))
          .toList(),
    );
  }
}