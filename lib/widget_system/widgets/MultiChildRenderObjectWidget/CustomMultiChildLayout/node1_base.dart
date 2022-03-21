import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/6/6
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 341,
//      "name": 'CustomMultiChildLayout基本使用',
//      "priority": 1,
//      "subtitle":
//          "【children】 : 子组件集   【List<Widget>】\n"
//          "【delegate】 : 布局代理   【MultiChildLayoutDelegate】",
//    }


class CustomMultiChildLayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 150,
      color: Colors.grey.withAlpha(33),
      child: CustomMultiChildLayout(
        delegate: CornerCustomMultiChildLayout(
          padding:EdgeInsets.only(left: 10,top: 5,right: 10,bottom: 5),
        ),
        children: [
           LayoutId(id: CornerType.topLeft, child: Box50(Colors.red)),
           LayoutId(id: CornerType.topRight, child: Box50(Colors.yellow)),
           LayoutId(id: CornerType.bottomLeft, child: Box50(Colors.blue)),
           LayoutId(id: CornerType.bottomRight, child: Box50(Colors.green)),
        ],
      ),
    );
  }
}

// 50 颜色盒
class Box50 extends StatelessWidget {
  final Color color;
  Box50(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: color,
    );
  }
}


enum CornerType{
  topLeft,
  topRight,
  bottomLeft,
  bottomRight
}


class CornerCustomMultiChildLayout extends MultiChildLayoutDelegate{
  final EdgeInsets padding;
  
  CornerCustomMultiChildLayout({this.padding = EdgeInsets.zero});

  @override
  void performLayout(Size size) {
    if (hasChild(CornerType.topLeft)) {
      layoutChild(CornerType.topLeft, BoxConstraints.loose(size));
      positionChild(CornerType.topLeft, Offset.zero.translate(padding.left, padding.top));
    }
    if (hasChild(CornerType.topRight)) {
      var childSize = layoutChild(CornerType.topRight, BoxConstraints.loose(size));
      positionChild(CornerType.topRight, Offset(size.width-childSize.width,0).translate(-padding.right, padding.top));
    }
    if (hasChild(CornerType.bottomLeft)) {
      var childSize = layoutChild(CornerType.bottomLeft, BoxConstraints.loose(size));
      positionChild(CornerType.bottomLeft, Offset(0,size.height-childSize.height).translate(padding.left, -padding.bottom));
    }
    if (hasChild(CornerType.bottomRight)) {
      var childSize = layoutChild(CornerType.bottomRight, BoxConstraints.loose(size));
      positionChild(CornerType.bottomRight, Offset(size.width-childSize.width,size.height-childSize.height).translate(-padding.right, -padding.bottom));
    }
  }

  @override
  bool shouldRelayout(CornerCustomMultiChildLayout oldDelegate) => oldDelegate.padding!=padding;
  
}

