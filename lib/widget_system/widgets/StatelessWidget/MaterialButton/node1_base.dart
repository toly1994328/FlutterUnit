import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 23,
//      "priority": 1,
//      "name": "MaterialButton点击事件",
//      "subtitle": "【color】: 颜色   【Color】\n"
//          "【splashColor】: 水波纹颜色   【Color】\n"
//          "【height】: 高   【double】\n"
//          "【elevation】: 影深   【double】\n"
//          "【child】: 子组件   【Widget】\n"
//          "【textColor】: 子组件文字颜色   【Color】\n"
//          "【highlightColor】: 长按高亮色   【Color】\n"
//          "【padding】: 内边距   【EdgeInsetsGeometry】\n"
//          "【onPressed】: 点击事件   【Function】",
//    }

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        height: 40,
        elevation: 5,
        color: Colors.orangeAccent,
        textColor: Colors.white,
        splashColor: Colors.blue,
        padding: const EdgeInsets.all(8),
        child: const Text("MaterialButton"),
        onPressed: () => Navigator.of(context).pushNamed('AboutMePage'));
  }
}