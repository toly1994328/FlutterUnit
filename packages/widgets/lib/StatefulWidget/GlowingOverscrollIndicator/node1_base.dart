import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 250 GlowingOverscrollIndicator 孩子为可滑动列表，当滑动到顶部和底部时的指示效果，可指定颜色，没什么太大卵用。是Android和fuchsia系统默认滑动效果。
//    {
//      "widgetId": 250,
//      "name": '基本使用',
//      "priority": 1,
//      "subtitle":
//          "【showLeading】 : 头部是否生效   【bool】\n"
//          "【showTrailing】 : 底部是否生效   【bool】\n"
//          "【axisDirection】 : 轴向   【AxisDirection】\n"
//          "【color】 : 颜色   【Color】\n"
//          "【child】 : 子组件   【Widget】",
//    }

class GlowingOverscrollIndicatorDemo extends StatelessWidget {
  GlowingOverscrollIndicatorDemo({Key? key}) : super(key: key);

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
    Colors.red[50]!,
    Colors.red[100]!,
    Colors.red[200]!,
    Colors.red[300]!,
    Colors.red[400]!,
    Colors.red[500]!,
    Colors.red[600]!,
    Colors.red[700]!,
    Colors.red[800]!,
    Colors.red[900]!,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: GlowingOverscrollIndicator(
        color: Colors.purple,
        // showLeading: false,
        // showTrailing: false,
        axisDirection: AxisDirection.down,
        child: ListView.builder(
          itemBuilder: (_, index) => Container(
            margin: const EdgeInsets.all(10),
            height: 60,
            color: data[index],
          ),
          itemCount: data.length,
        ),
      ),
    );
  }
}
