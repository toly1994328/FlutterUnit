import 'package:flutter/material.dart';

class Particle {
  /// x 位移.
  double x;

  /// y 位移.
  double y;

  /// 粒子水平速度.
  double vx;

  // 粒子水平加速度
  double ax;

  // 粒子竖直加速度
  double ay;

  ///粒子竖直速度.
  double vy;

  /// 粒子大小.
  double size;

  /// 粒子颜色.
  Color color;

  Particle({
    this.x = 0,
    this.y = 0,
    this.ax = 0,
    this.ay = 0,
    this.vx = 0,
    this.vy = 0,
    this.size = 0,
    this.color = Colors.black,
  });

  Particle copyWith(
  { double? x,
    double? y,
    double? ax,
    double? ay,
    double? vx,
    double? vy,
    double? size,
    Color? color
  }
  ) =>
      Particle(
          x: x ?? this.x,
          y: y ?? this.y,
          ax: ax ?? this.ax,
          ay: ay ?? this.ay,
          vx: vx ?? this.vx,
          vy: vy ?? this.vy,
          size: size ?? this.size,
          color: color ?? this.color);
}
