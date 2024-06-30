import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tolyui/tolyui.dart';

import '../../views/display/layout_playground.dart';
import 'app_menu_tree.dart';

class AppDeskNavigation extends StatelessWidget {
  final Widget content;

  const AppDeskNavigation({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = context.isDark ? Color(0xff001529) : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Row(
        children: [
          const AppMenuTree(),
          Expanded(child: LayoutPlayGround(content: content)),
        ],
      ),
    );
  }
}
