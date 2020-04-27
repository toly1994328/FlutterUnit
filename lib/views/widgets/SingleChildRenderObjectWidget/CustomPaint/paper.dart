import 'package:flutter/material.dart';

class Circle {
final double radius; //大小
final Color color; //颜色
final Offset pos; //位置
  Circle({this.color, this.pos, this.radius = 1});
}

class PaperWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PaperWidgetState();
}

class _PaperWidgetState extends State<PaperWidget> {
  var _positions = <Circle>[]; //点集
  var _lines = <List<Circle>>[]; //线集
  Offset _oldPos; //记录上一点
  @override
  Widget build(BuildContext context) {
    var body = Container(
      //容器默认全屏
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: CustomPaint(
        painter: PaperPainter(lines: _lines),
      ),
    );
    return GestureDetector(
      child: body,
      //手势监听器
      onPanDown: _panDown,
      //按下处理
      onPanUpdate: _panUpdate,
      //移动处理
      onPanEnd: _panEnd,
      //结束处理
      onDoubleTap: () {
        //双击清空
        _lines.clear();
        _render();
      },
    );
  }

  void _panDown(DragDownDetails details) {
    _lines.add(_positions);
    var x = details.localPosition.dx;
    var y = details.localPosition.dy;
    _oldPos = Offset(x, y);
  }

// 抬起后，将旧线拷贝到线集中
  void _panEnd(DragEndDetails details) {
    var oldBall = <Circle>[];
    for (int i = 0; i < _positions.length; i++) {
      oldBall.add(_positions[i]);
    }
    _lines.add(oldBall);
    _positions.clear();
  }

  void _panUpdate(DragUpdateDetails details) {
    var x = details.localPosition.dx;
    var y = details.localPosition.dy;
    var curPos = Offset(x, y);
    if ((curPos - _oldPos).distance > 3) {
//距离小于3不处理，避免渲染过多
      var circle = Circle(
          color:Colors.blue,
          pos: curPos,
          radius: 6);
      _positions.add(circle);
      _oldPos = curPos;
      _render();
    }
  }

  //渲染方法，将重新渲染组件
  void _render() {
    setState(() {});
  }
}

class PaperPainter extends CustomPainter {

  Paint _paint; //画笔
  final List<List<Circle>> lines; //记录线的所有点位

  PaperPainter({
    @required this.lines,
  }) {
    _paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < lines.length; i++) {
      drawLine(canvas, lines[i]); //绘制线
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  //根据点位绘制线
  void drawLine(Canvas canvas, List<Circle> positions) {
    for (int i = 0; i < positions.length - 1; i++) {
      if (positions[i] != null && positions[i + 1] != null)
        canvas.drawLine(positions[i].pos, positions[i + 1].pos,
            _paint..strokeWidth = positions[i].radius);
    }
  }
}
