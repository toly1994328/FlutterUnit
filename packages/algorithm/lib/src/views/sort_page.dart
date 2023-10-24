
import 'package:flutter/material.dart';

import '../data_scope/state.dart';
import 'data_painter.dart';

class SortPage extends StatelessWidget{
  const SortPage({super.key});


  @override
  Widget build(BuildContext context) {
    SortState state = SortStateScope.of(context);
    List<int> numbers = state.data;

    return Scaffold(

      body: CustomPaint(
        painter: DataPainter(data: numbers),
        child: ConstrainedBox(constraints: BoxConstraints.expand()),
      ),
    );
  }
}


