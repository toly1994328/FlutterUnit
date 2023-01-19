import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/20
/// contact me by email 1981462002@qq.com
/// 说明: 328 ChipTheme 主要用于为后代的Chip类型组件统一设置默认属性,也可以通过该组件获取默认Chip的属性。
//    {
//      "widgetId": 328,
//      "name": 'ChipTheme基本使用',
//      "priority": 1,
//      "subtitle": "可指定ChipThemeData数据属性为【后代】的Chip类型组件设置默认样式，属性和Chip属性类似，如阴影、颜色、边距、形状、文字样式等。也可以用ChipTheme.of获取Chip的主题数据。",
//    }
class ChipThemeDemo extends StatelessWidget {
  const ChipThemeDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChipTheme(
      data: ChipTheme.of(context).copyWith(
        selectedColor: Colors.orange.withAlpha(55),
        selectedShadowColor: Colors.blue,
        shadowColor: Colors.orangeAccent,
        pressElevation: 5,
        elevation: 3,
      ),
      child: const CustomFilterChip(),
    );
  }
}

class CustomFilterChip extends StatefulWidget {
  const CustomFilterChip({Key? key}) : super(key: key);

  @override
  _CustomFilterChipState createState() => _CustomFilterChipState();
}

class _CustomFilterChipState extends State<CustomFilterChip> {
  final Map<String, String> map = {
    'A': 'Ant',
    'B': 'Bug',
    'C': 'Cat',
    'D': 'Dog',
  };
  final List<String> _selected = <String>[];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Wrap(
          children: map.keys.map((key) => _buildChild(key)).toList(),
        ),
        Container(
            padding: const EdgeInsets.all(10),
            child: Text('您已选择: ${_selected.join(', ')}')),
      ],
    );
  }

  Padding _buildChild(String key) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FilterChip(
        avatar: CircleAvatar(child: Text(key)),
        label: Text(map[key]!),
        selected: _selected.contains(map[key]),
        onSelected: (bool value) {
          setState(() {
            if (value) {
              _selected.add(map[key]!);
            } else {
              _selected.removeWhere((name) => name == map[key]);
            }
          });
        },
      ),
    );
  }
}
