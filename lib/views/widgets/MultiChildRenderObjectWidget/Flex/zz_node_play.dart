import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com
/// 说明: 

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