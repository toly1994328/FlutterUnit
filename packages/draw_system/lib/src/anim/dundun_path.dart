import 'dart:math';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class DunDunPathPage extends StatefulWidget {
  const DunDunPathPage({Key? key}) : super(key: key);

  @override
  _DunDunPathPageState createState() => _DunDunPathPageState();
}

class _DunDunPathPageState extends State<DunDunPathPage>with SingleTickerProviderStateMixin {
  ui.Image? logo2Image;

  late AnimationController _controller;


  @override
  void initState() {
    super.initState();
    loadImage();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void loadImage() async {
    ByteData data2 = await rootBundle.load('assets/images/logo1.webp');
    logo2Image = await decodeImageFromList(data2.buffer.asUint8List());
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: (){
            _controller.reset();
            _controller.forward();
          },
          child: CustomPaint(
            painter: DunDunPainter(logo2Image,_controller),
            size: const Size(200, 200),
          ),
        ),
      ),
    );
  }
}

class DunDunPainter extends CustomPainter {

  final ui.Image? logo2Image;
  final Animation<double> repaint;

  DunDunPainter(this.logo2Image,this.repaint):super(repaint: repaint);

  final Paint helpPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.blue;
  final Paint pathPaint = Paint()..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    if (logo2Image!=null) {
      Rect src2 = Rect.fromLTWH(
          0, 0, logo2Image!.width.toDouble(), logo2Image!.height.toDouble());
      Rect dst2 = const Rect.fromLTWH(85, 132, 899/27, 1066/27);
      canvas.drawImageRect(logo2Image!, src2, dst2, Paint());
    }

    Path dundunPath = Path();
    canvas.translate(30, 80);
    helpPaint.color = Colors.red;

    Path bodyPath = buildBodyPath();
    Path leftHandPath = buildLeftHandPath();
    Path rightHandPath = buildRightHandPath();

    canvas.save();
    Path eyePath = Path();
    Matrix4 m = Matrix4.translationValues(46,-12, 0).multiplied(
        Matrix4.rotationZ(45 / 180 * pi)
    );
    eyePath
        .addOval(Rect.fromCenter(center: const Offset(0, 0), width: 32, height: 49));
    eyePath = eyePath.transform(m.storage);
    canvas.restore();

    Path leftEyePath = Path();
    leftEyePath.addOval(Rect.fromCenter(center: const Offset(50, -13), width: 18, height: 18));

    Path leftEyePath2 = Path();
    leftEyePath2.addOval(Rect.fromCenter(center: const Offset(50, -13), width: 7, height: 7));

    Path leftEyePath3 = Path();
    leftEyePath3.addOval(Rect.fromCenter(center: const Offset(51, -19), width: 4, height: 4));


    Path rightEyePath = Path();
    rightEyePath.addOval(Rect.fromCenter(center: const Offset(98, -14), width: 17, height: 17));

    Path rightEyePath2 = Path();
    rightEyePath2.addOval(Rect.fromCenter(center: const Offset(98, -14), width: 7, height: 7));

    Path rightEyePath3 = Path();
    rightEyePath3.addOval(Rect.fromCenter(center: const Offset(98, -19), width: 4, height: 4));

    Path nosePath = Path();
    nosePath.moveTo(79, -0,);
    nosePath.relativeLineTo(14, -14,);
    nosePath.relativeLineTo(-28, 0,);
    nosePath.close();
    Path clipCirclePath =Path();
    clipCirclePath.addOval(Rect.fromCenter(center: const Offset(79, -10,), width: 14, height: 14));
    nosePath = Path.combine(PathOperation.intersect, nosePath, clipCirclePath);
    Path smaliPath = Path();
    smaliPath.moveTo(65, -0,);

    smaliPath.quadraticBezierTo(78, 15, 90, 0);
    smaliPath.quadraticBezierTo(78, 6, 65, 0,);

    Path colorfulPath =  Path();
    colorfulPath.addOval(Rect.fromCenter(center: const Offset(72, -5,), width: 120, height: 110));
    colorfulPath.addOval(Rect.fromCenter(center: const Offset(72, -5,), width: 110, height: 100));
    colorfulPath.addOval(Rect.fromCenter(center: const Offset(72, -5,), width: 115, height: 110));
    colorfulPath.addOval(Rect.fromCenter(center: const Offset(72, -5,), width: 120, height: 105));
    colorfulPath.addOval(Rect.fromCenter(center: const Offset(72, -5,), width: 115, height: 105));

    canvas.save();
    Path eyePath2 = Path();
    Matrix4 m2 = Matrix4.translationValues(105,-12,0).multiplied(
        Matrix4.rotationZ(-40 / 180 * pi)
    );
    eyePath2
        .addOval(Rect.fromCenter(center: const Offset(0, 0), width: 29, height: 48));
    eyePath2 = eyePath2.transform(m2.storage);
    canvas.restore();
    Path leftFootPath = buildFootPath();
    Path erPath = buildErPath();

    //爱心
    List<Offset> arr = [];
    int len = 50;
    double a =1;
    for (int i = 0; i < len; i++) {
      double step = (i / len) * (pi * 2); //递增的θ
      Offset offset = Offset(
        a * (11 * pow(sin(step), 3)).toDouble() ,
        -a *
            (9 * cos(step) -
                5 * cos(2 * step) -
                2 * cos(3 * step) -
                cos(4 * step)),
      );
      arr.add(offset);
    }
    Path starPath = Path();
    for (int i = 0; i < len; i++) {
      starPath.lineTo(arr[i].dx, arr[i].dy);
    }
    starPath = starPath.shift(const Offset(152,-20));

    dundunPath.addPath(bodyPath, Offset.zero);
    dundunPath.addPath(leftHandPath, Offset.zero);
    dundunPath.addPath(rightHandPath, Offset.zero);
    dundunPath.addPath(leftFootPath, Offset.zero);
    dundunPath.addPath(erPath, Offset.zero);
    dundunPath.addPath(eyePath, Offset.zero);
    dundunPath.addPath(eyePath2, Offset.zero);
    dundunPath.addPath(leftEyePath, Offset.zero);
    dundunPath.addPath(leftEyePath2, Offset.zero);
    dundunPath.addPath(leftEyePath3, Offset.zero);
    dundunPath.addPath(rightEyePath, Offset.zero);
    dundunPath.addPath(rightEyePath2, Offset.zero);
    dundunPath.addPath(rightEyePath3, Offset.zero);
    dundunPath.addPath(nosePath, Offset.zero);
    dundunPath.addPath(starPath, Offset.zero);
    dundunPath.addPath(colorfulPath, Offset.zero);
    dundunPath.addPath(smaliPath, Offset.zero);

    pathPaint
      ..strokeWidth = 1
      ..color = Colors.cyanAccent;
    PathMetrics pms = dundunPath.computeMetrics();
    for (PathMetric pm in pms) {
      canvas.drawPath(pm.extractPath(0, pm.length * repaint.value), pathPaint);
    }
  }

  Path buildBodyPath() {
    Path path = Path();
    path.quadraticBezierTo(10, -75, 75, -75);
    path.quadraticBezierTo(135, -70, 138, 0);
    path.quadraticBezierTo(130, 90, 65, 98);
    path.quadraticBezierTo(-5, 85, 0, 0);
    return path;
  }

  Path buildLeftHandPath() {
    Path path = Path();
    path.quadraticBezierTo(
      -17,
      14,
      -28,
      40,
    );
    path.quadraticBezierTo(-32, 58, -15, 62);
    path.quadraticBezierTo(10, 60, 0, 0);
    return path;
  }

  Path buildRightHandPath() {
    Path path = Path();
    path.moveTo(135, -20);
    path.quadraticBezierTo(140, -48, 165, -35);
    path.quadraticBezierTo(180, -17, 135, 22);
    path.quadraticBezierTo(125, 17, 135, -20);
    return path;
  }

  Path buildFootPath() {
    Path path = Path();
    path.moveTo(18, 78);
    path.quadraticBezierTo(18, 100, 22, 115);
    path.quadraticBezierTo(60, 125, 55, 98);
    path.quadraticBezierTo(35, 80, 18, 78);

    Path right = path
        .transform(Matrix4.diagonal3Values(-1, 1, 1).storage)
        .shift(const Offset(128, 0));

    return Path.combine(PathOperation.union, path, right);
  }

  Path buildErPath() {
    Path path = Path();
    path.moveTo(13, -40);
    path.quadraticBezierTo(8, -95, 40, -68);
    path.quadraticBezierTo(40, -55, 13, -40);

    Path right = path
        .transform(Matrix4.diagonal3Values(-1, 1, 1).storage)
        .shift(const Offset(138, -5));

    return Path.combine(PathOperation.union, path, right);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
