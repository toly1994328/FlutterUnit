import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com
/// 说明: 330 PopupMenuTheme 主要用于为后代的PopupMenuButton组件统一设置默认属性,也可以通过该组件获取默认PopupMenu的属性。
//    {
//      "widgetId": 330,
//      "name": "PopupMenuTheme基本使用",
//      "priority": 1,
//      "subtitle": "可指定PopupMenuThemeData数据属性为【后代】的PopupMenuButton组件设置默认样式，如形状、影深、颜色、文字样式等。也可以用PopupMenuTheme.of获取PopupMenu的主题数据。",
//    }
class PopupMenuThemeDemo extends StatelessWidget {
  const PopupMenuThemeDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuTheme(
      data: PopupMenuTheme.of(context).copyWith(
        color: Colors.orangeAccent,
        elevation: 1,
        textStyle:  const TextStyle(color: Colors.white),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            )),
      ),
      child: _PopupMenuButtonSimple(),
    );
  }
}

class _PopupMenuButtonSimple extends StatefulWidget {
  @override
  _PopupMenuButtonSimpleState createState() => _PopupMenuButtonSimpleState();
}

class _PopupMenuButtonSimpleState extends State<_PopupMenuButtonSimple> {
  final Map<String,IconData> map = {
    "关于": Icons.info_outline,
    "帮助": Icons.help_outline,
    "反馈": Icons.add_comment,
  };

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (context) => buildItems(),
      offset: const Offset(0, 50),
      onSelected: print,
      onCanceled: () => print('onCanceled'),
    );
  }

  List<PopupMenuItem<String>> buildItems() {
    return map.keys
        .toList()
        .map((e) => PopupMenuItem<String>(
        value: e,
        child: Wrap(
          spacing: 6,
          children: <Widget>[
            Icon(
              map[e],
            ),
            Text(e),
          ],
        )))
        .toList();
  }
}