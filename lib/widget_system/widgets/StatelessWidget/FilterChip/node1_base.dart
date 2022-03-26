/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明:
import 'package:flutter/material.dart';

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
  final List<String> _selected = [];

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

  Padding _buildChild(String key) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
          selectedColor: Colors.orange.withAlpha(55),
          selectedShadowColor: Colors.blue,
          shadowColor: Colors.orangeAccent,
          pressElevation: 5,
          elevation: 3,
          avatar: CircleAvatar(child: Text(key)),
          label: Text(map[key]!),
          selected: _selected.contains(map[key]),
          onSelected: (bool value) => _onSelected(value, key),
        ),
      );

  void _onSelected(bool value, String key) {
    setState(() {
      if (value) {
        _selected.add(map[key]!);
      } else {
        _selected.removeWhere((name) => name == map[key]);
      }
    });
  }
}
