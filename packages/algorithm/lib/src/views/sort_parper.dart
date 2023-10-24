
import 'package:flutter/material.dart';

import '../data_scope/state.dart';
import 'data_painter.dart';

class SortPaper extends StatelessWidget{
  const SortPaper({super.key});


  @override
  Widget build(BuildContext context) {
    SortState state = SortStateScope.of(context);
    List<int> numbers = state.data;

    return CustomPaint(
      painter: DataPainter(data: numbers),
      child: ConstrainedBox(constraints: BoxConstraints.expand()),
    );
  }
}


