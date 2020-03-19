import 'package:flutter/material.dart';

class GridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var winSize = MediaQuery.of(context).size; //获取屏幕尺寸
    return Scaffold(
      appBar: AppBar(title: Text("绘制网格"),),
      body: CustomPaint(//使用CustomPaint盛放画布
          painter: GridLinePainter(winSize),
        ),
    )
    ;
  }
}

class GridLinePainter extends CustomPainter {
  Paint _paint; //画笔对象
  Path _path=Path(); //路径对象
  Size _size; // 网格区域
  GridLinePainter(this._size) {
    _paint = Paint() //创建画笔对象,使用级联符号初始化画笔
    ..style=PaintingStyle.stroke //画线条
    ..color = Color(0xffBBC3C5)//画笔颜色
    ..isAntiAlias = true; //抗锯齿
  }

  @override // 实现绘制方法
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(gridPath(20, _size), _paint); //使用path绘制
  }

  @override // 是否应该重新绘制
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  Path gridPath(double step, Size area) {
    //绘制网格路径   step 小格边长  area 绘制区域
    for (int i = 0; i < area.height / step + 1; i++) {//画横线
      _path.moveTo(0, step * i); //移动画笔
      _path.lineTo(area.width, step * i); //画直线
    }
    for (int i = 0; i < area.width / step + 1; i++) {//画纵线
      _path.moveTo(step * i, 0);
      _path.lineTo(step * i, area.height);
    }
    return _path;
  }
}
