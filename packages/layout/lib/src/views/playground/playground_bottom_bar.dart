import 'package:flutter/material.dart';
import 'package:layout/src/bloc/display_logic.dart';
import 'package:toly_menu/toly_menu.dart';
import 'package:toly_menu_manager/toly_menu_manager.dart';

import '../../data/model/display_frame.dart';

class PlaygroundBottomBar extends StatelessWidget {
  const PlaygroundBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    DisplayFrame frame = DisplayScope.of(context).state.frame;
    return Container(
      width: double.maxFinite,
      color: Color(0xfff2f2f2),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      // height: 24,
      child: Text(
        frame.desc,
        style: TextStyle(fontSize: 12, fontFamily: '宋体'),
      ),
      // child: NavigationToolbar(
      //   centerMiddle: true,
      //   middle: Text("${menu??'布局测试'}"),
      //   trailing: IconButton(onPressed: (){
      //
      //   }, icon: Icon(Icons.code)),
      // ),
    );
  }
}
