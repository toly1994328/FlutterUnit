import 'dart:ui';

import 'package:flutter/material.dart';

class PictureFrame extends StatelessWidget {
  final Widget child;

  const PictureFrame({
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.shortestSide;
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(20),
      child: CustomPaint(
        painter: FramePainter(),
        child:  Container(
          margin: EdgeInsets.all(14),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class FramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print(size);
    Path path = Path()
      ..relativeLineTo(0, size.height)
      ..relativeLineTo(size.width, 0)
      ..relativeLineTo(0, -size.height)
      ..close();
    Paint myPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.drawPath(path, myPaint);
    var shadowPath = Path()..addRect(Rect.fromPoints(Offset.zero, Offset(size.width,size.height)));
    // canvas.drawShadow(shadowPath, Colors.grey, 1, false);

    canvas.save();
    canvas.translate(size.width/2, size.height/2);
    canvas.scale(-1,1);
    canvas.translate(-size.width/2, -size.height/2);
    drawCorner(myPaint, canvas);
    canvas.restore();

    canvas.save();
    canvas.translate(size.width/2, size.height/2);
    canvas.scale(1,-1);
    canvas.translate(-size.width/2, -size.height/2);
    drawCorner(myPaint, canvas);
    canvas.restore();

    canvas.save();
    canvas.translate(size.width, size.height);
    canvas.scale(-1,-1);
    drawCorner(myPaint, canvas);
    canvas.restore();
    drawCorner(myPaint, canvas);
    canvas.drawShadow(shadowPath, Colors.grey, 1, false);
  }

  void drawCorner(Paint myPaint, Canvas canvas) {
    myPaint..style = PaintingStyle.fill..color=Colors.white..strokeCap=StrokeCap.butt;
    canvas.drawPoints(PointMode.polygon, [
      Offset(0,0),
      Offset(18,0),
      Offset(0,18),
      Offset(0,0),
    ], myPaint);
    canvas.drawCircle(Offset(8,8), 3, myPaint..color=Colors.black);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
