import 'package:flutter/material.dart';

class CustomVerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dataColor = [
      Colors.red, Colors.yellow,
      Colors.blue, Colors.green];
    var dataThickness = [1.0, 2.0, 4.0, 6.0];
    var data = Map.fromIterables(dataColor, dataThickness);
    return Container(
      height: 150,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: dataColor
            .map((e) => VerticalDivider(
          color: e,
          thickness: data[e],
        ))
            .toList(),
      ),
    );
  }
}

class HeightVerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dataColor = [
      Colors.red, Colors.yellow,
      Colors.blue, Colors.green];
    var dataThickness = [10.0, 20.0, 30.0, 40.0];
    var data = Map.fromIterables(dataColor, dataThickness);
    return Container(
      height: 150,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: dataColor
            .map((e) => VerticalDivider(
          color: e,
          indent:data[e],
          endIndent: data[e]*2,
          width: data[e],
          thickness: data[e]/10,
        ))
            .toList(),
      ),
    );
  }
}
