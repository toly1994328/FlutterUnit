
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../utils/coordinate.dart';
import 'touch_info.dart';

/// create by 张风捷特烈 on 2020/5/1
/// contact me by email 1981462002@qq.com
/// 说明:

class Bezier3Player extends StatefulWidget {
  const Bezier3Player({Key? key}) : super(key: key);

  @override
  _Bezier3PlayerState createState() => _Bezier3PlayerState();
}

class _Bezier3PlayerState extends State<Bezier3Player> {
  final TouchInfo touchInfo = TouchInfo();

  @override
  void dispose() {
    touchInfo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.shortestSide;
    return GestureDetector(
      onPanDown: _onPanDown,
      onPanUpdate: _onPanUpdate,
      onDoubleTap: _clear,
      child: Container(
        color: Colors.white,
        child: CustomPaint(
          size: Size(size,size),
          painter: PaperPainter(repaint: touchInfo),
        ),
      ),
    );
  }

  void _onPanDown(DragDownDetails details) {
    if (touchInfo.points.length < 4) {
      touchInfo.addPoint(details.localPosition);
    }else{
      judgeZone(details.localPosition);
    }
  }


  void _onPanUpdate(DragUpdateDetails details) {
    judgeZone(details.localPosition,update: true);
  }

  ///判断出是否在某点的半径为r圆范围内
  bool judgeCircleArea(Offset src, Offset dst, double r) =>
      (src - dst).distance <= r;

  //判断哪个点被选中
  void judgeZone(Offset src,{bool update =false}) {
    for (int i = 0; i < touchInfo.points.length; i++) {
      if (judgeCircleArea(src, touchInfo.points[i], 15)) {
        touchInfo.selectIndex = i;
        if(update){
          touchInfo.updatePoint(i, src);
        }
      }
    }
  }

  void _clear () {
    touchInfo.reset();
  }
}

class PaperPainter extends CustomPainter {
  final Coordinate coordinate = Coordinate();

  final Paint _helpPaint = Paint()
    ..color = Colors.purple
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  final TouchInfo repaint;

  PaperPainter({required this.repaint}) : super(repaint: repaint);
  List<Offset> pos=[];

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    pos = repaint.points
        .map((e) => e.translate(-size.width / 2, -size.height / 2))
        .toList();

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    if (pos.length < 4) {
      canvas.drawPoints(PointMode.points, pos, _helpPaint..strokeWidth = 8);
    } else {
      path.moveTo(pos[0].dx, pos[0].dy);
      path.cubicTo(pos[1].dx, pos[1].dy, pos[2].dx, pos[2].dy, pos[3].dx, pos[3].dy);
      canvas.drawPath(path, paint);
      _drawHelp(canvas);
      _drawSelectPos(canvas,size);
    }
  }

  void _drawHelp(Canvas canvas) {
    _helpPaint.color = Colors.purple;
    canvas.drawPoints(PointMode.polygon, pos, _helpPaint..strokeWidth = 1);
    canvas.drawPoints(PointMode.points, pos, _helpPaint..strokeWidth = 8);
  }

  void _drawSelectPos(Canvas canvas,Size size) {
    Offset? selectPos = repaint.selectPoint;
    if (selectPos == null) return;
      selectPos = selectPos.translate(-size.width / 2, -size.height / 2);
    canvas.drawCircle(
        selectPos,
        10,
        _helpPaint
          ..color = Colors.green
          ..strokeWidth = 2);
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) =>
      oldDelegate.repaint != repaint;
}
