import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-28
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 165,
//      "name": 'PageView控制器简单实用',
//      "priority": 3,
//      "subtitle":
//          "【controller】 : 页面控制器   【PageController】",
//    }
class CtrlPageView extends StatefulWidget {
  const CtrlPageView({Key? key}) : super(key: key);

  @override
  _CtrlPageViewState createState() => _CtrlPageViewState();
}

class _CtrlPageViewState extends State<CtrlPageView> {
  final List<Color> data = [
    Colors.orange[50]!,
    Colors.orange[100]!,
    Colors.orange[200]!,
    Colors.orange[300]!,
    Colors.orange[400]!,
    Colors.orange[500]!,
    Colors.orange[600]!,
    Colors.orange[700]!,
    Colors.orange[800]!,
    Colors.orange[900]!,
  ];

  late PageController _controller;

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
  TextStyle get textStyle =>
      const TextStyle(color: Colors.white, fontSize: 24, shadows: [
        Shadow(
          color: Colors.black,
          offset: Offset(.5, .5),
          blurRadius: 2,
        ),
      ]);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                style: textStyle,
              ),
            ))
            .toList(),
      ),
    );
  }

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}