import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2023/01/27
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 258,
//      "name": 'Badge 标签不可视',
//      "priority": 2,
//      "subtitle": "【isLabelVisible】 : 是否显示标题   【bool?】\n"
//      "该案例在点击时让标签消失",
//    }

class BadgeVisibleDemo extends StatefulWidget {
  const BadgeVisibleDemo({Key? key}) : super(key: key);

  @override
  State<BadgeVisibleDemo> createState() => _BadgeVisibleDemoState();
}

class _BadgeVisibleDemoState extends State<BadgeVisibleDemo> {

  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Badge(
        backgroundColor: Colors.red,
        label: Text('99+'),
        alignment: AlignmentDirectional(36-16,-2),
        largeSize: 14,
        smallSize: 6,
        isLabelVisible: _visible,
        child: Icon(Icons.supervised_user_circle,size: 36,),
      ),
    );
  }

  void _onTap() {
    setState(() {
      _visible = false;
    });
  }
}
