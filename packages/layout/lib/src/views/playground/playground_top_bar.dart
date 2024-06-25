import 'package:flutter/material.dart';
import 'package:tolyui/basic/basic.dart';

import '../../bloc/display_logic.dart';
import '../../bloc/display_state.dart';
import '../../data/model/display_frame.dart';

class PlaygroundTopBar extends StatelessWidget {
  const PlaygroundTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    DisplayState state = DisplayScope.of(context).state;
    DisplayFrame frame = state.frame;
    const ActionStyle style = ActionStyle.light(backgroundColor: Color(0xffd5d5d5));
    return Container(
      color: const Color(0xfff2f2f2),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 46,
      child: NavigationToolbar(
        centerMiddle: true,
        leading: UnconstrainedBox(
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '当前: ${state.activeIndex + 1}/${state.total}',
                style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              )),
        ),
        middle: Text(
          frame.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        trailing: Wrap(
          children: [
            TolyAction(
                style: style,
                child: const Icon(Icons.skip_previous, size: 20),
                onTap: () {
                  DisplayScope.of(context).prevPage();
                }),
            TolyAction(
                style: style,
                child: const Icon(Icons.skip_next, size: 20),
                onTap: () {
                  DisplayScope.of(context).nextPage();
                }),
            TolyAction(style: style, child: const Icon(Icons.code, size: 20), onTap: () {}),
          ],
        ),
      ),
    );
  }
}
