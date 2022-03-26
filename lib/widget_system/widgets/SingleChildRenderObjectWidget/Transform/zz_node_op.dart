import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com
/// 说明:

class CustomTransform extends StatefulWidget {
  const CustomTransform({Key? key}) : super(key: key);

  @override
  _CustomTransformState createState() => _CustomTransformState();
}

class _CustomTransformState extends State<CustomTransform> {
  double angle = 0.0;
  List<double> m = [
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.1,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
  ];

  @override
  Widget build(BuildContext context) {
    var transform = Transform(
      transform: Matrix4(m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8],
          m[9], m[10], m[11], m[12], m[13], m[14], m[15]),
      child: Container(
          alignment: Alignment.center,
          color: Colors.cyanAccent,
          width: 100,
          height: 100,
          child: Image.asset(
            'assets/images/wy_300x200.webp',
            fit: BoxFit.cover,
          )),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              color: Colors.grey.withAlpha(22),
              width: 200,
              height: 150,
              child: transform,
            ),
            Text(
              '${m[0]},${m[1]},${m[2]},${m[3]},\n'
              '${m[4]},${m[5]},${m[6]},${m[7]},\n'
              '${m[8]},${m[9]},${m[10]},${m[11]},\n'
              '${m[12]},${m[13]},${m[14]},${m[15]}\n',
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: _buildSliders())
      ],
    );
  }

  Widget _buildSliders() => GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 8,
      children: m
          .asMap()
          .keys
          .map((i) => Slider(
              value: m[i],
              max: 0.01,
              min: 0.0,
              divisions: 10,
              onChanged: (v) {
                setState(() {
                  m[i] = v;
                });
              }))
          .toList());
}
