import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 233 StatusTransitionWidget 状态转变组件
/// 抽象类，可以根据提供的动画器状态变化触发刷新。在 Flutter 框架层没有实现的子类，也没有使用的场景，感觉用处不是很大。
///
//    {
//      "widgetId": 233,
//      "name": 'StatusTransitionWidget 介绍',
//      "priority": 1,
//      "subtitle":
//          "【animation】 : 子组件   【Animation<double>】\n"
//          "这里自定义 ColorStatusTransitionWidget 进行使用，在动画器的状态改变时构建不同的颜色。",
//    }


class StatusTransitionWidgetDemo extends StatefulWidget {
  const StatusTransitionWidgetDemo({Key? key}) : super(key: key);

  @override
  _StatusTransitionWidgetDemoState createState() =>
      _StatusTransitionWidgetDemoState();
}

class _StatusTransitionWidgetDemoState extends State<StatusTransitionWidgetDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _ctrl.forward(from: 0);
      },
      child: ColorStatusTransitionWidget(
        anim: _ctrl,
      ),
    );
  }
}

class ColorStatusTransitionWidget extends StatusTransitionWidget {
  final Animation<double> anim;

  const ColorStatusTransitionWidget({Key? key,required this.anim})
      : super(key: key, animation: anim);

  @override
  Widget build(BuildContext context) {
    Color color = Colors.blue;
    switch (animation.status) {
      case AnimationStatus.dismissed:
        color = Colors.black;
        break;
      case AnimationStatus.forward:
        color = Colors.blue;
        break;
      case AnimationStatus.reverse:
        color = Colors.red;
        break;
      case AnimationStatus.completed:
        color = Colors.green;
        break;
    }

    return Container(
      alignment: Alignment.center,
      width: 80,
      height: 80,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Text('${animation.status}'.split('.')[1],style: const TextStyle(color: Colors.white),),
    );
  }
}
