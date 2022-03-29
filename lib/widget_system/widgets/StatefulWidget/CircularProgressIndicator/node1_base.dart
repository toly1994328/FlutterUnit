import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 46,
//      "name": 'CircularProgressIndicator基本使用',
//      "priority": 1,
//      "subtitle":
//          "【value】 : 进度   【double】\n"
//          "【backgroundColor】 : 背景色   【Color】\n"
//          "【valueColor】 : 进度颜色   【Animation<Color>】\n"
//          "【strokeWidth】 : 线宽   【double】",
//    }
class CustomCircularProgressIndicator extends StatefulWidget {
  const CustomCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  _CustomCircularProgressIndicatorState createState() =>
      _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState
    extends State<CustomCircularProgressIndicator> {

  List<double?> data = [0.2,0.4,0.6,0.8,null];

  @override
  Widget build(BuildContext context) {

    return Wrap(
      spacing: 10,
      children:data.map((e)=>SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(
          value: e,
          backgroundColor: Colors.grey.withAlpha(33),
          valueColor: const AlwaysStoppedAnimation(Colors.orange),
          strokeWidth: 5,
        ),
      )).toList(),
    );
  }
}
