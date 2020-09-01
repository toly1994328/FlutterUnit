import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 153,
//      "name": 'RawChip点击效果',
//      "priority": 1,
//      "subtitle":
//          "【label】: 中间组件   【Widget】\n"
//          "【padding】 : 内边距   【EdgeInsetsGeometry】\n"
//          "【labelPadding】 : label边距   【EdgeInsetsGeometry】\n"
//          "【shadowColor】: 阴影色   【Color】\n"
//          "【avatar】: 左侧组件   【Widget】\n"
//           "【elevation】: 影深   【double】\n"
//           "【pressElevation】: 点击时影深   【double】\n"
//          "【onPressed】 : 点击事件  【Function()】",
//    }
class PressRawChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RawChip(
        padding: EdgeInsets.all(5),
        labelPadding: EdgeInsets.all(3),
        label: Text('张风捷特烈'),
        avatar: Image.asset("assets/images/icon_head.webp"),
        elevation: 3,
        pressElevation: 5,
        shadowColor: Colors.orangeAccent,
        onPressed: () =>  Navigator.of(context).pushNamed('AboutMePage'),
      ),
    );
  }
}
