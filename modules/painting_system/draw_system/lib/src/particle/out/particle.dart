import 'package:flutter/material.dart';

class Particle {

  double x; // x 坐标
  double y; // y 坐标
  double vx; // x 速度
  double vy; // y 速度
  double a; // 发射弧度
  double dist; // 距离画布中心的长度
  double distFrac;// 距离画布中心的百分比
  double size;// 粒子大小
  double life; // 粒子寿命
  double lifeLeft; // 粒子剩余寿命
  bool isFilled; // 是否填充
  Color color; // 颜色
  int distribution; // 分配情况


  Particle({
    this.x = 0,
    this.y = 0,
    this.a = 0,
    this.vx = 0,
    this.vy = 0,
    this.dist = 0,
    this.distFrac = 0,
    this.size = 0,
    this.life = 0,
    this.lifeLeft = 0,
    this.isFilled = false,
    this.color = Colors.blueAccent,
    this.distribution = 0,
  });
}


