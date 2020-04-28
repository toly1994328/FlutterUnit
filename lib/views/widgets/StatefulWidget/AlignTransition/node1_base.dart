import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//    {
//      "widgetId": 111,
//      "name": 'AlignTransition基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【alignment】 : 对齐动画   【Animation<AlignmentGeometry>】",
//    }
class CustomAlignTransition extends StatefulWidget {
  @override
  _CustomAlignTransitionState createState() => _CustomAlignTransitionState();
}

class _CustomAlignTransitionState extends State<CustomAlignTransition>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrl;

  @override
  void initState() {
    _ctrl = AnimationController(vsync: this, duration: Duration(seconds: 1));
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
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.withAlpha(33),
          height: 100,
          child: AlignTransition(
            alignment: AlignmentTween(
                    begin: Alignment.topLeft, end: Alignment.bottomRight)
                .animate(_ctrl),
            child: Container(
                child: Icon(Icons.android, color: Colors.green, size: 60)),
          ),
        ));
  }
}
