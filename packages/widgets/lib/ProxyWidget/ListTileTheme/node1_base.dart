import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com
/// 说明: 334 ListTileTheme 主要用于为后代的ListTile组件统一设置默认属性,也可以通过该组件获取默认ListTile的属性。
//    {
//      "widgetId": 334,
//      "name": "ListTileTheme基本使用",
//      "priority": 1,
//      "subtitle": "可指定ListTileThemeData数据属性为【后代】的ListTile组件设置默认样式，如样式、颜色、装饰、边距等。也可以用ListTileTheme.of获取ListTile的主题属性。",
//    }

class ListTileThemeDemo extends StatelessWidget {
  const ListTileThemeDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      dense: false,
      style: ListTileStyle.list,
      selectedColor: Colors.blue,
      contentPadding: const EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
      iconColor: Colors.purple,
      textColor: Colors.orange,
      child: _ListTileSimple(),
    );
  }
}

class _ListTileSimple extends StatefulWidget {
  @override
  _ListTileSimpleState createState() => _ListTileSimpleState();
}

class _ListTileSimpleState extends State<_ListTileSimple> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      color: Colors.grey.withAlpha(22),
      child: ListTile(
        leading: Image.asset("assets/images/icon_head.webp"),
        selected: _selected,
        title: const Text("以梦为马"),
        subtitle: const Text("海子"),
        trailing: const Icon(Icons.more_vert),
        onTap: () => setState(() => _selected = !_selected),
      ),
    );
  }
}
