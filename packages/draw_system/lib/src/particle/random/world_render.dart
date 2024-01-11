import 'package:flutter/material.dart';

import 'particle.dart';
import 'particle_manage.dart';

/// create by 张风捷特烈 on 2020/11/7
/// contact me by email 1981462002@qq.com
/// 说明:

class WorldRender extends CustomPainter {

  final ParticleManage manage;

  Paint fillPaint = Paint();

  Paint stokePaint = Paint()
    ..strokeWidth = 0.5
    ..style = PaintingStyle.stroke;

  WorldRender({required this.manage}) : super(repaint: manage);

  @override
  void paint(Canvas canvas, Size size) {
    for (Particle particle in manage.particles) {
      drawParticle(canvas, particle);
    }
  }

  void drawParticle(Canvas canvas, Particle particle) {
    fillPaint.color = particle.color;
    canvas.drawCircle(Offset(particle.x, particle.y), particle.size, fillPaint);
  }

  @override
  bool shouldRepaint(covariant WorldRender oldDelegate) =>
      oldDelegate.manage != manage;
}
