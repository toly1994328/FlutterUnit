/// create by 张风捷特烈 on 2020-03-24
/// contact me by email 1981462002@qq.com
/// 说明:
///
//    {
//      "widgetId": 24,
//      "priority": 1,
//      "name": "CupertinoButton点击事件",
//      "subtitle": "【color】: 颜色   【Color】\n"
//          "【pressedOpacity】: 按下时透明度   【double】\n"
//          "【child】: 子组件   【Widget】\n"
//          "【padding】: 内边距   【EdgeInsetsGeometry】\n"
//          "【borderRadius】: 圆角半径   【BorderRadius】\n"
//          "【onPressed】: 点击事件   【Function】",
//    }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoButton extends StatelessWidget {
  CustomCupertinoButton({Key? key}) : super(key: key);

  final Map<Color,double> data = {
    CupertinoColors.activeBlue:4.0,
    Colors.blue:6.0,
    CupertinoColors.activeOrange:8.0,
  };


  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      children:data.keys.map((e)=> CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => Navigator.of(context).pushNamed('AboutMePage'),
        color: e,
        pressedOpacity: 0.4,
        borderRadius:  BorderRadius.all(Radius.circular(data[e]!)),
        child: const Text("iOS"),
      )).toList()
    );
  }
}

