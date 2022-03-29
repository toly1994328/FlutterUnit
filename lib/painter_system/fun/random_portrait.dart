import 'dart:math';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/10/10
/// contact me by email 1981462002@qq.com
/// 说明:

class Position {
  final int x;
  final int y;

  Position(this.x, this.y);

  @override
  String toString() {
    return 'Position{x: $x, y: $y}';
  }
}

class RandomPortrait extends StatefulWidget {
  const RandomPortrait({Key? key}) : super(key: key);

  @override
  _RandomPortraitState createState() => _RandomPortraitState();
}

class _RandomPortraitState extends State<RandomPortrait> {
  List<Position> positions = [];
  Random random = Random();
  final int blockCount = 9;

  @override
  Widget build(BuildContext context) {
    _initPosition();
    return GestureDetector(
        onTap: () {
          setState(() {});
        },
        child: CustomPaint(
            painter: PortraitPainter(positions, blockCount: blockCount)));
  }

  void _initPosition() {
    positions.clear();
    int randomCount = 2 + random.nextInt(blockCount * blockCount ~/ 2 - 2);

    final int axis = blockCount ~/ 2;

    for (int i = 0; i < randomCount; i++) {
      int randomX = random.nextInt(axis + 1);
      int randomY = random.nextInt(blockCount);
      final Position position = Position(randomX, randomY);
      positions.add(position);
    }
    for (int i = 0; i < positions.length; i++) {
      if (positions[i].x < blockCount ~/ 2) {
        positions.add(Position(2 * axis - positions[i].x, positions[i].y));
      }
    }
  }
}

class PortraitPainter extends CustomPainter {
  final Paint _paint;

  final int blockCount;
  final Color color;
  final List<Position> positions;

  final pd = 20.0;

  PortraitPainter(this.positions,
      {this.blockCount = 9, this.color = Colors.blue})
      : _paint = Paint()..color = color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(
        Rect.fromPoints(Offset.zero, Offset(size.width, size.height)));

    final double perW = (size.width - pd * 2) / (blockCount);
    final double perH = (size.height - pd * 2) / (blockCount);

    canvas.translate(pd, pd);
    for (Position element in positions) {
      _drawBlock(perW, perH, canvas, element);
    }
  }

  void _drawBlock(double dW, double dH, Canvas canvas, Position position) {
    canvas.drawRect(
        Rect.fromLTWH(position.x * dW.floor() * 1.0,
            position.y * dH.floor() * 1.0, dW.floor() * 1.0, dH.floor() * 1.0),
        _paint);
  }

  @override
  bool shouldRepaint(PortraitPainter oldDelegate) => true;
}
