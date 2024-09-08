import 'package:flutter/material.dart';
import 'package:tolyui/tolyui.dart';

import '../../../algorithm.dart';

class SortButton extends StatelessWidget {
  const SortButton({super.key});

  @override
  Widget build(BuildContext context) {
    SortState state = SortStateScope.of(context);
    VoidCallback? action;
    IconData icon;
    String? tip;
    Color color;
    switch (state.status) {
      case SortStatus.none:
        icon = Icons.not_started_outlined;
        color = Colors.green;
        action = state.sort;
        tip = '运行';
        break;
      case SortStatus.sorting:
        icon = Icons.stop_circle_outlined;
        color = Colors.grey;
        tip = '寻路中';
        action = null;
        break;
      case SortStatus.sorted:
        icon = Icons.refresh;
        color = Colors.black;
        action = state.reset;
        tip = '重置';
        break;
    }
    return TolyAction(
      onTap: action,
      tooltip: tip,
      child: Icon(icon, color: color, size: 20),
    );
  }
}
