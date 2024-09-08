import 'dart:math';

import 'package:flutter/material.dart';

class StampData extends ChangeNotifier {
  final List<Stamp> stamps = [];

  void push(Stamp stamp) {
    stamps.add(stamp);
    notifyListeners();
  }

  void removeLast() {
    stamps.removeLast();
    notifyListeners();
  }

  void activeLast({Color color = Colors.blue}) {
    stamps.last.color = color;
    notifyListeners();
  }

  void clear() {
    stamps.clear();
    notifyListeners();
  }

  void animateAt(int index, double radius) {
    stamps[index].radius = radius;
    stamps[index].rePath();
    notifyListeners();
  }

  GameState checkWin(double length){
    bool redWin = _checkWinByColor(length,Colors.red);
    if(redWin) return GameState.redWin;
    
    bool blueWin = _checkWinByColor(length,Colors.blue);
    if(blueWin) return GameState.blueWin;

    return GameState.doing;
  }
  
  bool _checkWinByColor(double length,Color color) {
    List<Offset> red = stamps
        .where((element) => element.color == color)
        .map((e) => e.center)
        .toList();
    List<Point<int>> redPoints = red
        .map<Point<int>>((e) => Point<int>(e.dx ~/ length, e.dy ~/ length))
        .toList();

    return _checkWinInline(redPoints, 3);
  }

  bool _checkWinInline(List<Point<int>> points, int max) {
    if (points.length < max) return false;
      for (int i = 0; i < points.length; i++) {
        int x = points[i].x;
        int y = points[i].y;
        if (_check(x, y, points, CheckModel.horizontal,max)) {
          return true;
        } else if (_check(x, y, points, CheckModel.vertical,max)) {
          return true;
        } else if (_check(x, y, points, CheckModel.leftDiagonal,max)) {
          return true;
        } else if (_check(x, y, points, CheckModel.rightDiagonal,max)) {
          return true;
        }
      }
    return false;
  }

  bool _check(int x, int y, List<Point> points, CheckModel checkModel,int max) {
    int count = 1;
    Point checkPoint;
    for (int i = 1; i < max; i++) {
      switch (checkModel) {
        case CheckModel.horizontal: checkPoint = Point(x - i, y); break;
        case CheckModel.vertical: checkPoint = Point(x, y - i); break;
        case CheckModel.leftDiagonal: checkPoint = Point(x - i, y + i);break;
        case CheckModel.rightDiagonal: checkPoint = Point(x + i, y + i); break;
      }
      if (points.contains(checkPoint)) {count++;} else {break;}
    }
    if (count == max) return true;
    return false;
  }
}

enum CheckModel {
  horizontal, // 横向判断
  vertical, // 竖向判断
  leftDiagonal, // 左斜判断
  rightDiagonal // 右斜判断
}

enum GameState{
  doing, // 进行中
  redWin, // 红胜
  blueWin // 蓝胜
}

class Stamp {
  Color color;
  Offset center;
  double radius;

  Stamp({this.color = Colors.blue, this.center = Offset.zero, this.radius = 20});

  Path? _path;

  Path get path {
    if (_path == null) {
      _path = Path();
      double r = radius;
      double rad = 30 / 180 * pi;

      _path!.moveTo(center.dx, center.dy);
      _path!.relativeMoveTo(r * cos(rad), -r * sin(rad));
      _path!.relativeLineTo(-2 * r * cos(rad), 0);
      _path!.relativeLineTo(r * cos(rad), r + r * sin(rad));
      _path!.relativeLineTo(r * cos(rad), -(r + r * sin(rad)));

      _path!.moveTo(center.dx, center.dy);
      _path!.relativeMoveTo(0, -r);
      _path!.relativeLineTo(-r * cos(rad), r + r * sin(rad));
      _path!.relativeLineTo(2 * r * cos(rad), 0);
      _path!.relativeLineTo(-r * cos(rad), -(r + r * sin(rad)));

      return _path!;
    } else {
      return _path!;
    }
  }

  set path(Path path) {
    _path = path;
  }

  void rePath() {
    _path = null;
    _path = path;
  }
}
