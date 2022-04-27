import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2022/04/23
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 357,
//      "name": 'ImageFilter 变换效果',
//      "priority": 3,
//      "subtitle": "通过 ImageFilter.matrix 构造，进行矩阵变换，但比较鸡肋。",
//    }
class ImageFilteredMatrix extends StatefulWidget {
  const ImageFilteredMatrix({Key? key}) : super(key: key);

  @override
  State<ImageFilteredMatrix> createState() => _ImageFilteredMatrixState();
}

class _ImageFilteredMatrixState extends State<ImageFilteredMatrix> {
  double _sigmaX = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.matrix(
            Matrix4.rotationZ(_sigmaX/180*pi).storage
          ),
          child: const _TargetContent(),
        ),
        _buildTools(),
      ],
    );
  }

  Widget _buildTools() => Column(
        children: [
          Row(
            children: [
              const Text('    旋转角度:'),
              Expanded(
                child: Slider(
                    min: 0,
                    max: 90,
                    value: _sigmaX,
                    divisions: 360,
                    label: 'x:' + _sigmaX.toStringAsFixed(1),
                    onChanged: (v) => setState(() => _sigmaX = v)),
              ),
            ],
          ),
          // buildTileModeCheck()
        ],
      );
}

class _TargetContent extends StatelessWidget {
  const _TargetContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Image.asset(
        'assets/images/sabar.webp',
        fit: BoxFit.cover,
      ),
    );
  }
}
