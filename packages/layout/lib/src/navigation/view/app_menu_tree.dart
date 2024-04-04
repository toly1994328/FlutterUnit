import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toly_menu/toly_menu.dart';
import 'package:toly_menu_manager/toly_menu_manager.dart';

import '../../bloc/display_logic.dart';

class AppMenuTree extends StatelessWidget {
  final MenuState state;

  const AppMenuTree({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return MenuRouterChangeListener(
        onRouterChanged: _onMenuRouterChange,
        child: TolyMenu(
          activeColor: Color(0xffe6edf3),
          backgroundColor: Colors.white,
          expandBackgroundColor: Colors.white,
          labelTextStyle: TextStyle(color: Color(0xff2d3a53)),
          state: state,
          onSelect: (v) => _onSelect(context, v),
        ));
  }

  void _onMenuRouterChange(BuildContext context, String? path) {
    if (path != null) {
      context.go(path);
      DisplayScope.of(context).active(path);
    }
  }

  void _onSelect(BuildContext context, MenuNode menu) {
    print(menu.path);
    context.selectMenu(menu);
  }
}
