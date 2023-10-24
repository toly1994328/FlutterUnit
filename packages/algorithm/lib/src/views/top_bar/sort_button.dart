import 'package:algorithm/algorithm.dart';
import 'package:flutter/material.dart';

import '../../data_scope/state.dart';



class SortButton extends StatelessWidget {
  const SortButton({super.key});

  @override
  Widget build(BuildContext context) {
    SortState state = SortStateScope.of(context);
    VoidCallback? action;
    IconData icon;
    Color color;
    switch (state.status) {
      case SortStatus.none:
        icon = Icons.not_started_outlined;
        color = Colors.green;
        action = state.sort;
        break;
      case SortStatus.sorting:
        icon = Icons.stop_circle_outlined;
        color = Colors.grey;
        action = null;
        break;
      case SortStatus.sorted:
        icon = Icons.refresh;
        color = Colors.black;
        action = state.reset;
        break;
    }

    return GestureDetector(
      onTap: action,
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}
