import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final Size size;
  final double shadowHeight;
  final double tranRate;
  final Color color;

  const Tag({this.size = const Size(100, 150),this.shadowHeight=9.0,this.tranRate=0.25,this.color=Colors.red});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      child: CustomPaint(
        painter: _TagPaint(
          color: color,
          shadowHeight: shadowHeight,
          tranRate: tranRate,
        ),
      ),
    );
  }
}

class _TagPaint extends CustomPainter {
  Path path = Path();
  Path shadowPath = Path();
  Paint _paint;
  final tranRate;
  final double shadowHeight;
  final Color color;

  final rate = 0.5;

  _TagPaint({this.tranRate, this.color ,this.shadowHeight})
      : _paint = Paint()..color = color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);

    path.moveTo(0, 0);
    path.relativeLineTo(size.width-shadowHeight*rate, 0);
    path.relativeLineTo(0, size.height);
    path.relativeLineTo(-(size.width-shadowHeight*rate) / 2, -tranRate * size.height);
    path.relativeLineTo(-(size.width-shadowHeight*rate) / 2, tranRate * size.height);
    path.close();
    canvas.drawPath(path, _paint..color = color);

    shadowPath.moveTo(size.width-shadowHeight*rate, 0);
    shadowPath.relativeLineTo(0, shadowHeight);
    shadowPath.relativeLineTo(shadowHeight*rate, 0);
    shadowPath.close();
    canvas.drawPath(shadowPath, _paint..color=color.withAlpha(88));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
