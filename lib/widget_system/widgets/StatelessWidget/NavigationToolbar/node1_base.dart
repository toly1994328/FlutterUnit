import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/20
/// contact me by email 1981462002@qq.com
/// 说明: NavigationToolbar 214 左中右模式的通用结构组件,可指定中间组件距左侧边距及是否居中。源码在AppBar等导航条结构中有使用它。
//    {
//      "widgetId": 214,
//      "name": 'NavigationToolbar基本使用',
//      "priority": 1,
//      "subtitle": "【leading】 : 左侧组件   【Widget】\n"
//          "【middle】: 中间组件   【Widget】\n"
//          "【trailing】: 右侧组件组件   【Widget】\n"
//          "【centerMiddle】: 中间组件是否居中   【bool】\n"
//          "【middleSpacing】: 中间组件距左距离    【double】",
//    }
class NavigationToolbarDemo extends StatelessWidget {
  const NavigationToolbarDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          SizedBox(
            height: 60,
            child: NavigationToolbar(
              leading: Icon(Icons.ac_unit),
              middle: Text('middleSpacing#true'),
              middleSpacing: 20,
              centerMiddle: true,
              trailing: Icon(Icons.more_vert),
            ),
          ),
          SizedBox(
            height: 60,
            child: NavigationToolbar(
              leading: Icon(Icons.ac_unit),
              middle: Text('middleSpacing#false'),
              middleSpacing: 20,
              centerMiddle: false,
              trailing: Icon(Icons.more_vert),
            ),
          ),
        ],
    );
  }
}