import 'dart:math';
import 'package:flutter/material.dart';
class Ball extends StatelessWidget {
  const Ball({
    super.key,
    this.radius = 15,
    this.color = Colors.blue,
  });
  final double radius; //半径
  final Color color; //颜色

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

class AlignShow2 extends StatefulWidget {
  const AlignShow2({
    super.key,
  });

  @override
  _AlignShow2State createState() => _AlignShow2State();
}

class _AlignShow2State extends State<AlignShow2> {
  double _x = 0.0; //Alignment坐标系上的x坐标

  @override
  Widget build(BuildContext context) {
    var item = Container(
      width: 300,
      height: 120,
      color: Colors.black.withAlpha(10),
      child: Align(
        child: const Ball(
          color: Colors.orangeAccent,
        ),
        alignment: Alignment(_x, f(_x * pi)),
      ),
    );

    var slider = SizedBox(
      width: 320,
      child: Slider(

          max: 180,
          min: -180,
          divisions: 360,
          label: "${_x.toStringAsFixed(2)}π",
          value: _x * 180,
          onChanged: (v) => setState(() => _x = v / 180)),
    );
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[slider, item],
      ),
    );
  }

  double f(x) {
    //映射函数 -- 可随意指定
    double y = sin(x);
    return y;
  }
}
