import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 47,
//      "name": 'LinearProgressIndicator基本使用',
//      "priority": 1,
//      "subtitle":
//          "【value】 : 进度   【double】\n"
//          "【backgroundColor】 : 背景色   【Color】\n"
//          "【valueColor】 : 进度颜色   【Animation<Color>】\n"
//          "    value为null时会不停循环",
//    }
class CustomLinearProgressIndicator extends StatefulWidget {
  const CustomLinearProgressIndicator({Key? key}) : super(key: key);

  @override
  _CustomLinearProgressIndicatorState createState() =>
      _CustomLinearProgressIndicatorState();
}

class _CustomLinearProgressIndicatorState
    extends State<CustomLinearProgressIndicator> {
  List<double?> data = [0.2, 0.4, 0.6, 0.8, null];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: data
          .map((e) => SizedBox(
        width: 50,
        height: 3,
        child:LinearProgressIndicator(
          value: e,
          backgroundColor: Colors.grey.withAlpha(33),
          valueColor: const AlwaysStoppedAnimation(Colors.orange),
        ),
      ))
          .toList(),
    );
  }
}
