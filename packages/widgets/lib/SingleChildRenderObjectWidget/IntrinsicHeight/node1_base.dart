import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/21
/// contact me by email 1981462002@qq.com
/// 说明: 298 IntrinsicHeight 根据子元素的固有高度调整其子元素大小的组件,可解决很多布局的疑难杂症,但相对昂贵。

//    {
//      "widgetId": 298,
//      "name": 'IntrinsicHeight基本使用',
//      "priority": 1,
//      "subtitle": "【child】 : 子组件   【Widget】\n"
//          "如示例:左侧高可变动，中间高固定,右侧高取前两者的最高值。",
//    }

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
