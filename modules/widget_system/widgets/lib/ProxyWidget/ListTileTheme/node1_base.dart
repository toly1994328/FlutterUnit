import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com


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
