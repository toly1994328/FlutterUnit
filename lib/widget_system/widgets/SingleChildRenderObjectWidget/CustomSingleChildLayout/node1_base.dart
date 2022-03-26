import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/6/3
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 285,
//      "name": 'CustomSingleChildLayout基本使用',
//      "priority": 1,
//      "subtitle":
//          "【delegate】 : 代理   【SingleChildLayoutDelegate】",
//    }

class CustomSingleChildLayoutDemo extends StatelessWidget {
  const CustomSingleChildLayoutDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-------CustomSingleChildLayoutDemo------');
    return Container(
      width: 300,
      height: 200,
      color: Colors.grey.withAlpha(11),
      child: CustomSingleChildLayout(
        delegate: _TolySingleChildLayoutDelegate(),
        child: Container(
          color: Colors.orange,
        ),
      ),
    );
  }
}

class _TolySingleChildLayoutDelegate extends SingleChildLayoutDelegate {
  @override
  bool shouldRelayout(SingleChildLayoutDelegate oldDelegate) {
    return true;
  }

  @override
  Size getSize(BoxConstraints constraints) {
    print('----getSize:----constraints:$constraints----');
    return super.getSize(constraints);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    print('----getPositionForChild: size:$size----childSize:$childSize----');
    return Offset(size.width / 2, 0);
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    print('----getConstraintsForChild:----constraints:$constraints----');
    return BoxConstraints(
      maxWidth: constraints.maxWidth / 2,
      maxHeight: constraints.maxHeight / 2,
      minHeight: constraints.maxHeight / 4,
      minWidth: constraints.maxWidth / 4,
    );
  }
}