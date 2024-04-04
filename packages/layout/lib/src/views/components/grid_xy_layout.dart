import 'package:flutter/material.dart';

typedef XYBuilder = Function((int x, int y));

class GridXYLayout extends StatelessWidget {
  final (int, int) capacity;
  final XYBuilder xyBuilder;
  final bool hasLine;

  const GridXYLayout({
    super.key,
    this.capacity = (2, 2),
    required this.xyBuilder,
    this.hasLine = true,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < capacity.$1; i++) {
      List<Widget> columnChildren = [];
      for (int j = 0; j < capacity.$2; j++) {
        columnChildren.add(Expanded(child: xyBuilder((i, j))));
        if (hasLine && j != capacity.$2 - 1) {
          columnChildren.add(const Divider());
        }
      }
      children.add(Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: columnChildren,
      )));
      if (hasLine && i != capacity.$1 - 1) {
        children.add(const VerticalDivider());
      }
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }
}
