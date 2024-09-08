import 'package:flutter/material.dart';

class RowShow extends StatelessWidget {
  const RowShow({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Color(0xffe64032),
      Color(0xff307dee),
      Color(0xfff9c01f),
      Color(0xff309949),
    ];
    return Row(
      children: [
        Container(width: 20, height: 20, color: colors[0]),
        Container(width: 10, height: 80, color: colors[1]),
        Container(width: 40, height: 30, color: colors[2]),
        Container(width: 60, height: 20, color: colors[3]),
      ],
    );
  }
}
