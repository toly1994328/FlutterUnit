import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com
/// 说明: 312 PerformanceOverlay 性能浮层 6 可以非常方便地开启性能监测的两个柱图,方便查看刷新界面时帧率的变化情况。
//    {
//      "widgetId": 312,
//      "name": "PerformanceOverlay基本使用",
//      "priority": 1,
//      "subtitle": "使用PerformanceOverlay.allEnabled可以开始所有的监测项。",
//    }

class PerformanceOverlayDemo extends StatelessWidget {
  const PerformanceOverlayDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PerformanceOverlay.allEnabled(

    );
  }
}

