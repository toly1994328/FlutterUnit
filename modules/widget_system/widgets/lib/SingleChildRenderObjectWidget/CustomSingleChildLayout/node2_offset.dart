import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/6/3
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 285,
//      "name": 'CustomSingleChildLayout的偏移使用',
//      "priority": 2,
//      "subtitle":
//          "可以利用代理的偏移能力，对子组件进行偏移定位。",
//    }

class OffSetWidgetDemo extends StatelessWidget {
  const OffSetWidgetDemo({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> data = const [
    {
      'offset': Offset(20, 20),
      'direction': Direction.topLeft,
    },
    {
      'offset': Offset(20, -15),
      'direction': Direction.topRight,
    },
    {
      'offset': Offset(-15, 20),
      'direction': Direction.bottomLeft,
    },
    {
      'offset': Offset(-15, 20),
      'direction': Direction.bottomLeft,
    },
    {
      'offset': Offset(15, 20),
      'direction': Direction.bottomLeft,
    },
    {
      'offset': Offset(-15, -15),
      'direction': Direction.topRight,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 20,
        runSpacing: 20,
        children: data
            .map((e) => Container(
                width: 150,
                height: 100,
                alignment: Alignment.topRight,
                color: Colors.grey.withAlpha(11),
                child: OffSetWidget(
                  offset: e['offset'],
                  direction: e['direction'],
                  child: const Icon(
                    Icons.android,
                    size: 30,
                    color: Colors.green,
                  ),
                )))
            .toList());
  }
}

class OffSetWidget extends StatelessWidget {
  final Offset offset;
  final Widget child;
  final Direction direction;

  const OffSetWidget(
      {Key? key, this.offset = Offset.zero,
      required this.child,
      this.direction = Direction.topLeft}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildLayout(
      delegate: _OffSetDelegate(offset: offset, direction: direction),
      child: child,
    );
  }
}

enum Direction { topLeft, topRight, bottomLeft, bottomRight }

class _OffSetDelegate extends SingleChildLayoutDelegate {
  final Offset offset;
  final Direction direction;

  _OffSetDelegate({
    this.offset = Offset.zero,
    this.direction = Direction.topLeft,
  });

  @override
  bool shouldRelayout(_OffSetDelegate oldDelegate) =>
      offset != oldDelegate.offset;

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double w = size.width;
    double h = size.height;
    double wc = childSize.width;
    double hc = childSize.height;

    switch (direction) {
      case Direction.topLeft:
        return offset;
      case Direction.topRight:
        return offset.translate(w - wc - offset.dx * 2, 0);
      case Direction.bottomLeft:
        return offset.translate(0, h - hc - offset.dy * 2);
      case Direction.bottomRight:
        return offset.translate(w - wc - offset.dx * 2, h - hc - offset.dy * 2);
    }
  }
}
