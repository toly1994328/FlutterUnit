import 'package:flutter/material.dart';

class GridViewDemo01 extends StatelessWidget {
   GridViewDemo01({super.key});

  final List<Color> data = List.generate(128, (i) => Color(0xFFFF00FF - 2 * i));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 1 / 0.618,
        children: data.map((color) => _buildItem(color)).toList(),
      ),
    );
  }

  Container _buildItem(Color color) => Container(
    alignment: Alignment.center,
    width: 100,
    height: 30,
    color: color,
    child: Text(
      colorString(color),
      style: const TextStyle(
        color: Colors.white,
        shadows: [
          Shadow(color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)
        ],
      ),
    ),
  );

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";

}
