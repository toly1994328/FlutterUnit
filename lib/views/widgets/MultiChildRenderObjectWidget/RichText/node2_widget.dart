import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-30
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 101,
//      "name": 'RichText包含其他组件',
//      "priority": 2,
//      "subtitle":
//          "使用WidgetSpan来承载普通组件，作为RichText的内容",
//    }
class RichTextWithWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'hello ',
        style: TextStyle(color: Colors.black, fontSize: 18),
        children: <InlineSpan>[
          WidgetSpan(
              child: Image.asset(
                'assets/images/icon_head.png',
                width: 30,
              ),
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.ideographic),
          TextSpan(
            text: ' , welcome to ',
            style: TextStyle(color: Colors.blue, fontSize: 18),
          ),
          WidgetSpan(
              child: FlutterLogo(),
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.ideographic),
          TextSpan(
            text: ' .\n',
          ),
          TextSpan(
            text: 'focus me on ',
            style: TextStyle(color: Colors.orange, fontSize: 16),
          ),
          TextSpan(
            text: 'https://github.com/toly1994328',
            style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                decoration: TextDecoration.underline),
          ),
          TextSpan(
            text: ' .\n',
          ),
        ],
      ),
    );
  }
}
