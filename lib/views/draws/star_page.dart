import 'dart:math';

import 'package:flutter/material.dart';

class StarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("n角星"),
      ),
      body: CustomPaint(
        //使用CustomPaint盛放画布
        painter: GridLinePainter(),
      ),
    );
  }
}

class GridLinePainter extends CustomPainter {
  Paint _paint; //画笔对象
  Path _path = Path(); //路径对象

  GridLinePainter() {
    _paint = Paint() //创建画笔对象,使用级联符号初始化画笔
//      ..style = PaintingStyle.stroke //画线条
      ..color = Colors.red //画笔颜色
      ..isAntiAlias = true; //抗锯齿
  }

  @override // 实现绘制方法
  void paint(Canvas canvas, Size size) {
    canvas.translate(50, 50); //移动到坐标系原点
    canvas.drawPath(nStarPath(5, 50, 25), _paint); //使用path绘制5角星
    canvas.translate(100, 0); //移动到坐标系原点
    canvas.drawPath(nStarPath(8, 50, 25), _paint); //使用path绘制8角星
  }

  @override // 是否应该重新绘制
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  Path nStarPath(int num, double R, double r, {dx = 0, dy = 0}) {
    _path.reset();
    double perDeg = 360 / num;
    double degA = perDeg / 2 / 2;
    double degB = 360 / (num - 1) / 2 - degA / 2 + degA;
    _path.moveTo(cos(rad(degA)) * R, (-sin(rad(degA)) * R));
    _path.moveTo(cos(rad(degA)) * R + dx, (-sin(rad(degA)) * R + dy));
    for (int i = 0; i < num; i++) {
      _path.lineTo(cos(rad(degA + perDeg * i)) * R + dx,
          -sin(rad(degA + perDeg * i)) * R + dy);
      _path.lineTo(cos(rad(degB + perDeg * i)) * r + dx,
          -sin(rad(degB + perDeg * i)) * r + dy);
    }
    _path.close();
    return _path;
  }

  double rad(double deg) => deg * pi / 180;
}
