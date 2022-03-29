import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/5/1
/// contact me by email 1981462002@qq.com
/// 说明:
@immutable
class Coordinate {
  final double step;
  final double strokeWidth;
  final Color axisColor;
  final Color gridColor;
  final double numScale;
  final bool yTop;
  final TextPainter _textPainter =
      TextPainter(textDirection: TextDirection.ltr);

  Coordinate(
      {this.step = 20,
      this.numScale = 20,
      this.yTop = false,
      this.strokeWidth = .5,
      this.axisColor = Colors.blue,
      this.gridColor = Colors.grey});

  final Paint _gridPaint = Paint();
  final Path _gridPath = Path();

  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    _drawGridLine(canvas, size);

    if (yTop) {
      canvas.save();
      canvas.scale(1, -1);
      _drawAxis(canvas, size);
      canvas.restore();
    } else {
      _drawAxis(canvas, size);
    }
    _drawText(canvas, size);

    TextSpan text = const TextSpan(
        text: "x",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Colors.black,
        ));

    _textPainter.text = text;
    _textPainter.layout(); // 进行布局

    _textPainter.paint(canvas, Offset(size.width / 2 - 20, -30));

    _textPainter.text = const TextSpan(
        text: "y",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Colors.black,
        ));
    _textPainter.layout(); // 进行布局

    if (yTop) {
      _textPainter.paint(canvas, Offset(-20, -size.height / 2));
    } else {
      _textPainter.paint(canvas, Offset(-20, size.height / 2 - 30));
    }

    canvas.restore();
  }

  void _drawAxis(Canvas canvas, Size size) {
    _gridPaint
      ..color = Colors.blue
      ..strokeWidth = 1.5;
    canvas.drawLine(
        Offset(-size.width / 2, 0), Offset(size.width / 2, 0), _gridPaint);
    canvas.drawLine(
        Offset(0, -size.height / 2), Offset(0, size.height / 2), _gridPaint);
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(0 - 7.0, size.height / 2 - 10), _gridPaint);
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(0 + 7.0, size.height / 2 - 10), _gridPaint);
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2 - 10, 7), _gridPaint);
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2 - 10, -7), _gridPaint);
  }

  void _drawGridLine(Canvas canvas, Size size) {
    _gridPaint
      ..style = PaintingStyle.stroke
      ..strokeWidth = .5
      ..color = Colors.grey;

    for (int i = 0; i < size.width / 2 / step; i++) {
      _gridPath.moveTo(step * i, -size.height / 2);
      _gridPath.relativeLineTo(0, size.height);

      _gridPath.moveTo(-step * i, -size.height / 2);
      _gridPath.relativeLineTo(0, size.height);
    }

    for (int i = 0; i < size.height / 2 / step; i++) {
      _gridPath.moveTo(-size.width / 2, step * i);
      _gridPath.relativeLineTo(size.width, 0);

      _gridPath.moveTo(
        -size.width / 2,
        -step * i,
      );
      _gridPath.relativeLineTo(size.width, 0);
    }

    canvas.drawPath(_gridPath, _gridPaint);
  }

  void _drawAxisText(Canvas canvas, String str,
      {Color color = Colors.black, bool? x = false}) {
    TextSpan text = TextSpan(
        text: str,
        style: TextStyle(
          fontSize: 11,
          color: color,
        ));

    _textPainter.text = text;
    _textPainter.layout(); // 进行布局
    Size size = _textPainter.size;
    Offset offset = Offset.zero;
    if (x == null) {
      offset = Offset(-size.width * 1.5, size.width * 0.7);
    } else if (x) {
      offset = Offset(-size.width / 2, size.height / 2);
    } else {
      offset = Offset(size.height / 2, -size.height / 2 + 2);
    }
    _textPainter.paint(canvas, offset);
  }

  void _drawText(Canvas canvas, Size size) {
    // y > 0 轴 文字
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      if (step < 20 && i.isOdd || i == 0) {
        canvas.translate(0, step);
        continue;
      } else {
        var num = (yTop ? (-i * step) : (i * step)) / numScale;
        _drawAxisText(canvas, num.toInt().toString(), color: Colors.green);
      }
      canvas.translate(0, step);
    }
    canvas.restore();

    // x > 0 轴 文字
    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      if (i == 0) {
        _drawAxisText(canvas, "O", color: Colors.black, x: null);
        canvas.translate(step, 0);
        continue;
      }
      if (step < 20 && i.isOdd) {
        canvas.translate(step, 0);
        continue;
      } else {
        var str = (i * step) / numScale;
        _drawAxisText(canvas, str.toInt().toString(),
            color: Colors.green, x: true);
      }
      canvas.translate(step, 0);
    }
    canvas.restore();

    // y < 0 轴 文字
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      if (step < 20 && i.isOdd || i == 0) {
        canvas.translate(0, -step);
        continue;
      } else {
        var num = (yTop ? (i * step) : (-i * step)) / numScale;
        _drawAxisText(canvas, num.toInt().toString(), color: Colors.green);
      }

      canvas.translate(0, -step);
    }
    canvas.restore();

    // x < 0 轴 文字
    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      if (step < 20 && i.isOdd || i == 0) {
        canvas.translate(-step, 0);
        continue;
      } else {
        var str = (-i * step) / numScale;
        _drawAxisText(canvas, str.toInt().toString(),
            color: Colors.green, x: true);
      }
      canvas.translate(-step, 0);
    }
    canvas.restore();
  }
}
