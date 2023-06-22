import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-22
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 360,
//      "priority": 1,
//      "name": "RawMagnifier 的简单使用",
//      "subtitle": "【size】 : 尺寸  【Size】\n"
//          "【magnificationScale】 : 放大倍率  【double】\n"
//          "【focalPointOffset】: 放大内容偏移量   【Offset】\n"
//          "【decoration】: 发现装饰   【MagnifierDecoration】\n"
//          "【child】: 子组件   【Widget?】\n",
//    }
class MagnifierCircleShape extends StatefulWidget{

  const MagnifierCircleShape({super.key});

  @override
  State<MagnifierCircleShape> createState() => _MagnifierCircleShapeState();
}

class _MagnifierCircleShapeState extends State<MagnifierCircleShape> {
  final Size magnifierSize =  const Size(150, 150);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        GestureDetector(
            onPanDown: _onPanDown,
            onPanEnd: _onPanEnd,
            onPanUpdate: _onPanUpdate,
            onPanCancel: _onPanCancel,
            child: Image.asset('assets/images/sabar_bar.webp')),
        Text("张风捷特烈",style: TextStyle(color: Colors.white),),
        if(_show)
          Positioned(
              left: _dragGesturePosition.dx,
              top: _dragGesturePosition.dy,
              child: _buildMagnifier()),
      ],
    );
  }

  Widget _buildMagnifier(){
    return RawMagnifier(
        decoration: const MagnifierDecoration(
          shape: CircleBorder(
            side: BorderSide(color: Colors.blue, width: 2),
          ),
        ),
      size: magnifierSize,
      // focalPointOffset:  Offset(-10, 0),
      magnificationScale: 3,
    );
  }

  Offset _dragGesturePosition = Offset.zero;
  bool _show = false;

  void _onPanDown(DragDownDetails details) {
    _dragGesturePosition = details.localPosition-Offset(magnifierSize.width/2,magnifierSize.height/2);
    _show = true;
    setState(() {

    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() => _show = false);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _dragGesturePosition = details.localPosition-Offset(magnifierSize.width/2,magnifierSize.height/2);
    setState(() {

    });
  }

  void _onPanCancel() {
    setState(() => _show = false);
  }
}