import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com
/// 说明:

//     {
//      "widgetId": 20,
//      "priority": 1,
//      "name": "GridTileBar的基本表现如下",
//      "subtitle": "【leading】: 左侧组件   【Widget】\n"
//          "【trailing】: 尾组件   【Widget】\n"
//          "【title】: 中间上组件   【Widget】\n"
//          "【subtitle】: 中间下组件   【Widget】\n"
//          "【backgroundColor】: 背景色   【Color】",
//      }


class CustomGridTileBar extends StatelessWidget {
  const CustomGridTileBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTileBar(
      backgroundColor: Colors.blue.withAlpha(120),
      trailing: const Icon(Icons.star, color: Colors.red),
      leading: const CircleAvatar(
        backgroundImage: AssetImage("assets/images/wy_200x300.webp"),
      ),
      title: const Text("百里·巫缨"),
      subtitle: const Text("倾国必倾城"),
    );
  }
}
