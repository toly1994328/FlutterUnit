
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com
/// 说明: 351 InteractiveViewer 交互视图 主要对移动、缩放等手势交互进行封装，简化使用，可指定移动边界、缩放比例、手势监听等。
//    {
//      "widgetId": 351,
//      "name": "InteractiveViewer基本使用",
//      "priority": 1,
//      "subtitle": "【alignPanAxis】 : 沿轴拖动   【bool】\n"
//          "【boundaryMargin】 : 边界边距   【EdgeInsets】\n"
//          "【panEnabled】 : 是否可平移   【bool】\n"
//          "【scaleEnabled】 : 是否可缩放   【bool】\n"
//          "【maxScale】 : 最大放大倍数   【double】\n"
//          "【minScale】 : 最小缩小倍数   【double】\n"
//          "【onInteractionEnd】 : 交互结束回调   【GestureScaleEndCallback】\n"
//          "【onInteractionStart】 : 交互开始回调   【GestureScaleStartCallback】\n"
//          "【onInteractionUpdate】 : 交互更新回调   【GestureScaleUpdateCallback】\n"
//          "【child】 : 游标颜色   【Widget】",
//    }

class InteractiveViewerDemo extends StatelessWidget {
  const InteractiveViewerDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Colors.grey.withAlpha(33),
      child: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(40.0),
        maxScale: 2.5,
        minScale: 0.3,
        panEnabled: true,
        scaleEnabled: true,
        child: Image.asset('assets/images/caver.webp'),
        onInteractionStart: _onInteractionStart,
        onInteractionUpdate: _onInteractionUpdate,
        onInteractionEnd: _onInteractionEnd,
      ),
    );
  }

  void _onInteractionStart(ScaleStartDetails details) {
    print('onInteractionStart----' + details.toString());
  }

  void _onInteractionUpdate(ScaleUpdateDetails details) {
    print('onInteractionUpdate----' + details.toString());
  }

  void _onInteractionEnd(ScaleEndDetails details) {
    print('onInteractionEnd----' + details.toString());
  }
}
