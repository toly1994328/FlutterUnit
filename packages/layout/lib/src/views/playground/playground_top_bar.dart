import 'package:flutter/material.dart';
import 'package:toly_menu/toly_menu.dart';
import 'package:toly_menu_manager/toly_menu_manager.dart';

import '../../bloc/display_logic.dart';
import '../../bloc/display_state.dart';
import '../../data/model/display_frame.dart';

class PlaygroundTopBar extends StatelessWidget {
  const PlaygroundTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    DisplayState state = DisplayScope.of(context).state;
    DisplayFrame frame = state.frame;

    return Container(
      color: Color(0xfff2f2f2),
      padding: EdgeInsets.symmetric(horizontal: 12),
      height: 46,
      child: NavigationToolbar(
        centerMiddle: true,
        leading: UnconstrainedBox(
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text('当前: ${state.activeIndex+1}/${state.total}',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold
                ),
              )),
        ),
        middle: Text(frame.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
        trailing: Wrap(
          children: [
            IconButton(
              onPressed: () {
                DisplayScope.of(context).prevPage();

              },
              icon: Icon(Icons.skip_previous),
            ),
            IconButton(
              onPressed: () {
                DisplayScope.of(context).nextPage();
              },
              icon: Icon(Icons.skip_next),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.code),
            )
          ],
        ),
      ),
    );

    return Container(
      color: Color(0xfff2f2f2),
      padding: EdgeInsets.symmetric(horizontal: 12),
      height: 42,
      child: Row(
        children: [
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.code))
        ],
      ),
    );
  }
}
