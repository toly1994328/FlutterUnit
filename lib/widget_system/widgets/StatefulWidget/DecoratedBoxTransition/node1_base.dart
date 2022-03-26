import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 113,
//      "name": 'DecoratedBoxTransition基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【position】 : 前/背景色  【DecorationPosition】\n"
//          "【decoration】 : 动画   【Animation<Decoration>】",
//    }
class CustomDecoratedBoxTransition extends StatefulWidget {
  const CustomDecoratedBoxTransition({Key? key}) : super(key: key);

  @override
  _CustomDecoratedBoxTransitionState createState() =>
      _CustomDecoratedBoxTransitionState();
}

class _CustomDecoratedBoxTransitionState
    extends State<CustomDecoratedBoxTransition>
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
        onTap: () => _ctrl.forward(from:  0),
        child: SizedBox(
          width: 200,
          height: 100,
          child: DecoratedBoxTransition(
            position: DecorationPosition.background,
            decoration: DecorationTween(
                begin: const BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(1, 1),
                          color: Colors.purple,
                          blurRadius: 3,
                          spreadRadius: 1)
                    ]),
                end: const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(1, 1),
                          color: Colors.blue,
                          blurRadius: 1,
                          spreadRadius: 0)
                    ])).animate(_ctrl),
            child: const Icon(Icons.android, color: Colors.white, size: 60),
          ),
        ));
  }
}
