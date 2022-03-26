import 'dart:math';
import 'package:flutter/material.dart';
import 'particle.dart';

import 'particle_manage.dart';
import 'world_render.dart';

/// create by 张风捷特烈 on 2020/11/5
/// contact me by email 1981462002@qq.com
/// 说明:

class ParticleSplit extends StatefulWidget {
  const ParticleSplit({Key? key}) : super(key: key);

  @override
  _ParticleSplitState createState() => _ParticleSplitState();
}

class _ParticleSplitState extends State<ParticleSplit> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ParticleManage pm = ParticleManage();
  Random random = Random();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..addListener(pm.tick);

    initParticle();
    // Future.delayed(Duration(seconds: 1)).then((value){
    //
    // });
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // void theWorld() {
  //   if (_controller.isAnimating) {
  //     _controller.stop();
  //   } else {
  //     _controller.repeat();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_,constraints){
        pm.size = constraints.biggest;
        return GestureDetector(
          // onDoubleTap: (){
          //   pm.addParticle(Particle(
          //       color: Colors.blue,
          //       size: 50,
          //       vx: 4 * random.nextDouble() * pow(-1, random.nextInt(20)),
          //       vy: 4 * random.nextDouble() * pow(-1, random.nextInt(20)),
          //       ay: 0.1,
          //       ax: 0.1,
          //       x: 150,
          //       y: 100));
          // },
          onTap: initParticle,
          child: CustomPaint(
            size: pm.size,
            painter: WorldRender(manage: pm),
          ),
        );
      },
    );

  }

  void initParticle(){
    pm.particles.clear();
    pm.addParticle(Particle(
        color: Colors.blue,
        size: 50,
        vx: 4 * random.nextDouble() * pow(-1, random.nextInt(20)),
        vy: 4 * random.nextDouble() * pow(-1, random.nextInt(20)),
        ay: 0.1,
        ax: 0.1,
        x: 150,
        y: 100));
    _controller.reset();
    _controller.repeat();
  }
}
