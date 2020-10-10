import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

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
        child: CustomPaint(painter: PaperPainter(positions)));
  }

  void _initPosition() async {
    positions.clear();
    int randomCount = 2 + random.nextInt(blockCount * blockCount ~/ 2 - 2);

    var flag = blockCount ~/ 2 + 1;

    for (int i = 0; i < randomCount; i++) {
      int randomX = random.nextInt(flag);
      int randomY = random.nextInt(blockCount);
      var position = Position(randomX, randomY);
      positions.add(position);
    }
    for (int i = 0; i < positions.length; i++) {
      if (positions[i].x < blockCount ~/ 2) {
        positions
            .add(Position(2 * flag - (positions[i].x + 1) - 1, positions[i].y));
      }
    }
  }
}

class PaperPainter extends CustomPainter {
  Paint _paint;

  final double strokeWidth = 0.5;
  final Color color = Colors.blue;
  final int blockCount = 9;

  final List<Position> positions;

  PaperPainter(this.positions) : _paint = Paint()..color = Colors.blue;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(
        Rect.fromPoints(Offset.zero, Offset(size.width, size.height)));

    var pd = 20.0;

    var dW = (size.width-pd*2) / (blockCount);
    var dH = (size.height-pd*2) / (blockCount);
    canvas.translate(pd, pd);
    positions.forEach((element) {
      _drawBlock(dW.floor(), dH.floor(), canvas, element);
    });
  }

  void _drawBlock(int dW, int dH, Canvas canvas, Position position) {
    canvas.drawRect(
        Rect.fromLTWH(position.x * dW*1.0, position.y * dH*1.0, dW*1.0, dH*1.0), _paint);
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) => true;
}
