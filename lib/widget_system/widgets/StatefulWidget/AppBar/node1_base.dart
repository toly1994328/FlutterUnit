import 'package:flutter/material.dart';

import '../PopupMenuButton/node1_base.dart';

/// create by 张风捷特烈 on 2020-03-23
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 57,
//      "name": 'AppBar基本使用',
//      "priority": 1,
//      "subtitle":
//          "【leading】 : 左侧组件   【Widget】\n"
//          "【title】 : 中间组件   【Widget】\n"
//          "【actions】 : 右侧组件   【List<Widget>】\n"
//          "【elevation】 : 影深   【double】\n"
//          "【shape】 : 形状   【ShapeBorder】\n"
//          "【backgroundColor】 : 影深   【背景色】\n"
//          "【centerTitle】 : 中间是否居中   【bool】",
//    }

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('风雅六社'),
      leading: const BackButton(),
      backgroundColor: Colors.amber[500],
      elevation: 2,
      centerTitle: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
        topRight: Radius.circular(5),
        bottomLeft: Radius.circular(5),
      )),
      actions: <Widget>[
        IconButton(
            icon: const Icon(Icons.star),
            tooltip: 'liked_widget_bloc',
            onPressed: () {
              // do nothing
            }),
        const CustomPopupMenuButton()
      ],
    );
  }
}
