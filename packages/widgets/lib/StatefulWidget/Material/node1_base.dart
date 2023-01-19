import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 160,
//      "name": 'Material基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 子组件   【Widget】\n"
//          "【type】 : 类型   【MaterialType】\n"
//          "【elevation】 : 影深   【double】\n"
//          "【shadowColor】 : 阴影颜色   【Color】\n"
//          "【color】 : 颜色   【Color】",
//    }
class CustomMaterial extends StatelessWidget {
  const CustomMaterial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 10,
        runSpacing: 10,
        children: MaterialType.values.map((e) => _buildMaterial(e)).toList());
  }

  Material _buildMaterial(MaterialType type) => Material(
        shadowColor: Colors.blue,
        type: type,
        color: Colors.orange,
        elevation: 3,
        child: Container(
          alignment: Alignment.center,
          width: 100,
          height: 60,
          child: Text(
            type.toString().split('.')[1],
            style: const TextStyle(color: Colors.black),
          ),
        ),
      );
}
