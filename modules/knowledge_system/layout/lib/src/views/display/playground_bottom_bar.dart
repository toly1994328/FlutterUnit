import 'package:flutter/material.dart';
import 'package:layout/src/bloc/display_logic.dart';

import '../../data/model/display_frame.dart';

class PlaygroundBottomBar extends StatelessWidget {
  /// 是否使用移动端说明样式。
  final bool mobile;

  const PlaygroundBottomBar({super.key, this.mobile = false});

  @override
  Widget build(BuildContext context) {
    DisplayFrame frame = DisplayScope.of(context).state.frame;
    if (mobile) {
      return Container(
        width: double.maxFinite,
        color: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
        child: Text(
          frame.desc,
          style: TextStyle(
            height: 1.5,
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }
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
