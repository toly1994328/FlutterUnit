
import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 111,
//      "name": 'AlignTransition基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【alignment】 : 对齐动画   【Animation<AlignmentGeometry>】",
//    }
class CustomAlignTransition extends StatefulWidget {
  const CustomAlignTransition({Key? key}) : super(key: key);

  @override
  _CustomAlignTransitionState createState() => _CustomAlignTransitionState();
}

class _CustomAlignTransitionState extends State<CustomAlignTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
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
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.withAlpha(33),
          height: 100,
          child: AlignTransition(
            alignment: AlignmentTween(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).animate(_ctrl),
            child: const Icon(
              Icons.android,
              color: Colors.green,
              size: 60,
            ),
          ),
        ));
  }
}
