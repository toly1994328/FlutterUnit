import 'dart:math';

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-22
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 360,
//      "priority": 2,
//      "name": "RawMagnifier 自定义装饰形状",
//      "subtitle": "这里自定义五角星装饰形状",
//    }
class MagnifierStarShape extends StatefulWidget{

  const MagnifierStarShape({super.key});

  @override
  State<MagnifierStarShape> createState() => _MagnifierStarShapeState();
}

class _MagnifierStarShapeState extends State<MagnifierStarShape> {
  final Size magnifierSize =  const Size(150, 150);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        GestureDetector(
            onPanDown: _onPanDown,
            onPanEnd: _onPanEnd,
            onPanUpdate: _onPanUpdate,
            onPanCancel: _onPanCancel,
            child: Image.asset('assets/images/sabar_bar.webp')),
        Text("张风捷特烈",style: TextStyle(color: Colors.white),),
        if(_show)
          Positioned(
              left: _dragGesturePosition.dx,
              top: _dragGesturePosition.dy,
              child: _buildMagnifier()),
      ],
    );
  }

  Widget _buildMagnifier(){
    return RawMagnifier(
        decoration:  MagnifierDecoration(
          shape: _StarShapeBorder(),
        ),
      size: magnifierSize,
      // focalPointOffset:  Offset(-10, 0),
      magnificationScale: 3,
    );
  }

  Offset _dragGesturePosition = Offset.zero;
  bool _show = false;

  void _onPanDown(DragDownDetails details) {
    _dragGesturePosition = details.localPosition-Offset(magnifierSize.width/2,magnifierSize.height/2);
    _show = true;
    setState(() {

    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() => _show = false);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _dragGesturePosition = details.localPosition-Offset(magnifierSize.width/2,magnifierSize.height/2);
    setState(() {

    });
  }

  void _onPanCancel() {
    setState(() => _show = false);
  }
}

class _StarShapeBorder extends ShapeBorder {
  final Path _path = Path();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      nStarPath(5, rect.height / 2, rect.height / 2 * 0.5,
          dx: rect.width / 2, dy: rect.height / 2);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    Paint paint = Paint()..style=PaintingStyle.stroke..color=Colors.blue..strokeWidth =2;
    canvas.drawPath(getOuterPath(rect), paint);
  }

  Path nStarPath(int num, double R, double r, {dx = 0, dy = 0}) {
    double perRad = 2 * pi / num;
    double radA = perRad / 2 / 2;
    double radB = 2 * pi / (num - 1) / 2 - radA / 2 + radA;
    _path.moveTo(cos(radA) * R + dx, -sin(radA) * R + dy);
    for (int i = 0; i < num; i++) {
      _path.lineTo(
          cos(radA + perRad * i) * R + dx, -sin(radA + perRad * i) * R + dy);
      _path.lineTo(
          cos(radB + perRad * i) * r + dx, -sin(radB + perRad * i) * r + dy);
    }
    _path.close();
    return _path;
  }

  @override
  ShapeBorder scale(double t) => this;
}