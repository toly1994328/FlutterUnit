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
  const RichTextWithWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'hello ',
        style: const TextStyle(color: Colors.black, fontSize: 18),
        children: <InlineSpan>[
          WidgetSpan(
              child: Image.asset(
                'assets/images/icon_head.webp',
                width: 30,
              ),
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.ideographic),
          const TextSpan(
            text: ' , welcome to ',
            style: TextStyle(color: Colors.blue, fontSize: 18),
          ),
          const WidgetSpan(
              child: FlutterLogo(),
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.ideographic),
          const TextSpan(
            text: ' .\n',
          ),
          const TextSpan(
            text: 'focus me on ',
            style: TextStyle(color: Colors.orange, fontSize: 16),
          ),
          const TextSpan(
            text: 'https://github.com/toly1994328',
            style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                decoration: TextDecoration.underline),
          ),
          const TextSpan(
            text: ' .\n',
          ),
        ],
      ),
    );
  }
}
