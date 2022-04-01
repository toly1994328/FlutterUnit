import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 287,
//      "name": 'LayoutBuilder基本认识',
//      "priority": 1,
//      "subtitle": "【builder】 : 布局构造器   【LayoutWidgetBuilder】",
//    }
class CustomLayoutBuilder extends StatelessWidget {
  const CustomLayoutBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('CustomLayoutBuild');
    return Container(
      alignment: Alignment.center,
      height: 80,
      width: 150,
      color: Colors.green,
      child: LayoutBuilder(
        builder: (_, zone) {
          return Text(
            '父容器宽:${zone.maxWidth}\n'
            '父容器高:${zone.maxHeight}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          );
        },
      ),
    );
  }
}
