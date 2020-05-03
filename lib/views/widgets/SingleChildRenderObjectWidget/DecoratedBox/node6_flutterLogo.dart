import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com
/// 说明: 
//    {
//      "widgetId": 70,
//      "name": 'FlutterLogoDecoration装饰',
//      "priority": 6,
//      "subtitle": "通过FlutterLogoDecoration对象可指定Flutter图标装饰(并没有什么太大的作用)\n",
//    }

class FlutterLogoDecorationDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: FlutterLogoDecoration(
          darkColor: Colors.orange,
          lightColor: Colors.deepPurpleAccent,
          style: FlutterLogoStyle.stacked),
      child: SizedBox(
        width: 100,
        height: 100,
      ),
    );
  }
}
