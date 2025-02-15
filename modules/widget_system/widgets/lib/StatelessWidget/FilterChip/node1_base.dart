/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com

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
    Color themeColor = Theme.of(context).primaryColor;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Wrap(
          children: map.keys.map((key) => _buildChild(themeColor,key)).toList(),
        ),
        Container(
            padding: const EdgeInsets.all(10),
            child: Text('您已选择: ${_selected.join(', ')}')),
      ],
    );
  }

  Padding _buildChild( Color themeColor,String key) {
    bool select =  _selected.contains(map[key]);
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
          selectedColor: themeColor,
          selectedShadowColor: Colors.blue,
          side: BorderSide.none,
          shadowColor: themeColor,
          pressElevation: 5,
          elevation: 2,
          avatarBoxConstraints: BoxConstraints(
            maxWidth: 22,maxHeight: 22
          ),
            checkmarkColor: select?Colors.white:null,
          avatar: CircleAvatar(
            backgroundColor:  select?Colors.blueAccent:null,
              child: Text(key,style: TextStyle(fontSize: 12,color: select?Colors.transparent:null),)),
          label: Text(map[key]!,style: TextStyle(color: select?Colors.white:null),),
          selected: select,
          onSelected: (bool value) => _onSelected(value, key),
        ),
      );
  }

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
