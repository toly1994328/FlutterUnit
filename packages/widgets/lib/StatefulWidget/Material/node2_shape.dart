import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 160,
//      "name": 'Material的shape属性',
//      "priority": 2,
//      "subtitle":
//          "【shape】 : 形状   【ShapeBorder】\n",
//    }
class ShapeMaterial extends StatelessWidget {
  const ShapeMaterial({Key? key}) : super(key: key);

  final Map<String, ShapeBorder> shapeMap = const {
    'BorderDirectional': BorderDirectional(
        top: BorderSide(
          color: Colors.white,
        ),
        start: BorderSide(color: Colors.black, width: 15),
        bottom: BorderSide(
          color: Colors.white,
        )),
    'Border': Border(
      top: BorderSide(width: 5.0, color: Color(0xFFDFDFDF)),
      left: BorderSide(width: 5.0, color: Color(0xFFDFDFDF)),
      right: BorderSide(width: 5.0, color: Color(0xFF7F7F7F)),
      bottom: BorderSide(width: 5.0, color: Color(0xFF7F7F7F)),
    ),
    'Circle': CircleBorder(
      side: BorderSide(width: 2.0, color: Color(0xFFDFDFDF)),
    ),
    'RoundedRectangleBorder': RoundedRectangleBorder(
        side: BorderSide(width: 1.0, color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(15))),
    'ContinuousRectangleBorder': ContinuousRectangleBorder(
      side: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(40.0)),
    )
  };

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: shapeMap.keys.map((e) => _buildMaterial(e)).toList(),
    );
  }

  Material _buildMaterial(String type) => Material(
    shadowColor: Colors.blue,
    shape: shapeMap[type],
    color: Colors.orange,
    elevation: 3,
    textStyle: const TextStyle(color: Colors.white),
    child: Container(
      alignment: Alignment.center,
      width: 300,
      height: 60,
      child: Text(
        type,
      ),
    ),
  );
}
