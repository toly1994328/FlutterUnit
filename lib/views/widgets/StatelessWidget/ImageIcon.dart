import 'package:flutter/material.dart';
import 'package:flutter_unit/components/permanent/panel.dart';


class CustomImageIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = {
      Colors.blue: 50.0,
      Colors.red: 60.0,
      Colors.green: 70.0,
      Colors.yellow: 80.0,
    };
    return Wrap(
      spacing: 10,
      children: data.keys
          .map((e) => ImageIcon(
                AssetImage("assets/images/leaf.png"),
                color: e,
                size: data[e],
              ))
          .toList(),
    );
  }
}
