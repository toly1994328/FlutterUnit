import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';

import 'anim_painter.dart';
import 'point_data.dart';

class CurveAnimShower extends StatefulWidget {
  const CurveAnimShower({Key? key}) : super(key: key);

  @override
  _CurveAnimShowerState createState() => _CurveAnimShowerState();
}

class _CurveAnimShowerState extends State<CurveAnimShower>
    with SingleTickerProviderStateMixin {
  PointData points = PointData();

  late AnimationController _ctrl;

  final Duration animDuration = const Duration(milliseconds: 1000);

  late Animation<double> curveAnim;

  Map<String, Curve> maps = {
    'bounceOut': Curves.bounceOut,
    'linear': Curves.linear,
    'decelerate': Curves.decelerate,
    'fastLinearToSlowEaseIn': Curves.fastLinearToSlowEaseIn,
    'ease': Curves.ease,
    'easeIn': Curves.easeIn,
    'easeInToLinear': Curves.easeInToLinear,
    'easeInSine': Curves.easeInSine,
    'easeInQuad': Curves.easeInQuad,
    'easeInCubic': Curves.easeInCubic,
    'easeInQuart': Curves.easeInQuart,
    'easeInQuint': Curves.easeInQuint,
    'easeInExpo': Curves.easeInExpo,
    'easeInCirc': Curves.easeInCirc,
    'easeInBack': Curves.easeInBack,
    'easeOut': Curves.easeOut,
    'linearToEaseOut': Curves.linearToEaseOut,
    'easeOutSine': Curves.easeOutSine,
    'easeOutQuad': Curves.easeOutQuad,
    'easeOutCubic': Curves.easeOutCubic,
    'easeOutQuart': Curves.easeOutQuart,
    'easeOutQuint': Curves.easeOutQuint,
    'easeOutExpo': Curves.easeOutExpo,
    'easeOutCirc': Curves.easeOutCirc,
    'easeOutBack': Curves.easeOutBack,
    'easeInOut': Curves.easeInOut,
    'easeInOutSine': Curves.easeInOutSine,
    'easeInOutQuad': Curves.easeInOutQuad,
    'easeInOutCubic': Curves.easeInOutCubic,
    'easeInOutQuart': Curves.easeInOutQuart,
    'easeInOutExpo': Curves.easeInOutExpo,
    'easeInOutQuint': Curves.easeInOutQuint,
    'easeInOutCirc': Curves.easeInOutCirc,
    'easeInOutBack': Curves.easeInOutBack,
    'fastOutSlowIn': Curves.fastOutSlowIn,
    'slowMiddle': Curves.slowMiddle,
    'bounceIn': Curves.bounceIn,
    'bounceInOut': Curves.bounceInOut,
    'elasticIn': Curves.elasticIn,
    'elasticOut': Curves.elasticOut,
    'elasticInOut': Curves.elasticInOut,
  };

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: animDuration,
    )..addListener(_collectPoint);
    curveAnim = CurvedAnimation(parent: _ctrl, curve: Curves.bounceOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    points.dispose();
    super.dispose();
  }

  void _collectPoint() {
    points.push(curveAnim.value);
  }

  void _startAnim() async {
    points.clear();
    await _ctrl.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startAnim,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              right: 5,
              top: 5,
              child: DropSelectableWidget(
                fontSize: 12,
                data: maps.keys.toList(),
                iconSize: 20,
                height: 25,
                width: 180,
                disableColor: const Color(0xff1F425F),
                onDropSelected: (int index) async {
                  curveAnim = CurvedAnimation(
                      parent: _ctrl, curve: maps.values.toList()[index]);
                  _startAnim();
                },
              )),
          Padding(
              padding: const EdgeInsets.all(30.0),
              child: CustomPaint(
                painter: AnimPainter(points),
                size: const Size(200, 200),
              )),
        ],
      ),
    );
  }
}
