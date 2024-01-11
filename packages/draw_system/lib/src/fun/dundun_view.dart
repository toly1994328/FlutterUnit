import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DunDunView extends StatefulWidget {
  const DunDunView({Key? key}) : super(key: key);

  @override
  _DunDunViewState createState() => _DunDunViewState();
}

class _DunDunViewState extends State<DunDunView> {
  ui.Image? image;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  void loadImage() async {
    ByteData data2 = await rootBundle.load('assets/images/logo1.webp');
    image = await decodeImageFromList(data2.buffer.asUint8List());
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          painter: DunDunPainter(
            image,
          ),
          size: const Size(200, 200),
        ),
      ),
    );
  }
}

class DunDunPainter extends CustomPainter {
  final ui.Image? image;

  DunDunPainter(this.image);

  final Paint helpPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.blue;
  final Paint pathPaint = Paint()..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {

    canvas.translate(30, 80);
    helpPaint.color = Colors.red;

    pathPaint.style = PaintingStyle.fill;

    Path leftHandPath = buildLeftHandPath();
    pathPaint.color = Colors.black;
    canvas.drawPath(leftHandPath, pathPaint);

    Path erPath = buildErPath();
    canvas.drawPath(erPath, pathPaint);

    Path rightHandPath = buildRightHandPath();
    pathPaint.color = Colors.black;
    canvas.drawPath(rightHandPath, pathPaint);

    pathPaint.style = PaintingStyle.fill;
    pathPaint.color = const Color(0xffF1F4F7);

    Path bodyPath = buildBodyPath();
    canvas.drawPath(bodyPath, pathPaint);

    canvas.save();
    Path eyePath = Path();
    Matrix4 m = Matrix4.translationValues(46, -12, 0)
        .multiplied(Matrix4.rotationZ(45 / 180 * pi));
    eyePath
        .addOval(Rect.fromCenter(center: const Offset(0, 0), width: 32, height: 49));
    eyePath = eyePath.transform(m.storage);
    pathPaint.color = Colors.black;
    canvas.drawPath(eyePath, pathPaint);
    canvas.restore();

    Path nosePath = Path();
    nosePath.moveTo(79, -0);
    nosePath.relativeLineTo(12, -12);
    nosePath.relativeLineTo(-24, 0);
    nosePath.close();
    Path clipCirclePath = Path();
    clipCirclePath.addOval(
        Rect.fromCenter(center: const Offset(79, -10), width: 12, height: 12));

    nosePath = Path.combine(PathOperation.intersect, nosePath, clipCirclePath);
    pathPaint.style = PaintingStyle.fill;
    pathPaint.color = Colors.black;
    canvas.drawPath(nosePath, pathPaint);

    Path smaliPath = Path();
    smaliPath.moveTo(65, -0);

    smaliPath.quadraticBezierTo(78, 15, 90, 0);
    smaliPath.quadraticBezierTo(78, 6, 65, 0);
    pathPaint.color = Colors.red;
    canvas.drawPath(smaliPath, pathPaint);
    canvas.drawPath(
        smaliPath,
        pathPaint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = Colors.black);

    Paint colorfulPaint = Paint()..style = PaintingStyle.stroke;
    List<Color> colors = const [
      Color(0xFFF60C0C),
      Color(0xFFF3B913),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0DF6EF),
      Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];
    final List<double> pos =
        List.generate(colors.length, (index) => index / colors.length);
    colorfulPaint.shader = ui.Gradient.sweep(
        const Offset(60, -5), colors, pos, TileMode.clamp, 0, 2 * pi);
    colorfulPaint.maskFilter = const MaskFilter.blur(BlurStyle.solid, 2);

    Path colorfulPath = Path();
    colorfulPath.addOval(
        Rect.fromCenter(center: const Offset(72, -5), width: 120, height: 110));
    colorfulPath.addOval(
        Rect.fromCenter(center: const Offset(72, -5), width: 110, height: 100));
    colorfulPath.addOval(
        Rect.fromCenter(center: const Offset(72, -5), width: 115, height: 110));
    colorfulPath.addOval(
        Rect.fromCenter(center: const Offset(72, -5), width: 120, height: 105));
    colorfulPath.addOval(
        Rect.fromCenter(center: const Offset(72, -5), width: 115, height: 105));
    colorfulPath.addOval(
        Rect.fromCenter(center: const Offset(72, -5), width: 117, height: 103));
    canvas.drawPath(colorfulPath, colorfulPaint);

    canvas.save();
    Path eyePath2 = Path();
    Matrix4 m2 = Matrix4.translationValues(105, -12, 0)
        .multiplied(Matrix4.rotationZ(-40 / 180 * pi));
    eyePath2
        .addOval(Rect.fromCenter(center: const Offset(0, 0), width: 29, height: 48));
    eyePath2 = eyePath2.transform(m2.storage);
    pathPaint.style = PaintingStyle.fill;
    pathPaint.color = Colors.black;
    canvas.drawPath(eyePath2, pathPaint);

    canvas.restore();
    Path rightEyePath = Path();
    rightEyePath.addOval(
        Rect.fromCenter(center: const Offset(98, -14), width: 17, height: 17));
    pathPaint.style = PaintingStyle.stroke;
    pathPaint.color = Colors.white;
    canvas.drawPath(rightEyePath, pathPaint..strokeWidth = 2);

    Path rightEyePath2 = Path();
    rightEyePath2
        .addOval(Rect.fromCenter(center: const Offset(98, -14), width: 7, height: 7));
    pathPaint.style = PaintingStyle.fill;
    pathPaint.color = Colors.white.withOpacity(0.4);
    canvas.drawPath(rightEyePath2, pathPaint);

    Path rightEyePath3 = Path();
    rightEyePath3
        .addOval(Rect.fromCenter(center: const Offset(98, -19), width: 4, height: 4));
    pathPaint.style = PaintingStyle.fill;
    pathPaint.color = Colors.white;
    canvas.drawPath(rightEyePath3, pathPaint);

    Path leftEyePath = Path();
    leftEyePath.addOval(
        Rect.fromCenter(center: const Offset(50, -13), width: 18, height: 18));
    pathPaint.style = PaintingStyle.stroke;
    pathPaint.color = Colors.white;
    canvas.drawPath(leftEyePath, pathPaint..strokeWidth = 2);

    Path leftEyePath2 = Path();
    leftEyePath2
        .addOval(Rect.fromCenter(center: const Offset(50, -13), width: 7, height: 7));
    pathPaint.style = PaintingStyle.fill;
    pathPaint.color = Colors.white.withOpacity(0.4);
    canvas.drawPath(leftEyePath2, pathPaint);

    Path leftEyePath3 = Path();
    leftEyePath3
        .addOval(Rect.fromCenter(center: const Offset(51, -19), width: 4, height: 4));
    pathPaint.style = PaintingStyle.fill;
    pathPaint.color = Colors.white;
    canvas.drawPath(leftEyePath3, pathPaint);

    Path leftFootPath = buildFootPath();
    pathPaint.style = PaintingStyle.fill;
    pathPaint.color = Colors.black;
    canvas.drawPath(leftFootPath, pathPaint);

    //爱心
    List<Offset> arr = [];
    int len = 50;
    double a = 1;
    for (int i = 0; i < len; i++) {
      double step = (i / len) * (pi * 2); //递增的θ
      Offset offset = Offset(
        a * (11 * pow(sin(step), 3)).toDouble(),
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
    pathPaint.color = Colors.red;
    starPath = starPath.shift(const Offset(152, -20));
    canvas.drawPath(starPath, pathPaint);
    if (image != null) {
      Rect src2 = Rect.fromLTWH(
          0, 0, image!.width.toDouble(), image!.height.toDouble());
      Rect dst2 = const Rect.fromLTWH(50, 55, 899 / 28, 1066 / 28);

      canvas.drawImageRect(image!, src2, dst2, Paint());
    }

    Path dundunOutLine = Path.combine(
        PathOperation.union,
        Path.combine(
            PathOperation.union,
            Path.combine(
                PathOperation.union,
                Path.combine(PathOperation.union, bodyPath, leftFootPath),
                rightHandPath),
            leftHandPath),
        erPath);
    Paint outLinePainter = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = 3;
    outLinePainter.maskFilter = const MaskFilter.blur(BlurStyle.outer, 4);
    canvas.drawPath(dundunOutLine, outLinePainter);

    Path p2 = Path()
      ..addOval(Rect.fromCenter(
          center: const Offset(
            72,
            -5,
          ),
          width: 126,
          height: 116));

    outLinePainter.maskFilter = const MaskFilter.blur(BlurStyle.outer, 4);
    canvas.drawPath(
        p2,
        outLinePainter
          ..color = Colors.black
          ..strokeWidth = 2);
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

  void paintBodyPoints(ui.Canvas canvas) {
    helpPaint.strokeWidth = 4;
    canvas.drawPoints(
        ui.PointMode.points,
        [
          const Offset(10, -68),
          const Offset(75, -75),

          const Offset(135, -70),
          const Offset(138, 0),

          const Offset(130, 90),
          const Offset(65, 98),

          // Offset(55,98),
          // Offset(18,78),

          const Offset(-5, 85),
          const Offset(0, 0),
        ],
        helpPaint);
  }

  void paintErPoints(ui.Canvas canvas) {
    helpPaint.strokeWidth = 4;
    canvas.drawPoints(
        ui.PointMode.points,
        [
          const Offset(
            13,
            -40,
          ),
          const Offset(
            40,
            -68,
          ),
          const Offset(40, -55),
          const Offset(
            8,
            -95,
          ),
          // Offset(18, 78),
          // Offset(22, 115),
          // Offset(55, 98),
          // Offset(
          //   40,
          //   80,
          // ),
        ],
        helpPaint);
  }

  void paintHandsHelpPoints(ui.Canvas canvas) {
    helpPaint.strokeWidth = 4;
    canvas.drawPoints(
        ui.PointMode.points,
        [
          const Offset(-0, 0),
          const Offset(-17, 14),
          const Offset(-28, 40),
          const Offset(-32, 58),
          const Offset(-15, 62),
          const Offset(
            8,
            60,
          ),
          const Offset(-0, 0),
        ],
        helpPaint);
  }

  void paintRightHandsHelpPoints(ui.Canvas canvas) {
    helpPaint.strokeWidth = 4;
    canvas.drawPoints(
        ui.PointMode.points,
        [
          // Offset(10,-68),
          // Offset(75,-75),
          //
          const Offset(140, -48),
          const Offset(165, -35),

          const Offset(180, -17),
          const Offset(135, 22),

          const Offset(125, 17),
          const Offset(135, -20),

          // Offset(55,98),
          // Offset(18,78),
        ],
        helpPaint);
  }

  void paintLeftFoodHelpPoints(ui.Canvas canvas) {
    helpPaint.strokeWidth = 4;
    canvas.drawPoints(
        ui.PointMode.points,
        [
          const Offset(
            18,
            100,
          ),
          const Offset(60, 125),
          const Offset(18, 78),
          const Offset(22, 115),
          const Offset(55, 98),
          const Offset(
            40,
            80,
          ),
        ],
        helpPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
