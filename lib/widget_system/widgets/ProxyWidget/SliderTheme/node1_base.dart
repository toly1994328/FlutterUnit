import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-12
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 331,
//      "name": 'SliderTheme使用',
//      "priority": 1,
//      "subtitle": "可通过SliderTheme.of获取Slider主题数据对象，其中包含大量属性用于对Slider的设定。"
//          "可以为ButtonTheme【后代】的按钮组件设置默认样式，包括颜色、形状、尺寸等。",
//    }

class SliderThemeDemo extends StatefulWidget {
  const SliderThemeDemo({Key? key}) : super(key: key);

  @override
  _SliderThemeDemoState createState() => _SliderThemeDemoState();
}

class _SliderThemeDemoState extends State<SliderThemeDemo> {
  double _bliss = 0.5;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(activeTrackColor: Colors.orange),
      child: Slider(
        min: 0.0,
        max: 200.0,
        divisions: 10,
        label: _bliss.toStringAsFixed(1),
        onChanged: (double value) {
          setState(() {
            _bliss = value;
          });
        },
        value: _bliss,
      ),
    );
  }
}