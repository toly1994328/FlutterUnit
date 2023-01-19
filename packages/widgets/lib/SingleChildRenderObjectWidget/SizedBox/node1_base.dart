import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 76,
//      "name": 'SizedBox基本使用',
//      "priority": 1,
//      "subtitle": "【child】 : 孩子组件   【Widget】\n"
//          "【width】 : 宽   【double】\n"
//          "【height】 : 高   【double】",
//    }
class CustomSizedBox extends StatelessWidget {
  const CustomSizedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      alignment: Alignment.center,
      color: Colors.cyanAccent,
      width: 50,
      height: 50,
      child: const Text("Static"),
    );

    Widget box = SizedBox(
      width: 80,
      height: 40,
      child: Container(
          color: Colors.orange,
          child: const Icon(
            Icons.android,
            color: Colors.white,
          )),
    );

    return Container(
      color: Colors.grey.withAlpha(22),
      width: 200,
      height: 100,
      child: Row(
        children: <Widget>[child, box, child],
      ),
    );
  }
}
