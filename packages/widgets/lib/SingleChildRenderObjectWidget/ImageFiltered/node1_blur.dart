import 'dart:ui';

import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2022/04/23
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 357,
//      "name": 'ImageFilter 高斯模糊',
//      "priority": 1,
//      "subtitle": "【imageFilter】 : 图像滤镜   【ImageFilter】\n"
//          "【child】 : 子组件   【Widget】",
//    }
class ImageFilteredBlur extends StatefulWidget {
  const ImageFilteredBlur({Key? key}) : super(key: key);

  @override
  State<ImageFilteredBlur> createState() => _ImageFilteredBlurState();
}

class _ImageFilteredBlurState extends State<ImageFilteredBlur> {
  double _sigmaX = 1.2;
  double _sigmaY = 1.2;
  TileMode _tileMode = TileMode.decal;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: _sigmaX,
            sigmaY: _sigmaY,
            tileMode: _tileMode,
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
              Expanded(
                child: Slider(
                    min: 0,
                    max: 4,
                    value: _sigmaX,
                    divisions: 360,
                    label: 'x:' + _sigmaX.toStringAsFixed(1),
                    onChanged: (v) => setState(() => _sigmaX = v)),
              ),
              Expanded(
                child: Slider(
                    min: 0,
                    max: 4,
                    value: _sigmaY,
                    divisions: 360,
                    label: 'y:' + _sigmaY.toStringAsFixed(1),
                    onChanged: (v) => setState(() => _sigmaY = v)),
              ),
            ],
          ),
          buildTileModeCheck()
        ],
      );

  Widget buildTileModeCheck() => Wrap(
        spacing: 10,
        children: TileMode.values.map((e) {
          TextStyle style;
          if (e == _tileMode) {
            Color color = Theme.of(context).primaryColor;
            style = TextStyle(fontWeight: FontWeight.bold, color: color);
          } else {
            style = const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey);
          }
          return GestureDetector(
            onTap: () => setState(() => _tileMode = e),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                e.toString().split('.')[1],
                style: style,
              ),
            ),
          );
        }).toList(),
      );
}

class _TargetContent extends StatelessWidget {
  const _TargetContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      children: <Widget>[
        SizedBox(
          height: 150,
          width: 150,
          child: Image.asset(
            'assets/images/sabar.webp',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 150,
          width: 150,
          child: Image.asset(
            'assets/images/wy_200x300.webp',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
