import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 287,
//      "name": 'LayoutBuilder的适应布局',
//      "priority": 2,
//      "subtitle": "可以根据区域的大小进行组件展示设计。"
//          "比如在不同的宽度区域显示不同的布局结构。"
//          "毕竟很多地方不容易获取父组件区域，使用LayoutBuilder就会非常爽口。",
//    }

class FitByLayoutBuilder extends StatefulWidget {
  const FitByLayoutBuilder({Key? key}) : super(key: key);

  @override
  _FitByLayoutBuilderState createState() => _FitByLayoutBuilderState();
}

class _FitByLayoutBuilderState extends State<FitByLayoutBuilder> {
  double _width = 100;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: _width,
          child: LayoutBuilder(
            builder: (_, zone) {
              if (zone.maxWidth <= 150) {
                return _buildType1();
              } else {
                return _buildType2(zone);
              }
            },
          ),
        ),
        _buildSlider(),
      ],
    );
  }

  Widget _buildSlider() => Slider(
          min: 50,
          max: 300,
          label: "父宽:${_width.toStringAsFixed(1)}",
          value: _width,
          onChanged: (v) => setState(() {
              _width = v;
            }));

  Widget _buildType1() => Container(
        color: Colors.blue,
        child: Column(
          children: <Widget>[
            _buildTitle(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildContent(),
            ),
          ],
        ),
      );

  Widget _buildType2(BoxConstraints zone) => Container(
        height: 100,
        width: zone.maxWidth,
        color: Colors.orange,
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10),
              height: 80,
              width: 30,
              color: Colors.grey,
            ),
            Expanded(child: _buildContent())
          ],
        ),
      );

  Widget _buildTitle() => Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
        color: Colors.grey,
        height: 30,
      );

  Widget _buildContent() => Wrap(
        runSpacing: 3,
        children: <Widget>[
          Container(
            color: Colors.red,
            height: 30,
          ),
          Container(
            color: Colors.yellow,
            height: 30,
          ),
          Container(
            color: Colors.green,
            height: 30,
          ),
        ],
      );
}
