import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/21
/// contact me by email 1981462002@qq.com


class IntrinsicHeightDemo extends StatefulWidget {
  const IntrinsicHeightDemo({Key? key}) : super(key: key);

  @override
  _IntrinsicHeightDemoState createState() => _IntrinsicHeightDemoState();
}

class _IntrinsicHeightDemoState extends State<IntrinsicHeightDemo> {
  double _height =120.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildChild(_height),
        const SizedBox(height: 10),
        _buildSlider()
      ],
    );
  }

  Widget buildChild(double leftHeight) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: leftHeight,
            width: 120,
            color: Colors.yellow,
            alignment: Alignment.center,
            child: Text("height:${leftHeight.toStringAsFixed(1)}"),
          ),
          Container(
            color: Colors.blue,
            width: 150,
            height: 80,
            alignment: Alignment.center,
            child: const Text("固定高"),
          ),
          Container(
            color: Colors.red,
            width: 60,
            alignment: Alignment.center,
            child: const Text("最高"),
          )
        ],
      ),
    );
  }

  Widget _buildSlider() =>Slider(
    value: _height,
    max: 200.0,
    min: 30.0,
    divisions: 17,
    onChanged: (v)=> setState(() => _height= v),
  );
}
