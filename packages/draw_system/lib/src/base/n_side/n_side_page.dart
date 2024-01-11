import 'package:flutter/material.dart';

import 'shape_painter.dart';

class NSidePage extends StatefulWidget {
  final int count;

  const NSidePage({Key? key, this.count = 9}) : super(key: key);

  @override
  State<NSidePage> createState() => _NSidePageState();
}

class _NSidePageState extends State<NSidePage> {
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _count = widget.count;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: ShapePainter(_count),
          size: const Size(200, 200),
        ),
        Positioned(
            left: 0,
            top: 0,
            child: IconButton(
              onPressed: () {
                setState(() {
                  if(_count<=3)return;
                  _count--;
                });
              },
              icon: const Icon(Icons.remove),
            )),
        Positioned(
          right: 0,
            top: 0,
            child: IconButton(
              onPressed: () {
                setState(() {
                  _count++;
                });
              },
              icon: const Icon(Icons.add),
            ))
      ],
    );
  }
}
