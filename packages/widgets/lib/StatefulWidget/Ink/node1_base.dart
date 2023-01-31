import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 152,
//      "name": 'Ink基本使用',
//      "priority": 1,
//      "subtitle": "【child】 : 子组件   【Widget】\n"
//          "【padding】 : 内边距   【EdgeInsetsGeometry】\n"
//          "【decoration】 : 装饰   【Decoration】\n"
//          "【width】 : 宽   【double】\n"
//          "【height】 : 高   【double】\n"
//          "【color】 : 颜色   【Color】",
//    }
class CustomInk extends StatelessWidget {
  const CustomInk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.orangeAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Ink(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            width: 200.0,
            height: 100.0,
            child: InkWell(
              onTap: () {},
              child: const Center(child: Text('Hello')),
            ),
          ),
        ),
      ),
    );
  }
}

