import 'package:flutter/material.dart';

import 'playground_bottom_bar.dart';
import 'playground_top_bar.dart';

class LayoutPlayGround extends StatelessWidget {
  final Widget content;

  const LayoutPlayGround({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlaygroundTopBar(),
          Divider(),
          // Padding(
          //   padding: const EdgeInsets.only(left: 24,top: 12),
          //   child: Text("),
          // ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 24
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.4)
                      ),
                  ),
                  child: content,
                ),
              )),
          Divider(),
          PlaygroundBottomBar()
        ],
      ),
    );
  }
}
