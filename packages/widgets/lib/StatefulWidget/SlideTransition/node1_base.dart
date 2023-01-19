import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 112,
//      "name": 'SlideTransition 基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【textDirection】 : x轴方向  【TextDirection】\n"
//          "【position】 : 动画   【Animation<Offset>】",
//    }
class CustomSlideTransition extends StatefulWidget {
  const CustomSlideTransition({Key? key}) : super(key: key);

  @override
  _CustomSlideTransitionState createState() => _CustomSlideTransitionState();
}

class _CustomSlideTransitionState extends State<CustomSlideTransition>
    with SingleTickerProviderStateMixin {
 late AnimationController _ctrl;
 late Animation<Offset> animation;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.5, 0.5),
    ).animate(_ctrl);
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
          width: 200,
          color: Colors.grey.withAlpha(33),
          height: 100,
          child: Stack(
            fit: StackFit.expand,
            children: [
              SlideTransition(
                textDirection: TextDirection.ltr,
                position: animation,
                child: _buildChild(),
              ),
              SlideTransition(
                textDirection: TextDirection.rtl,
                position: animation,
                child: _buildChild(),
              ),
            ],
          ),
        ));
  }
  Widget _buildChild() => const Icon(
    Icons.accessible_forward_sharp,
    color: Colors.green,
    size: 25,
  );
}
