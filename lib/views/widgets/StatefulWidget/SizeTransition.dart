import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//    {
//      "widgetId": 92,
//      "name": 'FadeTransition基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【axis】 : 轴向*2   【Axis】\n"
//          "【sizeFactor】 : 动画   【Animation<double>】",
//    }
class CustomSizeTransition extends StatefulWidget {
  @override
  _CustomSizeTransitionState createState() => _CustomSizeTransitionState();
}

class _CustomSizeTransitionState extends State<CustomSizeTransition>
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
      child: Wrap(
        runSpacing: 20,
        children: <Widget>[
          SizeTransition(
            axis: Axis.horizontal,
            sizeFactor: CurvedAnimation(parent: _ctrl, curve: Curves.linear),
            child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.orange,
                child: Icon(Icons.android, color: Colors.green, size: 80)),
          ),
          SizeTransition(
            axis: Axis.vertical,
            sizeFactor: CurvedAnimation(parent: _ctrl, curve: Curves.linear),
            child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.orange,
                child: Icon(Icons.android, color: Colors.green, size: 80)),
          ),
        ],
      ),
    );
  }
}
