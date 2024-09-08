import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 16,
//      "priority": 1,
//      "name": "ListTile的基本表现如下",
//      "subtitle": "【leading】: 左侧组件   【Widget】\n"
//          "【title】: 中间上组件   【Widget】\n"
//          "【subtitle】: 中间下组件   【Widget】\n"
//          "【trailing】: 尾组件   【Widget】\n"
//          "【contentPadding】: 内边距   【EdgeInsetsGeometry】\n"
//          "【onLongPress】: 点击事件   【Function()】",
//    }
class CustomListTile extends StatelessWidget {
  const CustomListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      color: Colors.grey.withAlpha(22),
      child: ListTile(
        leading: Image.asset("assets/images/icon_head.webp"),
        title: const Text("以梦为马"),
        subtitle: const Text("海子"),
        contentPadding: const EdgeInsets.all(5),
        trailing: const Icon(Icons.more_vert),
        onLongPress: () => Navigator.of(context).pushNamed('AboutMePage'),
      ),
    );
  }
}