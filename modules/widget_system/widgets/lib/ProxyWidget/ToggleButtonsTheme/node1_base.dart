import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com
/// 说明: 332 ToggleButtonsTheme 主要用于为后代的ToggleButtons组件统一设置默认属性,也可以通过该组件获取默认ToggleButtons的属性。
//    {
//      "widgetId": 332,
//      "name": "ToggleButtonsTheme基本使用",
//      "priority": 1,
//      "subtitle": "可指定ToggleButtonsThemeData数据属性为【后代】的ToggleButtons组件设置默认样式，如边框样式、颜色、装饰等。也可以用ToggleButtonsTheme.of获取ToggleButtons的主题数据。",
//    }

class ToggleButtonsThemeDemo extends StatelessWidget {
  const ToggleButtonsThemeDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToggleButtonsTheme(
      data: ToggleButtonsTheme.of(context).copyWith(
        borderWidth: 1,
        borderColor: Colors.orangeAccent,
        selectedBorderColor: Colors.blue,
        splashColor: Colors.purple.withAlpha(66),
        borderRadius: BorderRadius.circular(10),
        selectedColor: Colors.red,
        fillColor: Colors.green.withAlpha(11),
      ),
      child: _ToggleButtonsSimple(),
    );
  }
}


class _ToggleButtonsSimple extends StatefulWidget {
  @override
  _ToggleButtonsSimpleState createState() => _ToggleButtonsSimpleState();
}

class _ToggleButtonsSimpleState extends State<_ToggleButtonsSimple> {
  var _isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: const[
        Icon(Icons.skip_previous),
        Icon(Icons.pause),
        Icon(Icons.skip_next),
      ],
      isSelected: _isSelected,
      onPressed: (value) => setState(() {
        _isSelected = _isSelected.map((e) => false).toList();
        _isSelected[value] = true;
      }),
    );
  }
}