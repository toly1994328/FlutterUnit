import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com



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
