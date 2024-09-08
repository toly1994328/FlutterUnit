import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 62,
//      "name": 'CupertinoNavigationBar基本用法',
//      "priority": 1,
//      "subtitle":
//          "【leading】 : 左侧组件   【Widget】\n"
//          "【middle】 : 中间组件   【Widget】\n"
//          "【trailing】 : 尾部组件   【Widget】\n"
//          "【backgroundColor】 : 背景色   【Color】\n"
//          "【padding】 : 内边距   【EdgeInsetsDirectional】\n"
//          "【border】 : 边线   【Border】",
//    }
class CustomCupertinoNavigationBar extends StatelessWidget {
  const CustomCupertinoNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      leading: const Icon(
        CupertinoIcons.back,
        size: 25,
        color: Colors.blue,
      ),
      middle: const Text("风雪雅舍"),
      trailing: Image.asset(
        "assets/images/icon_head.webp",
        width: 25.0,
        height: 25.0,
      ),
      backgroundColor: const Color(0xfff1f1f1),
      padding: const EdgeInsetsDirectional.only(start: 10,end: 20),
      border: Border.all(color: Colors.transparent),
    );
  }
}
