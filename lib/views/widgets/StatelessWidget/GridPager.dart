import 'package:flutter/material.dart';
import 'package:flutter_unit/components/panel/panel.dart';
import 'package:flutter_unit/model/node.dart';

class GridPagerPage extends StatelessWidget {
  final List<Node> nodes;

  GridPagerPage({this.nodes});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: nodes
            .map((node) => NodePanel(
                  text: node.name,
                  subText: node.subtitle,
                  code: node.code,
                  show: node.widget,
                ))
            .toList());
  }
}

class CustomGridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 100,
        child: GridPaper(
            color: Colors.red,
            interval: 50,
            child: Image.asset(
              "assets/images/wy_300x200.jpg",
              fit: BoxFit.cover,
            )));
  }
}

class DivisionsGridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 100,
        child: GridPaper(
            color: Colors.red,
            interval: 50,
            divisions: 4,
            subdivisions: 4,
            child: Image.asset(
              "assets/images/wy_300x200.jpg",
              fit: BoxFit.cover,
            )));
  }
}
