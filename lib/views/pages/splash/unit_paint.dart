import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-07
/// contact me by email 1981462002@qq.com
/// 说明: app 闪屏页画板

class UnitPainter extends CustomPainter {
  Paint _paint;
  double width;
  Animation repaint;
  Color color;

  Path _path1 = Path();
  Path _path2 = Path();
  Path _path3 = Path();
  Path _path4 = Path();

  UnitPainter({this.width = 200.0, this.repaint, this.color = Colors.blue}):super(repaint: repaint) {
    _paint = Paint();
  }

  @override
  void paint(Canvas canvas, Size size) {
    _path1.reset();
    _path2.reset();
    _path3.reset();
    _path4.reset();
    var factor = repaint.value;
    canvas.translate(
        size.width / 2 - width * 0.5, size.height / 2 - width * 0.5);

    canvas.save();
    canvas.translate(
        -size.width / 2 * (1 - factor), -size.width / 2 * (1 - factor));
    drawColor1(canvas);
    canvas.restore();

    canvas.save();
    canvas.translate(
        size.width / 2 * (1 - factor), -size.width / 2 * (1 - factor));
    drawColor2(canvas);
    canvas.restore();

    canvas.save();
    canvas.translate(
        size.width / 2 * (1 - factor), size.width / 2 * (1 - factor));
    drawColor3(canvas);
    canvas.restore();

    canvas.save();
    canvas.translate(
        -size.width / 2 * (1 - factor), size.width / 2 * (1 - factor));
    drawColor4(canvas);
    canvas.restore();
  }

  @override
  bool shouldRepaint(UnitPainter oldDelegate) {
    return oldDelegate.repaint!=repaint;
  }

  void drawColor1(Canvas canvas) {
    var factor = repaint.value;
    _path1.moveTo(0, 0);
    _path1.lineTo(width * 0.618 * factor - 1, 0);
    _path1.lineTo(width * 0.5 - 1, width * 0.5 - 1);
    _path1.lineTo(0, width * (1 - 0.618) * factor - 1);

    canvas.drawPath(_clipAngle(_path1), _paint..color = Colors.red);
  }

  void drawColor2(Canvas canvas) {
    var factor = repaint.value;
    _path2.moveTo(width * 0.618 * factor, 0);
    _path2.lineTo(width, 0);
    _path2.lineTo(width, width * 0.618 * factor);
    _path2.lineTo(width * 0.5, width * 0.5);

    canvas.drawPath(_clipAngle(_path2), _paint..color = Colors.blue);
  }

  void drawColor3(Canvas canvas) {
    var factor = repaint.value;
    _path3.moveTo(width * 0.5 + 1, width * 0.5 + 1);
    _path3.lineTo(width, width * 0.618 * factor + 1);
    _path3.lineTo(width, width);
    _path3.lineTo(width * (1 - 0.618) * factor + 1, width);
    canvas.drawPath(_clipAngle(_path3), _paint..color = Colors.green);
  }

  void drawColor4(Canvas canvas) {
    var factor = repaint.value;
    _path4.moveTo(0, width * (1 - 0.618) * factor);
    _path4.lineTo(width * 0.5, width * 0.5);
    _path4.lineTo(width * (1 - 0.618) * factor, width);
    _path4.lineTo(0, width);
    canvas.drawPath(_clipAngle(_path4), _paint..color = Colors.yellow);
  }

  Path _clipAngle(Path path) {
    return Path.combine(
        PathOperation.difference,
        path,
        Path()
          ..addOval(Rect.fromCircle(
              center: Offset(width * 0.5, width * 0.5), radius: 25.0)));
  }
}
