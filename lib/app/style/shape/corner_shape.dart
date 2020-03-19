import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-06
/// contact me by email 1981462002@qq.com
/// 说明: 打个洞
/// offset 洞的偏移量分率 x,y 在 0~1 之间
/// size 洞的大小

class CornerShapeBorder extends ShapeBorder {
  final Offset offset;


  CornerShapeBorder({this.offset=const Offset(0.1, 0.1)});

  @override
  EdgeInsetsGeometry get dimensions => null;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    var path = Path();
    path.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(5)));
    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    var path = Path();
    path.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(10)));


    var w = rect.width;
    var h = rect.height;
    var offsetXY = Offset( offset.dx*w,offset.dy*h);
    _getHold(path , offsetXY);
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  _getHold(Path path, Offset offset) {
    path.moveTo(0,0);
    path.lineTo(offset.dx, 0);
    path.lineTo(0, offset.dy);
//      var left = offset.dx;
//      var top = offset.dy;
//      var right = left + d;
//      var bottom = top + d;
//      path.addOval(Rect.fromLTRB(left, top, right, bottom));
    }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    return null;
  }
}
