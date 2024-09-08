import 'package:flutter/material.dart';

import '../../../bloc/display_logic.dart';
import '../../../data/model/display_frame.dart';


class FrameDisplayPanel extends StatelessWidget {
  const FrameDisplayPanel({super.key});

  @override
  Widget build(BuildContext context) {
    DisplayFrame frame = DisplayScope.of(context).state.frame;

    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: frame.display(context),
    );
  }
}
