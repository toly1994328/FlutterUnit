import 'package:flutter/material.dart';

import 'const_res.dart';

//    {
//      "widgetId": 166,
//      "name": 'CustomPaint绘线图形',
//      "priority": 1,
//      "subtitle":
//          "【painter】 : 绘画器   【CustomPainter】",
//    }
class ClockPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child:CustomPaint(//使用CustomPaint盛放画布
          painter: ClockPainter(),
      ),
    )
    ;
  }
}

class ClockPainter extends CustomPainter {
  Paint _paint;
  var _radius = 3.0; //小球半径
  Path _path = Path(); //画笔对象
  ClockPainter () {
    _paint = Paint()..color= Color(0xff45d0fd)..isAntiAlias=true;
    _path.addOval(Rect.fromCircle(radius: _radius, center: Offset(0, 0))); //小球路径
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width/2-65*2, 0);
    renderDigit(1, canvas);//渲染数字
    canvas.translate(65, 0);//平移画布
    renderDigit(9, canvas);
    canvas.translate(65, 0); renderDigit(9, canvas);
    canvas.translate(65, 0); renderDigit(4, canvas);
  }
  //渲染数字  num  ：要显示的数字   canvas ：画布
  void renderDigit(int num, Canvas canvas) {
    if (num > 10) {  return; }
    for (int i = 0; i < digit[num].length; i++) {
      for (int j = 0; j < digit[num][j].length; j++) {
        if (digit[num][i][j] == 1) {
          canvas.save();
          double rX = j * 2 * (_radius + 1) + (_radius + 1); //第(i，j)个点圆心横坐标
          double rY = i * 2 * (_radius + 1) + (_radius + 1); //第(i，j)个点圆心纵坐标
          canvas.translate(rX, rY);
          canvas.drawPath(_path, _paint);
          canvas.restore();
        }
      }
    }
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate)=>false;
}