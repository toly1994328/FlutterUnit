import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/21
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 297,
//      "name": 'IntrinsicWidth基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 子组件   【Widget】\n"
//          "如示例:上面宽可变动，中间宽固定,下面宽取前两者的最高值。",
//    }

class IntrinsicWidthDemo extends StatefulWidget {
  const IntrinsicWidthDemo({Key? key}) : super(key: key);

  @override
  _IntrinsicWidthDemoState createState() => _IntrinsicWidthDemoState();
}

class _IntrinsicWidthDemoState extends State<IntrinsicWidthDemo> {
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

  Widget buildChild(double leftWidth) {
    return IntrinsicWidth(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 50,
            width: leftWidth,
            color: Colors.yellow,
            alignment: Alignment.center,
            child: Text("width:${leftWidth.toStringAsFixed(1)}"),
          ),
          Container(
            color: Colors.blue,
            width: 150,
            height: 60,
            alignment: Alignment.center,
            child: const Text("固定宽"),
          ),
          Container(
            color: Colors.red,
            height: 40,
            alignment: Alignment.center,
            child: const Text("最宽"),
          )
        ],
      ),
    );
  }

  Widget _buildSlider() =>Slider(
    value: _height,
    max: 200.0,
    min: 80.0,
    divisions: 17,
    onChanged: (v)=> setState(() => _height= v),
  );
}
