import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 115,
//      "name": 'RelativePositionedTransition基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【size】 : 左和上的偏移量   【Size】\n"
//          "【rect】 : 动画   【Animation<Rect>】\n"
//          "    PositionedTransition组件只能在Stack内起作用",
//    }
class CustomRelativePositionedTransition extends StatefulWidget {
  const CustomRelativePositionedTransition({Key? key}) : super(key: key);

  @override
  _CustomRelativePositionedTransitionState createState() =>
      _CustomRelativePositionedTransitionState();
}

class _CustomRelativePositionedTransitionState
    extends State<CustomRelativePositionedTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<Rect?> rectAnimation;

  @override
  void initState() {
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    rectAnimation = RectTween(
      begin: const Rect.fromLTRB(0, 0, 50, 50),
      end: const Rect.fromLTRB(0, 0, 50, 50).translate(100, 50),
    ).animate(_ctrl);
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
              RelativePositionedTransition(
                size: const Size(200, 100),
                rect: rectAnimation as Animation<Rect>,
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
