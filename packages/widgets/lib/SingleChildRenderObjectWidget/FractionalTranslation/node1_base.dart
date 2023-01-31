import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com
/// 说明: 263 FractionalTranslation 通过offset属性将子组件进行偏移,偏移量为OffSet横纵*子组件大小。
//    {
//      "widgetId": 263,
//      "name": "FractionalTranslation基本使用",
//      "priority": 1,
//      "subtitle": "【translation】 : 偏移分度值   【Offset】\n"
//          "【child】: 子组件    【Widget】",
//    }

class FractionalTranslationDemo extends StatefulWidget {
  const FractionalTranslationDemo({Key? key}) : super(key: key);

  @override
  _FractionalTranslationDemoState createState() =>
      _FractionalTranslationDemoState();
}

class _FractionalTranslationDemoState extends State<FractionalTranslationDemo> {
  double dx = 0.0;
  double dy = 0.0;

  @override
  Widget build(BuildContext context) {
    print(dx);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 200,
          height: 100,
          alignment: Alignment.topLeft,
          color: Colors.grey.withAlpha(33),
          child: FractionalTranslation(
            translation: Offset(dx, dy),
            child: const Icon(
              Icons.android,
              color: Colors.green,
            ),
          ),
        ),
        _buildSliderX(),
        _buildSliderY()
      ],
    );
  }

  Widget _buildSliderX() => Slider(
        min: -2.0,
        max: 10.0,
        value: dx,
    divisions: 100,
        label: 'dx:${dx.toStringAsFixed(1)}',
        onChanged: (v) => setState(() => dx = v),
      );


  Widget _buildSliderY() => Slider(
    min: -2.0,
    max: 6.0,
    value: dy,
    divisions: 100,
    label: 'dy:${dy.toStringAsFixed(1)}',
    onChanged: (v) => setState(() => dy = v),
  );
}
