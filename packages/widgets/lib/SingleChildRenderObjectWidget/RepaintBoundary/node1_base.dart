import 'dart:ui';

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com
/// 说明: 264 RepaintBoundary 重绘边界 为子组件创建一个单独的显示列表,提升性能。源码中在TextField、DrawerController、Scrollbar、Sliver等组件中均有应用。
//    {
//      "widgetId": 264,
//      "name": "RepaintBoundary基本使用",
//      "priority": 1,
//      "subtitle": "【child】 : 子组件   【Widget】\n"
//          "比如上面的绘制视图，即使shouldRepaint为false,在滑动中会也会不断执行paint方法,使用RepaintBoundary可以避免不必要的绘制。",
//    }

class RepaintBoundaryDemo extends StatelessWidget{
  const RepaintBoundaryDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RepaintBoundary(
      child: TempPlayBezier3Page(),
    );
  }
}

class TempPlayBezier3Page extends StatefulWidget {
  const TempPlayBezier3Page({Key? key}) : super(key: key);

  @override
  _TempPlayBezier3PageState createState() => _TempPlayBezier3PageState();
}

class _TempPlayBezier3PageState extends State<TempPlayBezier3Page> {
  List<Offset> _pos = <Offset>[];
  int? selectPos;

  @override
  void initState() {
    _initPoints();
    super.initState();
  }

  void _initPoints() {
    _pos = [];
    _pos.add(const Offset(0, 0));
    _pos.add(const Offset(60, -60));
    _pos.add(const Offset(-90, -90));
    _pos.add(const Offset(-120, -40));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: CustomPaint(
        painter: TempBezierPainter(pos: _pos, selectPos: selectPos),
      ),
    );
  }
}

class TempBezierPainter extends CustomPainter {
  late Paint _gridPaint;
  late Path _gridPath;

  late Paint _mainPaint;
  late Path _mainPath;
  int? selectPos;
  late Paint _helpPaint;

  List<Offset> pos;

  TempBezierPainter({this.pos=const [], this.selectPos}) {
    _gridPaint = Paint()..style = PaintingStyle.stroke;
    _gridPath = Path();

    _mainPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    _mainPath = Path();

    _helpPaint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    print('----------Paint-------');
    canvas.clipRect(Offset.zero & size);
    canvas.translate(size.width / 2, size.height / 2);
    _drawGrid(canvas, size); //绘制格线
    _drawAxis(canvas, size); //绘制轴线

    _mainPath.moveTo(pos[0].dx, pos[0].dy);
    _mainPath.cubicTo(
        pos[1].dx, pos[1].dy, pos[2].dx, pos[2].dy, pos[3].dx, pos[3].dy);
    canvas.drawPath(_mainPath, _mainPaint);
    _drawHelp(canvas);
    _drawSelectPos(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  void _drawGrid(Canvas canvas, Size size) {
    _gridPaint
      ..color = Colors.grey
      ..strokeWidth = 0.5;
    _gridPath = _buildGridPath(_gridPath, size);
    canvas.drawPath(_buildGridPath(_gridPath, size), _gridPaint);

    canvas.save();
    canvas.scale(1, -1); //沿x轴镜像
    canvas.drawPath(_gridPath, _gridPaint);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, 1); //沿y轴镜像
    canvas.drawPath(_gridPath, _gridPaint);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, -1); //沿原点镜像
    canvas.drawPath(_gridPath, _gridPaint);
    canvas.restore();
  }

  void _drawAxis(Canvas canvas, Size size) {
    canvas.drawPoints(
        PointMode.lines,
        [
          Offset(-size.width / 2, 0),
          Offset(size.width / 2, 0),
          Offset(0, -size.height / 2),
          Offset(0, size.height / 2),
          Offset(0, size.height / 2),
          Offset(0 - 7.0, size.height / 2 - 10),
          Offset(0, size.height / 2),
          Offset(0 + 7.0, size.height / 2 - 10),
          Offset(size.width / 2, 0),
          Offset(size.width / 2 - 10, 7),
          Offset(size.width / 2, 0),
          Offset(size.width / 2 - 10, -7),
        ],
        _gridPaint
          ..color = Colors.blue
          ..strokeWidth = 1.5);
  }

  Path _buildGridPath(Path path, Size size, {step = 20.0}) {
    for (int i = 0; i < size.height / 2 / step; i++) {
      path.moveTo(0, step * i);
      path.relativeLineTo(size.width / 2, 0);
    }
    for (int i = 0; i < size.width / 2 / step; i++) {
      path.moveTo(step * i, 0);
      path.relativeLineTo(
        0,
        size.height / 2,
      );
    }
    return path;
  }

  void _drawHelp(Canvas canvas) {
    canvas.drawPoints(PointMode.lines, pos, _helpPaint..strokeWidth = 1);
    canvas.drawPoints(PointMode.points, pos, _helpPaint..strokeWidth = 8);
  }

  void _drawSelectPos(Canvas canvas) {
    if (selectPos == null) return;
    canvas.drawCircle(
        pos[selectPos!],
        10,
        _helpPaint
          ..color = Colors.green
          ..strokeWidth = 2);
  }
}
