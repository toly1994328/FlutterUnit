import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-28
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 165,
//      "name": 'PageView基本使用',
//      "priority": 1,
//      "subtitle":
//          "【children】 : 子组件列表   【List<Widget>】\n"
//          "【onPageChanged】 : 点击事件  【ValueChanged<int>】",
//    }
class CustomPageView extends StatelessWidget {
  final data = <Color>[
    Colors.green[50],
    Colors.green[100],
    Colors.green[200],
    Colors.green[300],
    Colors.green[400],
    Colors.green[500],
    Colors.green[600],
    Colors.green[700],
    Colors.green[800],
    Colors.green[900],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: PageView(
        onPageChanged: (position){
          print(position);
        },
        children: data
            .map((color) => Container(
          alignment: Alignment.center,
          width: 90,
          color: color,
          child: Text(
            colorString(color),
            style: TextStyle(color: Colors.white,
                fontSize:24,shadows: [
              Shadow(
                  color: Colors.black,
                  offset: Offset(.5, .5),
                  blurRadius: 2)
            ]),
          ),
        ))
            .toList(),
      ),
    );
  }
  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}
//    {
//      "widgetId": 165,
//      "name": 'PageView滑动方向',
//      "priority": 2,
//      "subtitle":
//          "【scrollDirection】 : 滑动方向   【Axis】\n"
//          "【reverse】 : 是否反向  【bool】",
//    }
class DirectionPageView extends StatelessWidget {
  final data = <Color>[
    Colors.orange[50],
    Colors.orange[100],
    Colors.orange[200],
    Colors.orange[300],
    Colors.orange[400],
    Colors.orange[500],
    Colors.orange[600],
    Colors.orange[700],
    Colors.orange[800],
    Colors.orange[900],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: PageView(
        scrollDirection: Axis.vertical,
        reverse: true,
        onPageChanged: (position) {
          print(position);
        },
        children: data
            .map((color) =>
            Container(
              alignment: Alignment.center,
              width: 90,
              color: color,
              child: Text(
                colorString(color),
                style: TextStyle(color: Colors.white,
                    fontSize: 24, shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(.5, .5),
                          blurRadius: 2)
                    ]),
              ),
            ))
            .toList(),
      ),
    );
  }

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}

//    {
//      "widgetId": 165,
//      "name": 'PageView控制器简单实用',
//      "priority": 3,
//      "subtitle":
//          "【controller】 : 页面控制器   【PageController】",
//    }
class CtrlPageView extends StatefulWidget {
  @override
  _CtrlPageViewState createState() => _CtrlPageViewState();
}

class _CtrlPageViewState extends State<CtrlPageView> {
  final data = <Color>[
    Colors.orange[50],
    Colors.orange[100],
    Colors.orange[200],
    Colors.orange[300],
    Colors.orange[400],
    Colors.orange[500],
    Colors.orange[600],
    Colors.orange[700],
    Colors.orange[800],
    Colors.orange[900],
  ];

  PageController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller=PageController(
      viewportFraction: 0.8,
      initialPage: (data.length/2).round()
    );

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: PageView(
        controller: _controller,
        onPageChanged: (position) {
          print(position);
        },
        children: data
            .map((color) =>
            Container(
              alignment: Alignment.center,
              width: 90,
              color: color,
              child: Text(
                colorString(color),
                style: TextStyle(color: Colors.white,
                    fontSize: 24, shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(.5, .5),
                          blurRadius: 2)
                    ]),
              ),
            ))
            .toList(),
      ),
    );
  }

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}