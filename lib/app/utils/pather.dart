import 'dart:math';

import 'package:flutter/cupertino.dart';

class Pather {
  Pather._();

  static Pather create = Pather._();

  final Path _path = Path();

  Path nStarPath(int num, double R, double r, {dx = 0, dy = 0}) {
    _path.reset();//重置路径
    double perRad = 2 * pi / num;//每份的角度
    double radA = perRad / 2 / 2;//a角
    double radB = 2 * pi / (num - 1) / 2 - radA / 2 + radA;//起始b角
    _path.moveTo(cos(radA) * R + dx, -sin(radA) * R + dy);//移动到起点
    for (int i = 0; i < num; i++) {//循环生成点，路径连至
      _path.lineTo(cos(radA + perRad * i) * R + dx, -sin(radA + perRad * i) * R + dy);
      _path.lineTo(cos(radB + perRad * i) * r + dx, -sin(radB + perRad * i) * r + dy);
    }
    _path.close();
    return _path;
  }
}
