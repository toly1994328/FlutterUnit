import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FlutterUnitText extends StatefulWidget {
  final String text;
  final Color color;
  final double fontSize;

  const FlutterUnitText({
    this.text = "Toly",
    this.color = Colors.blue,
    this.fontSize = 32,
    Key? key,
  }) : super(key: key);

  @override
  _FlutterUnitTextState createState() => _FlutterUnitTextState();
}

class _FlutterUnitTextState extends State<FlutterUnitText>
    with SingleTickerProviderStateMixin {

  late AnimationController _ctrl;

  final TextPainter _textPainter =
      TextPainter(textDirection: TextDirection.ltr);

  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    TextSpan text = TextSpan(
        text: widget.text, style:  TextStyle(fontSize: widget.fontSize, color: Colors.blue));
    _textPainter.text = text;
    _textPainter.layout(); // 进行布局

    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    animation = CurvedAnimation(parent: _ctrl, curve: const Interpolator());
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(FlutterUnitText oldWidget) {
    super.didUpdateWidget(oldWidget);
    _ctrl.forward();
  }

  String msg = '';

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: _textPainter.size,
        painter: SpringPainter(
          fontSize: widget.fontSize,
          textPainter: _textPainter,
          color: widget.color,
          skew: animation,
        ));
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

class SpringPainter extends CustomPainter {
  final ValueListenable<double> skew;
  final TextPainter textPainter;
  final double fontSize;
  String _text = '';
  Color color;

  SpringPainter(
      {required this.skew, required this.textPainter, this.color = Colors.blue,required this.fontSize})
      : super(repaint: skew) {
    _text = textPainter.text?.toPlainText() ?? '';
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    TextSpan text =
        TextSpan(text: _text, style: TextStyle(fontSize: fontSize, color: color));
    textPainter.text = text;
    textPainter.layout(); // 进行布局
    Size textSize = textPainter.size; // 尺寸必须在布局后获取

    canvas.save();
    canvas.translate(-textSize.width / 2, -textSize.height / 2);
    textPainter.paint(canvas, Offset.zero);
    TextSpan textShadow = TextSpan(
        text: _text,
        style: TextStyle(fontSize: fontSize, color: color.withAlpha(88)));
    textPainter.text = textShadow;
    textPainter.layout(); // 进行布局
    Matrix4 matrix4 = Matrix4.skewX((6 / 180 * pi) * skew.value);
    canvas.transform(matrix4.storage);
    textPainter.paint(canvas, Offset.zero);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant SpringPainter oldDelegate) =>
      oldDelegate.textPainter != textPainter || oldDelegate.skew != skew;
}
