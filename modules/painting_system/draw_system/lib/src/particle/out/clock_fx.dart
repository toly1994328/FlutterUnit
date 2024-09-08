import 'dart:math';

import 'package:flutter/material.dart';
import 'rnd.dart';

import 'particle.dart';


const Duration easingDelayDuration = Duration(seconds: 10);

/// Probabilities of Hour, Minute, Noise.
// final particleDistributions = [2, 4, 100];

/// Number of "arms" to emit noise particles from center.
const int noiseAngles = 2000;

/// Threshold for particles to go rouge. Lower = more particles.
const int rougeDistributionLmt = 85;

/// Threshold for particles to go jelly. Lower = more particles.
const int jellyDistributionLmt = 97;


class ClockFx with ChangeNotifier {

   double width=0; //宽
   double height=0;//高
   double sizeMin=0; // 宽高最小值
   Offset center=Offset.zero; //画布中心
   Rect spawnArea=Rect.zero; // 粒子活动区域

   List<Particle> particles=[]; // 所有粒子

  int numParticles=0;// 最大粒子数
   DateTime time; //时间

  ClockFx({
    required Size size,
    required this.time,
    this.numParticles = 5000,
  }) {
    particles = List<Particle>.filled(numParticles, Particle());
    setSize(size);
  }

  void init() {
    for (int i = 0; i < numParticles; i++) {
      particles[i] = Particle(color:Colors.black );
      resetParticle(i);
    }
  }

  void setTime(DateTime time) {
    this.time = time;
  }

  void setSize(Size size) {
    width = size.width;
    height = size.height;
    sizeMin = min(width, height);
    center = Offset(width / 2, height / 2);
    spawnArea = Rect.fromLTRB(
      center.dx - sizeMin / 100,
      center.dy - sizeMin / 100,
      center.dx + sizeMin / 100,
      center.dy + sizeMin / 100,
    );
    init();
  }

  /// Resets a particle's values.
  Particle resetParticle(int i) {
    Particle p = particles[i];
    p.size = p.a = p.vx = p.vy = p.life = p.lifeLeft = 0;
    p.x = center.dx;
    p.y = center.dy;
    return p;
  }

  void tick(Duration duration) {
    updateParticles(duration); // 更新粒子
    notifyListeners();// 通知监听者(画板)更新
  }

  void updateParticles(Duration duration){
    var secFrac = DateTime.now().millisecond / 1000;

    var vecSpeed = duration.compareTo(easingDelayDuration) > 0
        ? max(.2, Curves.easeInOutSine.transform(1 - secFrac))
        : 1;

    var vecSpeedInv = Curves.easeInSine.transform(secFrac);

    var maxSpawnPerTick = 10;

    particles.asMap().forEach((i, p) {
      p.x -= p.vx * vecSpeed;
      p.y -= p.vy * vecSpeed;

      p.dist = _getDistanceFromCenter(p);
      p.distFrac = p.dist / (sizeMin / 2);

      p.lifeLeft = p.life - p.distFrac;

      p.vx -= p.lifeLeft * p.vx * .001;
      p.vy -= p.lifeLeft * p.vy * .001;

      if (p.lifeLeft < .3) {
        p.size -= p.size * .0015;
      }

      if (p.distribution > rougeDistributionLmt && p.distribution < jellyDistributionLmt) {
        var r = Rnd.getDouble(.2, 2.5) * vecSpeedInv * p.distFrac;
        p.x -= p.vx * r + (p.distFrac * Rnd.getDouble(-.4, .4));
        p.y -= p.vy * r + (p.distFrac * Rnd.getDouble(-.4, .4));
      }

      if (p.distribution >= jellyDistributionLmt) {
        var r = Rnd.getDouble(.1, .9) * vecSpeedInv * (1 - p.lifeLeft);
        p.x += p.vx * r;
        p.y += p.vy * r;
      }

      if (p.lifeLeft <= 0 || p.size <= .5) {
        resetParticle(i);
        if (maxSpawnPerTick > 0) {
          _activateParticle(p);
          maxSpawnPerTick--;
        }
      }

    });
  }

   void _activateParticle(Particle p) {
     p.x = Rnd.getDouble(spawnArea.left, spawnArea.right);
     p.y = Rnd.getDouble(spawnArea.top, spawnArea.bottom);
     p.isFilled = Rnd.getBool();
     p.size = Rnd.getDouble(3, 8);
     p.distFrac = 0;
     p.distribution = Rnd.getInt(1, 2);

     double angle = Rnd.ratio * pi * 2;


     var am = _getMinuteRadians();
     var ah = _getHourRadians() % (pi * 2);
     var d = pi / 18;
     //
     // Probably not the most efficient solution right here.
     do {
       angle = Rnd.ratio * pi * 2;
     } while (_isBetween(angle, am - d, am + d) ||
         _isBetween(angle, ah - d, ah + d) );

     p.life = Rnd.getDouble(0.75, .8);

     p.size = sizeMin *
         (Rnd.ratio > .8
             ? Rnd.getDouble(.0015, .003)
             : Rnd.getDouble(.002, .006));
     
     p.vx = sin(-angle);
     p.vy = cos(-angle);
     
     p.a = atan2(p.vy, p.vx) + pi;
     
     double v = Rnd.getDouble(.5, 1);

     p.vx *= v;
     p.vy *= v;
   }

   double _getDistanceFromCenter(Particle p) {
     var a = pow(center.dx - p.x, 2);
     var b = pow(center.dy - p.y, 2);
     return sqrt(a + b);
   }

   /// Gets the radians of the hour hand.
   double _getHourRadians() =>
       (time.hour * pi / 6) +
           (time.minute * pi / (6 * 60)) +
           (time.second * pi / (360 * 60));

   /// Gets the radians of the minute hand.
   double _getMinuteRadians() =>
       (time.minute * (2 * pi) / 60) + (time.second * pi / (30 * 60));

   /// Checks if a value is between two other values.
   bool _isBetween(double value, double min, double max) {
     return value >= min && value <= max;
   }

}
