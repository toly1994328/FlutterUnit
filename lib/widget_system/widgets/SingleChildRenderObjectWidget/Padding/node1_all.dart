import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/5/3
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 74,
//      "name": 'Padding四面等边距',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【padding】 : 内四边距   【EdgeInsetsGeometry】"
//          "EdgeInsets.all用来限定相同的四边边距",
//    }
class PaddingAll extends StatelessWidget {
  const PaddingAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withAlpha(22),
      width: 200,
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: _buildChild(),
      ),
    );
  }

  Widget _buildChild() => Container(
      alignment: Alignment.center,
      color: Colors.cyanAccent,
      width: 100,
      height: 100,
      child: const Text("孩子"),
    );
}