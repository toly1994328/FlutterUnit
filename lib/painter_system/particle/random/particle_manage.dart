import 'package:flutter/cupertino.dart';

import 'particle.dart';

/// create by 张风捷特烈 on 2020/11/7
/// contact me by email 1981462002@qq.com
/// 说明:

class ParticleManage with ChangeNotifier {
  List<Particle> particles = [];

  Size size;

  ParticleManage({ this.size = Size.zero});

  void addParticle(Particle particle) {
    particles.add(particle);
    notifyListeners();
  }

  void tick() {
    particles.forEach(doUpdate);
    notifyListeners();
  }

  void doUpdate(Particle p) {
    p.vy += p.ay; // y加速度变化
    p.vx += p.ax; // x加速度变化
    p.x += p.vx;
    p.y += p.vy;

    if(p.x>size.width-p.size){
      p.x = size.width-p.size;
      p.vx = -p.vx;
    }

    if(p.x < p.size){
      p.x = p.size;
      p.vx = -p.vx;
    }

    if(p.y > size.height-p.size){
      p.y = size.height-p.size;
      p.vy = -p.vy;
    }
    if(p.y < p.size){
      p.y = p.size;
      p.vy = -p.vy;
    }

  }

  void reset() {
    for (Particle p in particles) {
      p.x = 0;
    }
    notifyListeners();
  }
}
