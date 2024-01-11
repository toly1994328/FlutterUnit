import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'particle.dart';

/// create by 张风捷特烈 on 2020/11/7
/// contact me by email 1981462002@qq.com
/// 说明:

class ParticleManage with ChangeNotifier {
  List<Particle> particles = [];
  final VoidCallback? onEnd;
  Random random = Random();

  Size size;

  ParticleManage({this.size=Size.zero,this.onEnd});

  void setParticles(List<Particle> particles) {
    this.particles = particles;
  }

  void addParticle(Particle particle) {
    particles.add(particle);
    notifyListeners();
  }

  void tick({bool run=true}) {
    if(run){
      for (int i = 0; i < particles.length; i++) {
        doUpdate(particles[i]);
      }
    }
    if(particles.isNotEmpty){
      notifyListeners();
    }
  }

  void doUpdate(Particle p) {
    p.vy += p.ay; // y加速度变化
    p.vx += p.ax; // x加速度变化
    p.x += p.vx;
    p.y += p.vy;

    if (p.x > size.width) {
      particles.remove(p);
    }

    if (p.x < 0) {
      particles.remove(p);
    }

    if (p.y > size.height) {
      particles.remove(p);
    }
    if (p.y < 0) {
      particles.remove(p);
    }
    if(particles.isEmpty){
      onEnd?.call();
    }
  }

  void reset() {
    for (Particle p in particles) {
      p.x = 0;
    }
    notifyListeners();
  }

  Color randomRGB({
    int limitR = 0,
    int limitG = 0,
    int limitB = 0,
  }) {
    var r = limitR + random.nextInt(256 - limitR); //红值
    var g = limitG + random.nextInt(256 - limitG); //绿值
    var b = limitB + random.nextInt(256 - limitB); //蓝值
    return Color.fromARGB(255, r, g, b); //生成argb模式的颜色
  }
}
