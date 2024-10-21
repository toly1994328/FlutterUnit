import 'package:flutter/material.dart';

const List<Color> kColors3 = [Colors.blue,Colors.red,  Colors.green, Colors.orange];

class PageViewDemo01 extends StatelessWidget {
  PageViewDemo01({super.key});

  final List<Color> data = List.generate(128, (i) => Color(0xFFFF00FF - 2 * i));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PageView.builder(
          itemCount: 8,
          itemBuilder: (_, index) {
            Color color = kColors3[index % kColors3.length];
            return Container(
              color: color,
              alignment: Alignment.center,
              child: Text(
                'Page ${index + 1}\n${colorString(color)}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            );
          }),
    );
  }

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}
