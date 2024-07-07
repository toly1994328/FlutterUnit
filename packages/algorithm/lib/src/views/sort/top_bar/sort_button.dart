import 'package:algorithm/algorithm.dart';
import 'package:flutter/material.dart';
import 'package:tolyui/tolyui.dart';

import '../../../finding/data_scope/finding_state.dart';

class FindingButton extends StatelessWidget {
  const FindingButton({super.key});

  @override
  Widget build(BuildContext context) {
    FindingState state = FindingStateScope.of(context);
    VoidCallback? action;
    IconData icon;
    String? tip;
    Color color;
    switch (state.status) {
      case FindingStatus.none:
        icon = Icons.not_started_outlined;
        color = Colors.green;
        action = state.run;
        tip = '运行';
        break;
      case FindingStatus.finding:
        icon = Icons.stop_circle_outlined;
        color = Colors.grey;
        tip = '排序中';
        action = null;
        break;
      case FindingStatus.find:
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
