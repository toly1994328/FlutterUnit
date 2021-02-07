import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// create by 张风捷特烈 on 2021/2/7
/// contact me by email 1981462002@qq.com
/// 说明: 

class ClockWidget extends StatefulWidget {
  @override
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget>
    with SingleTickerProviderStateMixin {
  Ticker _ticker;
  ValueNotifier<DateTime> time = ValueNotifier<DateTime>(DateTime.now());

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick)..start();
  }

  void _tick(Duration duration) {

    if(time.value.second!=DateTime.now().second){
      time.value = DateTime.now();
    }

  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: CustomPaint(
        painter: ClockPainter(listenable: time),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  Paint _paint = Paint();

  ValueListenable<DateTime> listenable;

  ClockPainter({this.listenable}) : super(repaint: listenable);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    drawOuterCircle(canvas, size);
    drawDot(canvas);
    drawText(canvas);

    DateTime time = listenable.value;
    int sec = time.second;
    int min = time.minute;
    int hour = time.hour;

    double perAngle = 360 / 60;

    drawM(canvas, (min + sec / 60) * perAngle - 90);
    drawH(canvas, (hour + min / 60 + sec / 3600) / 12 * 360 - 90);
    drawS(canvas, sec / 60 * 360 - 90);
  }

  @override
  bool shouldRepaint(covariant ClockPainter oldDelegate) {
    return oldDelegate.listenable != listenable;
  }

  void drawOuterCircle(Canvas canvas, Size size) {
    final offsetAngle = 5;
    _paint
      ..strokeWidth = 4
      ..color = Color(0xffD5D5D5)
      ..style = PaintingStyle.stroke;
    canvas.save();
    for (int i = 0; i < 4; i++) {
      canvas.drawArc(
          Rect.fromPoints(Offset(-size.width / 2, -size.height / 2),
              Offset(size.width / 2, size.height / 2)),
          offsetAngle * pi / 180,
          pi / 2 - 2 * offsetAngle * pi / 180,
          false,
          _paint);
      canvas.rotate(pi / 2);
    }
    canvas.restore();
  }

  void drawHelp(Canvas canvas, Size size) {
    canvas.drawPoints(
        PointMode.lines,
        [
          Offset(-size.width / 2, 0),
          Offset(size.width / 2, 0),
          Offset(0, -size.height / 2),
          Offset(0, size.height / 2),
        ],
        Paint());
  }

  void drawDot(Canvas canvas) {
    canvas.save();
    _paint
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    double count = 60;
    double perAngle = 2 * pi / count;

    for (int i = 0; i < count; i++) {
      if (i % 5 == 0) {
        _paint
          ..strokeWidth = 3
          ..color = Colors.blue;
        canvas.drawLine(Offset(120, 0), Offset(135, 0), _paint);
        canvas.drawCircle(Offset(115, 0), 2, _paint..color = Colors.orange);
      } else {
        _paint
          ..strokeWidth = 1.5
          ..color = Colors.black;
        canvas.drawLine(Offset(125, 0), Offset(135, 0), _paint);
      }

      canvas.rotate(perAngle);
    }
    canvas.restore();
  }

  void drawH(Canvas canvas, double deg) {
    canvas.save();
    canvas.rotate(deg / 180 * pi);
    _paint
      ..strokeWidth = 3
      ..color = Color(0xff8FC552)
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset.zero, Offset(60, 0), _paint);
    canvas.restore();
  }

  void drawM(Canvas canvas, double deg) {
    canvas.save();
    canvas.rotate(deg / 180 * pi);
    _paint
      ..strokeWidth = 2
      ..color = Color(0xff87B953)
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
        Offset.zero,
        Offset(
          80,
          0,
        ),
        _paint);
    canvas.restore();
  }

  void drawS(Canvas canvas, double deg) {
    _paint
      ..strokeWidth = 2.5
      ..color = Color(0xff6B6B6B)
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke;
    Path path = Path();

    canvas.save();
    canvas.rotate(deg / 180 * pi);

    canvas.save();
    canvas.rotate((360 - 270) / 2 / 180 * pi);
    path.addArc(
        Rect.fromPoints(Offset(-9, -9), Offset(9, 9)), 0, 270 / 180 * pi);
    canvas.drawPath(path, _paint);
    canvas.restore();

    _paint..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(-9, 0), Offset(-20, 0), _paint);

    _paint
      ..strokeWidth = 1
      ..color = Colors.black;
    canvas.drawLine(Offset(0, 0), Offset(100, 0), _paint);

    _paint
      ..strokeWidth = 3
      ..color = Color(0xff6B6B6B);
    canvas.drawCircle(Offset.zero, 5, _paint);

    _paint
      ..color = Color(0xff8FC552)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, 4, _paint);
    canvas.restore();
  }

  final TextPainter _textPainter = TextPainter(
      textAlign: TextAlign.center, textDirection: TextDirection.ltr);

  void drawText(Canvas canvas) {
    _drawCircleText(canvas, 'Ⅸ', offsetX: -150-7.5);
    _drawCircleText(canvas, 'Ⅲ', offsetX: 150+7.5);
    _drawCircleText(canvas, 'Ⅵ', offsetY: 150+7.5);
    _drawCircleText(canvas, 'Ⅻ', offsetY: -150-7.5);
    _drawLogoText(canvas, offsetY: -80);
  }

  _drawCircleText(Canvas canvas, String text,
      {double offsetX = 0, double offsetY = 0}) {
    _textPainter.text = TextSpan(
        text: text, style: TextStyle(fontSize: 20, color: Colors.blue));
    _textPainter.layout();
    _textPainter.paint(
        canvas,
        Offset.zero.translate(-_textPainter.size.width / 2 + offsetX,
            -_textPainter.height / 2 + offsetY));
  }

  _drawLogoText(Canvas canvas, {double offsetX = 0, double offsetY = 0}) {
    _textPainter.text = TextSpan(
        text: 'Toly',
        style:
        TextStyle(fontSize: 30, color: Colors.blue, fontFamily: 'CHOPS'));
    _textPainter.layout();
    _textPainter.paint(
        canvas,
        Offset.zero.translate(-_textPainter.size.width / 2 + offsetX,
            -_textPainter.height / 2 + offsetY));
  }
}
