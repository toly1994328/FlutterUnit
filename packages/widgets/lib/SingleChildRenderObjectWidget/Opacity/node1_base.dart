import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 73,
//      "name": 'Opacity基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【opacity】 : 透明度0~1   【double】",
//    }
class CustomOpacity extends StatefulWidget {
  const CustomOpacity({Key? key}) : super(key: key);

  @override
  _CustomOpacityState createState() => _CustomOpacityState();
}

class _CustomOpacityState extends State<CustomOpacity> {
  double _opacity = 0.2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_buildSlider(), _buildOpacity()],
    );
  }

  // 创建Opacity
  Widget _buildOpacity() => Opacity(
        opacity: _opacity,
        child: Image.asset(// 图片
          'assets/images/icon_head.webp',
          width: 100,
        ),
      );
  Widget _buildSlider() => Slider(
      divisions: 20,
      label: _opacity.toString(),
      value: _opacity,
      onChanged: (v) => setState(() => _opacity = v));
}
