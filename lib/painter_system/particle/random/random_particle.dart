import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'particle.dart';

import 'particle_manage.dart';
import 'world_render.dart';

/// create by 张风捷特烈 on 2020/11/5
/// contact me by email 1981462002@qq.com
/// 说明:

class RandomParticle extends StatefulWidget {
  const RandomParticle({Key? key}) : super(key: key);

  @override
  _RandomParticleState createState() => _RandomParticleState();
}

class _RandomParticleState extends State<RandomParticle> with SingleTickerProviderStateMixin {
 late AnimationController _controller;
  ParticleManage pm = ParticleManage();
  Random random = Random();
  Timer? _timer;

  @override
  void initState() {
    super.initState();


    _timer =Timer.periodic(const Duration(seconds: 1),addParticle);

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..addListener(pm.tick)
        ..repeat();
  }

  void addParticle(Timer timer){
    if(pm.particles.length>20){
      timer.cancel();
    }
    pm.addParticle(Particle(
        color: randomRGB(),
        size: 5 + 4 * random.nextDouble(),
        vx: 3 * random.nextDouble() * pow(-1, random.nextInt(20)),
        vy: 3 * random.nextDouble() * pow(-1, random.nextInt(20)),
        ay: 0.1,
        x: 150,
        y: 100));
  }

  Color randomRGB({int limitR = 0, int limitG = 0, int limitB = 0,}) {
    var r = limitR + random.nextInt(256 - limitR); //红值
    var g = limitG + random.nextInt(256 - limitG); //绿值
    var b = limitB + random.nextInt(256 - limitB); //蓝值
    return Color.fromARGB(255, r, g, b); //生成argb模式的颜色
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  theWorld() {
    if (_controller.isAnimating) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_,constraints){
        pm.size = constraints.biggest;
        return GestureDetector(
          onTap: theWorld,
          child: CustomPaint(
            size: pm.size,
            painter: WorldRender(manage: pm),
          ),
        );
      },
    );
  }
}
