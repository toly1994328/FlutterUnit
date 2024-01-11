import 'dart:math';

import 'package:flutter/material.dart';

import '../../ti/circle.dart';
import '../../ti/math_runner.dart';


/// create by 张风捷特烈 on 2020/10/24
/// contact me by email 1981462002@qq.com
/// 说明:

class PlateLoading extends StatelessWidget {
  const PlateLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Stack(alignment: Alignment.center, children: [
        const Text('loading ...'),
        MathRunner(
            reverse: false,
            f: (t) => 0.4*cos(t * pi),
            g: (t) => 0.7 * sin(t * pi),
            child: const Circle(color: Colors.blue,radius: 8,)),

        MathRunner(
            reverse: false,
            f: (t) => 0.7 * cos(t * pi),
            g: (t) => 1 * sin(t * pi),
            child: const Circle(color: Colors.yellow,radius: 8,)),
        MathRunner(
            reverse: false,
            f: (t) => -0.8 *cos(t * pi),
            g: (t) => 1 * sin(t * pi),
            child: const Circle(color: Colors.red,radius: 8,)),
        MathRunner(
            reverse: false,
            f: (t) => 1*cos(t * pi),
            g: (t) => 0.7 * sin(t * pi),
            child: const Circle(color: Colors.green,radius: 8,)),

        MathRunner(
            reverse: false,
            f: (t) => 1 * cos(t * pi),
            g: (t) => -0.7 * sin(t * pi),
            child: const Circle(color: Colors.purple,radius: 8,)),
      ]),
    );
  }
}
