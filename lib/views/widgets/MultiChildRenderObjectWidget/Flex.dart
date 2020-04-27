import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



//    {
//      "widgetId": 94,
//      "name": 'Flex的排布方向基本使用',
//      "priority": 1,
//      "subtitle":
//          "【children】 : 组件列表   【List<Widget>】\n"
//          "【direction】 : 方向   【Axis】",
//    }
class DirectionFlex extends StatelessWidget {

 final  redBox= Container(
    color: Colors.red,
    height: 30,
    width: 40,
  );

 final blueBox= Container(
    color: Colors.blue,
   height: 20,
   width: 30,
  );

 final greenBox= Container(
    color: Colors.green,
    height: 20,
    width: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: Axis.values
            .map((mode) => Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(5),
              width: 160,
              height: 80,
              color: Colors.grey.withAlpha(33),
              child: _buildItem(mode)),
          Text(mode.toString().split('.')[1])
        ]))
            .toList());
  }

  _buildItem(mode) => Flex(
    direction: mode,
    children: <Widget>[
      blueBox, redBox, greenBox
    ],
  );
}

//    {
//      "widgetId": 94,
//      "name": 'Flex主轴对齐方式',
//      "priority": 2,
//      "subtitle":
//          "【mainAxisAlignment】 : 主轴对齐   【MainAxisAlignment】",
//    }
class MainAxisAlignmentFlex extends StatelessWidget {

  final  redBox= Container(
    color: Colors.red,
    height: 30,
    width: 40,
  );

  final blueBox= Container(
    color: Colors.blue,
    height: 20,
    width: 30,
  );

  final greenBox= Container(
    color: Colors.green,
    height: 20,
    width: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 5,
        children: MainAxisAlignment.values
            .map((mode) => Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(5),
              width: 160,
              height: 80,
              color: Colors.grey.withAlpha(33),
              child: _buildItem(mode)),
          Text(mode.toString().split('.')[1])
        ]))
            .toList());
  }

  _buildItem(mode) => Flex(
    direction: Axis.horizontal,
    mainAxisAlignment: mode,
    children: <Widget>[
      blueBox, redBox, greenBox
    ],
  );
}


//    {
//      "widgetId": 94,
//      "name": 'Flex交叉轴对齐方式',
//      "priority": 3,
//      "subtitle":
//          "【crossAxisAlignment】 : 交叉轴对齐   【CrossAxisAlignment】",
//    }
class CrossAxisAlignmentFlex extends StatelessWidget {

  final  redBox= Container(
    color: Colors.red,
    height: 30,
    width: 40,
  );

  final blueBox= Container(
    color: Colors.blue,
    height: 20,
    width: 30,
  );

  final greenBox= Container(
    color: Colors.green,
    height: 20,
    width: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Wrap(
        runSpacing: 5,
        children: CrossAxisAlignment.values
            .map((mode) => Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(5),
              width: 160,
              height: 80,
              color: Colors.grey.withAlpha(33),
              child: _buildItem(mode)),
          Text(mode.toString().split('.')[1])
        ]))
            .toList());
  }

  _buildItem(mode) => Flex(
    direction: Axis.horizontal,
    crossAxisAlignment: mode,
    textBaseline: TextBaseline.alphabetic,
    children: <Widget>[
      blueBox, redBox, greenBox
    ],
  );
}
//    {
//      "widgetId": 94,
//      "name": 'Flex垂直方向顺序',
//      "priority": 4,
//      "subtitle":
//          "【verticalDirection】 : 垂直方向顺序   【VerticalDirection】",
//    }
class VerticalDirectionFlex extends StatelessWidget {

  final  redBox= Container(
    color: Colors.red,
    height: 30,
    width: 40,
  );

  final blueBox= Container(
    color: Colors.blue,
    height: 20,
    width: 30,
  );

  final greenBox= Container(
    color: Colors.green,
    height: 20,
    width: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Wrap(
        runSpacing: 5,
        children: VerticalDirection.values
            .map((mode) => Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(5),
              width: 160,
              height: 80,
              color: Colors.grey.withAlpha(33),
              child: _buildItem(mode)),
          Text(mode.toString().split('.')[1])
        ]))
            .toList());
  }

  _buildItem(mode) => Flex(
    direction: Axis.vertical,
    verticalDirection: mode,
    children: <Widget>[
      blueBox, redBox, greenBox
    ],
  );
}
//    {
//      "widgetId": 94,
//      "name": 'Flex水平方向顺序',
//      "priority": 5,
//      "subtitle":
//          "【textDirection】 : 水平方向顺序   【TextDirection】",
//    }
class TextDirectionFlex extends StatelessWidget {

  final  redBox= Container(
    color: Colors.red,
    height: 30,
    width: 40,
  );

  final blueBox= Container(
    color: Colors.blue,
    height: 20,
    width: 30,
  );

  final greenBox= Container(
    color: Colors.green,
    height: 20,
    width: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Wrap(
        runSpacing: 5,
        children: TextDirection.values
            .map((mode) => Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(5),
              width: 160,
              height: 80,
              color: Colors.grey.withAlpha(33),
              child: _buildItem(mode)),
          Text(mode.toString().split('.')[1])
        ]))
            .toList());
  }

  _buildItem(mode) => Flex(
    direction: Axis.horizontal,
    textDirection: mode,
    children: <Widget>[
      blueBox, redBox, greenBox
    ],
  );
}


//    {
//      "widgetId": 94,
//      "name": 'Flex主轴对齐方式',
//      "priority": 1,
//      "subtitle":
//          "【children】 : 组件列表   【List<Widget>】\n"
//          "【direction】 : 方向   【Axis】\n"
//          "【mainAxisAlignment】 : 主轴对齐   【MainAxisAlignment】\n"
//          "【crossAxisAlignment】 : 交叉轴对齐   【CrossAxisAlignment】\n"
//          "【textBaseline】 : 文字基线   【TextBaseline】\n"
//          "【verticalDirection】 : 竖直方向   【VerticalDirection】\n"
//          "【mainAxisSize】 : 主轴尺寸   【MainAxisSize】",
//    }
class PlayFlex extends StatefulWidget {
  @override
  _PlayFlexState createState() => _PlayFlexState();
}

class _PlayFlexState extends State<PlayFlex> {
  final redBox = Container(
    color: Colors.red,
    height: 50,
    width: 50,
  );
  final blueBox = Container(
    color: Colors.blue,
    width: 60,
    height: 60,
  );
  final yellowBox = Container(
    color: Colors.yellow,
    height: 10,
    width: 10,
  );
  final greenBox = Container(
    color: Colors.green,
    height: 30,
    width: 20,
  );
  var _direction = Axis.horizontal;
  var _mainAxisAlignment = MainAxisAlignment.start;
  var _crossAxisAlignment = CrossAxisAlignment.center;
  var _verticalDirection = VerticalDirection.up;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildDirectionSelector(),
        _buildMainAxisAlignmentSelector(),
        _buildCrossAxisAlignmentSelector(),
        _buildVerticalDirectionSelector(),
        Container(
          width: 300,
          height: 300 * 0.618,
          color: Colors.grey.withAlpha(33),
          child: Flex(
            textBaseline: TextBaseline.alphabetic,
            direction: _direction,
            mainAxisAlignment: _mainAxisAlignment,
            crossAxisAlignment: _crossAxisAlignment,
            verticalDirection: _verticalDirection,
            children: <Widget>[redBox, blueBox, yellowBox, greenBox],
          ),
        ),
      ],
    );
  }

  Widget _buildDirectionSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "direction",
            style: TextStyle(
                fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          DropdownButton<Axis>(
              elevation: 1,
              underline: Container(),
              value: _direction,
              items: Axis.values
                  .map((e) => DropdownMenuItem<Axis>(
                        value: e,
                        child: Text(e.toString()),
                      ))
                  .toList(),
              onChanged: (e) {
                setState(() {
                  _direction = e;
                });
              }),
        ],
      ),
    );
  }

  Widget _buildMainAxisAlignmentSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "mainAxisAlignment",
            style: TextStyle(
                fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          DropdownButton<MainAxisAlignment>(
              elevation: 1,
              underline: Container(),
              value: _mainAxisAlignment,
              items: MainAxisAlignment.values
                  .map((e) => DropdownMenuItem<MainAxisAlignment>(
                        value: e,
                        child: Text(e.toString().split('.')[1]),
                      ))
                  .toList(),
              onChanged: (e) {
                setState(() {
                  _mainAxisAlignment = e;
                });
              }),
        ],
      ),
    );
  }

  Widget _buildCrossAxisAlignmentSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "crossAxisAlignment",
            style: TextStyle(
                fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          DropdownButton<CrossAxisAlignment>(
              elevation: 1,
              underline: Container(),
              value: _crossAxisAlignment,
              items: CrossAxisAlignment.values
                  .map((e) => DropdownMenuItem<CrossAxisAlignment>(
                        value: e,
                        child: Text(e.toString().split('.')[1]),
                      ))
                  .toList(),
              onChanged: (e) {
                setState(() {
                  _crossAxisAlignment = e;
                });
              }),
        ],
      ),
    );
  }

  Widget _buildVerticalDirectionSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "MainAxisSize",
            style: TextStyle(
                fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          DropdownButton<VerticalDirection>(
              elevation: 1,
              underline: Container(),
              value: _verticalDirection,
              items: VerticalDirection.values
                  .map((e) => DropdownMenuItem<VerticalDirection>(
                        value: e,
                        child: Text(e.toString().split('.')[1]),
                      ))
                  .toList(),
              onChanged: (e) {
                setState(() {
                  _verticalDirection = e;
                });
              }),
        ],
      ),
    );
  }
}