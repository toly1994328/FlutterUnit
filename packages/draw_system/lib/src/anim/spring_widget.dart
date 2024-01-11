import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SpringWidget extends StatefulWidget {

   const SpringWidget({Key? key}) : super(key: key);

  @override
  _SpringWidgetState createState() => _SpringWidgetState();
}

const double _kDefaultSpringHeight = 100; //弹簧默认高度
const double _kRateOfMove = 1.5; //移动距离与形变量比值

const double _kK = 3;

class _SpringWidgetState extends State<SpringWidget> with SingleTickerProviderStateMixin {
  ValueNotifier<double> height = ValueNotifier(_kDefaultSpringHeight);

 late AnimationController _ctrl;

  double s = 0;  // 移动距离
  double laseMoveLen = 0;

  late Animation<double> animation;

  final Duration animDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: animDuration)
      ..addListener(_updateHeightByAnim);
    // animation = CurvedAnimation(parent: _ctrl, curve: Curves.bounceOut);
    animation = CurvedAnimation(parent: _ctrl, curve: const Interpolator());
  }

  void _updateHeightByAnim() {
    s = laseMoveLen * (1 - animation.value);
    height.value = _kDefaultSpringHeight + (-s / _kRateOfMove);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    height.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _updateSpace,
      onVerticalDragEnd: _animateToDefault,
      child: Container(
            width: 200,
            height: 200,
            color: Colors.grey.withAlpha(11),
            child: CustomPaint(
                painter: SpringPainter(height: height)),
      ),
    );
  }

  double f = 0;

  void _updateSpace(DragUpdateDetails details) {
    s += details.delta.dy;
    height.value = _kDefaultSpringHeight + dx;
  }

  double get dx => -s / _kRateOfMove;

  double get k => _kK;

  void _animateToDefault(DragEndDetails details) {
    // f = k * dx;
    // print('----[弹性系数:$_kK]---[移动了:$dx]----[可提供弹力:$f]------------');
    laseMoveLen = s;
    _ctrl.forward(from: 0);
  }
}

class Interpolator extends Curve {
  const Interpolator();

  @override
  double transformInternal(double t) {
    t -= 1.0;
    return t * t * t * t * t + 1.0;
  }
}


const double _kSpringWidth = 30;

class SpringPainter extends CustomPainter {
  final int count;
  final ValueListenable<double> height;

  SpringPainter({this.count = 20,required this.height}):super(repaint: height);

  final Paint _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2+_kSpringWidth / 2, size.height);
    Path springPath = Path();
    springPath.relativeLineTo(-_kSpringWidth, 0);
    double space = height.value/(count+1);

    for (int i = 1; i < count; i++) {
      if (i % 2 == 1) {
        springPath.relativeLineTo(_kSpringWidth, -space);
      } else {
        springPath.relativeLineTo(-_kSpringWidth, -space);
      }
    }

    if(count.isOdd){
      springPath.relativeLineTo(_kSpringWidth, 0);
    }else{
      springPath.relativeLineTo(-_kSpringWidth, 0);
    }

    canvas.drawPath(springPath, _paint);
  }

  @override
  bool shouldRepaint(covariant SpringPainter oldDelegate) =>
      oldDelegate.count != count || oldDelegate.height != height;
}
