
import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 90,
//      "name": 'RotationTransition基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【turns】 : 是否消失   【Animation<double>】",
//    }
class CustomRotationTransition extends StatefulWidget {
  @override
  _CustomRotationTransitionState createState() => _CustomRotationTransitionState();
}

class _CustomRotationTransitionState extends State<CustomRotationTransition> with SingleTickerProviderStateMixin{

  AnimationController _ctrl;

  @override
  void initState() {
     _ctrl= AnimationController(vsync: this,duration: Duration(seconds: 2));
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
      onTap: () {
        setState(() {
          _ctrl.reset();
          _ctrl.forward();
        });
      },
      child: Container(
        color: Colors.grey.withAlpha(22),
        width: 100,
        height: 100,
        child: RotationTransition(
          turns: CurvedAnimation(parent: _ctrl, curve: Curves.linear),
          child: Icon(Icons.android,color: Colors.green,size: 60),
        ),
      ),
    );
  }
}
