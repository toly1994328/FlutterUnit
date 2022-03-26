import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 93,
//      "name": 'PositionedTransition基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【rect】 : 动画   【Animation<RelativeRect>】\n"
//          "    PositionedTransition组件只能在Stack内起作用",
//    }
class CustomPositionedTransition extends StatefulWidget {
  const CustomPositionedTransition({Key? key}) : super(key: key);

  @override
  _CustomPositionedTransitionState createState() =>
      _CustomPositionedTransitionState();
}

class _CustomPositionedTransitionState extends State<CustomPositionedTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
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
        child: Container(
          color: Colors.grey.withAlpha(33),
          width: 200,
          height: 100,
          child: Stack(
            children: <Widget>[
              PositionedTransition(
                rect: RelativeRectTween(
                  begin: const RelativeRect.fromLTRB(0, 50, 150, 100),
                  end: const RelativeRect.fromLTRB(60, 0, 150, -50),
                ).animate(_ctrl),
                child: const Icon(
                  Icons.android,
                  color: Colors.green,
                  size: 50,
                ),
              )
            ],
          ),
        ));
  }
}
