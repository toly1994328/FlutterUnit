import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-31
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 92,
//      "name": 'SizeTransition基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【axis】 : 轴向*2   【Axis】\n"
//          "【sizeFactor】 : 动画   【Animation<double>】",
//    }
class CustomSizeTransition extends StatefulWidget {
  const CustomSizeTransition({Key? key}) : super(key: key);

  @override
  _CustomSizeTransitionState createState() => _CustomSizeTransitionState();
}

class _CustomSizeTransitionState extends State<CustomSizeTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    _ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
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
        runSpacing: 20,
        children: <Widget>[
          SizeTransition(
            axis: Axis.horizontal,
            sizeFactor: CurvedAnimation(parent: _ctrl, curve: Curves.linear),
            child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.orange,
                child:
                    const Icon(Icons.android, color: Colors.green, size: 80)),
          ),
          SizeTransition(
            axis: Axis.vertical,
            sizeFactor: CurvedAnimation(parent: _ctrl, curve: Curves.linear),
            child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.orange,
                child:
                    const Icon(Icons.android, color: Colors.green, size: 80)),
          ),
        ],
      ),
    );
  }
}
