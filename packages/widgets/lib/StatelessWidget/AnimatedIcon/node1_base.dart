import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 125,
//      "name": 'AnimatedIcon基本使用',
//      "priority": 1,
//      "subtitle":
//          "【icon】 : 动画图标数据   【AnimatedIcons】\n"
//          "【size】 : 大小  【double】\n"
//          "【color】 : 颜色  【Color】\n"
//          "【progress】 : 动画   【Animation<double>】",
//    }
class CustomAnimatedIcon extends StatefulWidget {
  const CustomAnimatedIcon({Key? key}) : super(key: key);

  @override
  _CustomAnimatedIconState createState() => _CustomAnimatedIconState();
}

class _CustomAnimatedIconState extends State<CustomAnimatedIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _ctrl.forward();
    super.initState();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _ctrl.forward(from: 0),
      child: Wrap(
        runSpacing: 30,
        children: _buildChildren(),
      ),
    );
  }

  final Map<Color, AnimatedIconData> data = {
    Colors.orange: AnimatedIcons.menu_arrow,
    Colors.blue: AnimatedIcons.ellipsis_search,
    Colors.red: AnimatedIcons.close_menu,
    Colors.green: AnimatedIcons.arrow_menu,
    Colors.cyanAccent: AnimatedIcons.play_pause,
    Colors.purple: AnimatedIcons.pause_play,
  };

  List<Widget> _buildChildren() =>
      data.keys
      .map((Color color) => AnimatedIcon(
            size: 50,
            color: color,
            icon: data[color]!,
            progress: _ctrl,
          ))
      .toList();
}
