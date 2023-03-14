
import 'dart:math';

import 'package:flutter/material.dart';

class WindmillWidget extends StatefulWidget {
  const WindmillWidget({Key? key}) : super(key: key);

  @override
  State<WindmillWidget> createState() => _WindmillWidgetState();
}

class _WindmillWidgetState extends State<WindmillWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: Duration(seconds: (3 * 1.5).toInt()),
  );
  late Animation<double> rotate;

  @override
  void initState() {
    rotate = Tween<double>(begin: 0, end: 3 * 2 * pi)
        .animate(CurveTween(curve: Curves.easeIn).animate(_ctrl));
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
      onTap: () async {
        await _ctrl.forward(from: 0);
      },
      child: CustomPaint(
        size: const Size(200, 200),
        painter: WindmillPainter(rotate),
      ),
    );
  }
}

const List<Color> kColors =  [
  Color(0xffE74437),
  Color(0xffFBBD19),
  Color(0xff3482F0),
  Color(0xff30A04C)
];

class WindmillPainter extends CustomPainter {
  final Animation<double> rotate;

  WindmillPainter(this.rotate) : super(repaint: rotate);

  @override
  void paint(Canvas canvas, Size size) {

    canvas.translate(size.width / 2, size.height / 2);
    double d = size.width * 0.4;
    canvas.rotate(rotate.value);
    Paint paint = Paint();
    for (Color color in kColors) {
      Path path1 = Path()
        ..moveTo(0, -d * 46 / 203)
        ..lineTo(0, -d * 203 / 203)
        ..lineTo(102 / 203 * d, -102 / 203 * d)
        ..lineTo(12 / 203 * d, -12 / 203 * d)
        ..close();
      canvas.drawPath(path1, paint..color = color);

      Path path2 = Path()
        ..moveTo(12 / 203 * d, -12 / 203 * d)
        ..lineTo(102 / 203 * d, -102 / 203 * d)
        ..lineTo(102 / 203 * d, 0)
        ..lineTo(46 / 203 * d, 0)
        ..close();
      canvas.drawPath(path2, paint..color = color.withOpacity(0.2));
      canvas.rotate(pi / 2);
    }
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}