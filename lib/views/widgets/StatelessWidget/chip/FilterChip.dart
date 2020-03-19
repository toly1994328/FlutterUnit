import 'package:flutter/material.dart';

class CustomFilterChip extends StatefulWidget {
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
  List<String> _selected = <String>[];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Wrap(
          children: map.keys.map((key) =>
              _buildChild(key)).toList(),
        ),
        Container(
            padding: EdgeInsets.all(10),
            child: Text('您已选择: ${_selected.join(', ')}')),
      ],
    );
  }

  Padding _buildChild(String key) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FilterChip(
        selectedColor: Colors.orange.withAlpha(55),
        selectedShadowColor: Colors.blue,
        shadowColor: Colors.orangeAccent,
        pressElevation: 5,
        elevation: 3,
        avatar: CircleAvatar(child: Text(key)),
        label: Text(map[key]),
        selected: _selected.contains(map[key]),
        onSelected: (bool value) {
          setState(() {
            if (value) {
              _selected.add(map[key]);
            } else {
              _selected.removeWhere((name) => name == map[key]);
            }
          });
        },
      ),
    );
  }
}

//class FilterChipPage extends StatefulWidget {
//  @override
//  _FilterChipPageState createState() => _FilterChipPageState();
//}
//
//class _FilterChipPageState extends State<FilterChipPage> {
//
//  final Map<String, String> map = {
//    'A': 'Ant',
//    'B': 'Bug',
//    'C': 'Cat',
//    'D': 'Dog',
//  };
//
//  List<String> _filters = <String>[];
//
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//        Wrap(
//          children: map.keys.map((key) => _buildChild(key)).toList(),
//        ),
//        Text('您已选择: ${_filters.join(', ')}'),
//      ],
//    );
//  }
//
//  Padding _buildChild(String key) {
//    return Padding(
//      padding: const EdgeInsets.all(4.0),
//      child: FilterChip(
//        selectedColor: Colors.orange.withAlpha(55),
//        selectedShadowColor:Colors.blue ,
//        shadowColor: Colors.orangeAccent,
//        elevation: 3,
//        avatar: CircleAvatar(child: Text(key)),
//        label: Text(map[key]),
//        selected: _filters.contains(map[key]),
//        onSelected: (bool value) {
//          setState(() {
//            if (value) {
//              _filters.add(map[key]);
//            } else {
//              _filters.removeWhere((String name) => name == map[key]);
//            }
//          });
//        },
//      ),
//    );
//  }
//}
