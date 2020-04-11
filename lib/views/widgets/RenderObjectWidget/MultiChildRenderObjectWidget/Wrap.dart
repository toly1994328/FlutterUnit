import 'package:flutter/material.dart';
//    {
//      "widgetId": 98,
//      "name": 'Wrap的基础用法',
//      "priority": 1,
//      "subtitle":
//          "【children】 : 组件列表   【List<Widget>】\n"
//          "【spacing】 : 主轴条目间距   【double】\n"
//          "【runSpacing】 : 交叉轴条目间距   【double】\n"
//          "【direction】 : 主轴对齐   【Axis】",
//    }
class DirectionWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: Axis.values
            .map((mode) => Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(5),
              width: 160,
              height: 100,
              color: Colors.grey.withAlpha(33),
              child: _buildItem(mode)),
          Text(mode.toString().split('.')[1])
        ]))
            .toList());
  }
  final yellowBox = Container(
    color: Colors.yellow,
    height: 30,
    width: 50,
  );

  final redBox = Container(
    color: Colors.red,
    height: 40,
    width: 40,
  );
  final greenBox = Container(
    color: Colors.green,
    height: 40,
    width: 20,
  );
  final blackBox = Container(
    color: Colors.black,
    height: 10,
    width: 10,
  );
  final purpleBox = Container(
    color: Colors.purple,
    height: 20,
    width: 20,
  );
  final orangeBox = Container(
    color: Colors.orange,
    height: 80,
    width: 20,
  );
  final cyanBox = Container(
    color: Colors.cyanAccent,
    height: 10,
    width: 20,
  );

  _buildItem(mode) => Wrap(
    direction: mode,
    runSpacing: 10,
    spacing: 10,
    children: <Widget>[
      yellowBox, redBox, greenBox, cyanBox,
      blackBox, purpleBox, orangeBox,
    ],
  );
}
//    {
//      "widgetId": 98,
//      "name": 'Wrap的alignment属性',
//      "priority": 2,
//      "subtitle":
//          "【alignment】 : 主轴对齐   【WrapAlignment】",
//    }
class WrapAlignmentWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: WrapAlignment.values
            .map((mode) => Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(5),
              width: 160,
              height: 100,
              color: Colors.grey.withAlpha(88),
              child: _buildItem(mode)),
          Text(mode.toString().split('.')[1])
        ]))
            .toList());
  }

  final yellowBox = Container(
    color: Colors.yellow,
    height: 30,
    width: 50,
  );

  final redBox = Container(
    color: Colors.red,
    height: 40,
    width: 40,
  );
  final greenBox = Container(
    color: Colors.green,
    height: 40,
    width: 20,
  );
  final blackBox = Container(
    color: Colors.black,
    height: 10,
    width: 10,
  );
  final purpleBox = Container(
    color: Colors.purple,
    height: 20,
    width: 20,
  );
  final orangeBox = Container(
    color: Colors.orange,
    height: 80,
    width: 20,
  );
  final cyanBox = Container(
    color: Colors.cyanAccent,
    height: 10,
    width: 20,
  );

  _buildItem(mode) => Wrap(
        alignment: mode,
        runSpacing: 10,
        spacing: 10,
        children: <Widget>[
          yellowBox, redBox,
          greenBox, cyanBox,
          blackBox, purpleBox,
          orangeBox,
        ],
    );
}
//    {
//      "widgetId": 98,
//      "name": 'Wrap的crossAxisAlignment属性',
//      "priority": 3,
//      "subtitle":
//          "【crossAxisAlignment】 : 交叉轴对齐   【CrossAxisAlignment】",
//    }
class CrossAxisAlignmentWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: WrapCrossAlignment.values
            .map((mode) => Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(5),
              width: 160,
              height: 100,
              color: Colors.grey.withAlpha(88),
              child: _buildItem(mode)),
          Text(mode.toString().split('.')[1])
        ]))
            .toList());
  }

  final yellowBox = Container(
    color: Colors.yellow,
    height: 30,
    width: 50,
  );

  final redBox = Container(
    color: Colors.red,
    height: 40,
    width: 40,
  );
  final greenBox = Container(
    color: Colors.green,
    height: 40,
    width: 20,
  );
  final blackBox = Container(
    color: Colors.black,
    height: 10,
    width: 10,
  );
  final purpleBox = Container(
    color: Colors.purple,
    height: 20,
    width: 20,
  );
  final orangeBox = Container(
    color: Colors.orange,
    height: 80,
    width: 20,
  );
  final cyanBox = Container(
    color: Colors.cyanAccent,
    height: 10,
    width: 20,
  );

  _buildItem(mode) => Wrap(
    crossAxisAlignment: mode,
    runSpacing: 10,
    spacing: 10,
    children: <Widget>[
      yellowBox, redBox,
      greenBox, cyanBox,
      blackBox, purpleBox,
      orangeBox,
    ],
  );
}

//    {
//      "widgetId": 98,
//      "name": 'Wrap的textDirection属性',
//      "priority": 4,
//      "subtitle":
//          "【textDirection】 : 文字方向   【TextDirection】",
//    }
class TextDirectionWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: TextDirection.values
            .map((mode) => Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(5),
              width: 160,
              height: 100,
              color: Colors.grey.withAlpha(88),
              child: _buildItem(mode)),
          Text(mode.toString().split('.')[1])
        ]))
            .toList());
  }

  final yellowBox = Container(
    color: Colors.yellow,
    height: 30,
    width: 50,
  );

  final redBox = Container(
    color: Colors.red,
    height: 40,
    width: 40,
  );
  final greenBox = Container(
    color: Colors.green,
    height: 40,
    width: 20,
  );
  final blackBox = Container(
    color: Colors.black,
    height: 10,
    width: 10,
  );
  final purpleBox = Container(
    color: Colors.purple,
    height: 20,
    width: 20,
  );
  final orangeBox = Container(
    color: Colors.orange,
    height: 80,
    width: 20,
  );
  final cyanBox = Container(
    color: Colors.cyanAccent,
    height: 10,
    width: 20,
  );

  _buildItem(mode) => Wrap(
    textDirection: mode,
    runSpacing: 10,
    spacing: 10,
    children: <Widget>[
      yellowBox, redBox, greenBox, cyanBox,
      blackBox, purpleBox, orangeBox,
    ],
  );
}

//    {
//      "widgetId": 98,
//      "name": 'Wrap的textDirection属性',
//      "priority": 5,
//      "subtitle":
//          "【verticalDirection】 : 竖直方向  【VerticalDirection】",
//    }
class VerticalDirectionWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: VerticalDirection.values
            .map((mode) => Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(5),
              width: 160,
              height: 100,
              color: Colors.grey.withAlpha(88),
              child: _buildItem(mode)),
          Text(mode.toString().split('.')[1])
        ]))
            .toList());
  }

  final yellowBox = Container(
    color: Colors.yellow,
    height: 30,
    width: 50,
  );

  final redBox = Container(
    color: Colors.red,
    height: 40,
    width: 40,
  );
  final greenBox = Container(
    color: Colors.green,
    height: 40,
    width: 20,
  );
  final blackBox = Container(
    color: Colors.black,
    height: 10,
    width: 10,
  );
  final purpleBox = Container(
    color: Colors.purple,
    height: 20,
    width: 20,
  );
  final orangeBox = Container(
    color: Colors.orange,
    height: 80,
    width: 20,
  );
  final cyanBox = Container(
    color: Colors.cyanAccent,
    height: 10,
    width: 20,
  );

  _buildItem(mode) => Wrap(
    verticalDirection: mode,
    direction: Axis.vertical,
    runSpacing: 10,
    spacing: 10,
    children: <Widget>[
      yellowBox, redBox, greenBox, cyanBox,
      blackBox, purpleBox, orangeBox,
    ],
  );
}