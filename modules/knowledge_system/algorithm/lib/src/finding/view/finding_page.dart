import 'package:algorithm/src/finding/view/board.dart';
import 'package:flutter/material.dart';
import 'finding_tool_bar.dart';

class FindingPage extends StatelessWidget {
  const FindingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: FindingToolBar(),
        body: Column(
          children: [
            Expanded(child: MazeBoard()),
          ],
        ));
  }
}
