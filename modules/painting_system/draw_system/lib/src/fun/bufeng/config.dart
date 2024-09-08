import 'dart:math';

import 'package:flutter/cupertino.dart';

class Line {
  final Offset p0;
  final Offset p1;

  Line({
    required this.p0,
    required this.p1,
  });

  bool isActive(double gap) {
    int gapIndex0 = p0.dy ~/ gap;
    int gapIndex1 = p1.dy < 0 ? -1 : p1.dy ~/ gap;
    return gapIndex0 != gapIndex1 ||
        p0.dy % gap < 0.000000001 ||
        p1.dy % gap < 0.000000001;
  }
}

class Config extends ChangeNotifier {
  int lineCount;
  Size size;
  List<Line> lines = [];

  Config({
    this.lineCount = 8,
    this.size = const Size(200, 200),
  });

  double get gap => size.height / lineCount;

  @override
  String toString() {
    int n = lines.length;
    int m = lines.where((line) => line.isActive(gap)).length;
    double parserPi = m == 0 ? 0 : 2 * n / m;
    return '投针个数: ${lines.length}\n命中个数: $m \n'
        '估算圆周率 : $parserPi';
  }

  void addNeedle() {
    Line line = _createNeedle();
    lines.add(line);
    notifyListeners();
  }

  final Random _random = Random();

  Line _createNeedle() {
    double x = _random.nextDouble() * size.width;
    double y = _random.nextDouble() * size.height;

    double rad = 2 * pi * _random.nextDouble();
    double dx = gap * cos(rad);
    double dy = gap * sin(rad);
    Line line = Line(p0: Offset(x, y), p1: Offset(x + dx, y + dy));
    return line;
  }

  void clear() {
    lines.clear();
    notifyListeners();
  }
}
