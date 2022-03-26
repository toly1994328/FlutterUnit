import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com
/// 说明: 

class Matrix4Shower extends StatelessWidget {
  final Matrix4 matrix4;

   const Matrix4Shower(this.matrix4, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${matrix4.entry(0, 0).toStringAsFixed(1)},${matrix4.entry(0, 1).toStringAsFixed(1)},${matrix4.entry(0, 2).toStringAsFixed(1)},${matrix4.entry(0, 3).toStringAsFixed(1)},\n'
          '${matrix4.entry(1, 0).toStringAsFixed(1)},${matrix4.entry(1, 1).toStringAsFixed(1)},${matrix4.entry(1, 2).toStringAsFixed(1)},${matrix4.entry(1, 3).toStringAsFixed(1)},\n'
          '${matrix4.entry(2, 0).toStringAsFixed(1)},${matrix4.entry(2, 1).toStringAsFixed(1)},${matrix4.entry(2, 2).toStringAsFixed(1)},${matrix4.entry(2, 3).toStringAsFixed(1)},\n'
          '${matrix4.entry(3, 0).toStringAsFixed(1)},${matrix4.entry(3, 1).toStringAsFixed(1)},${matrix4.entry(3, 2).toStringAsFixed(1)},${matrix4.entry(3, 3).toStringAsFixed(1)}',
      style: const TextStyle(fontSize: 20, color: Colors.blue),
    );
  }
}