import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tolyui/tolyui.dart';

import '../../bloc/display_logic.dart';
import '../../ext/go_router/listener.dart';
import '../menu/menu_repository_impl.dart';

class AppMenuTree extends StatefulWidget {
  const AppMenuTree({super.key});

  @override
  State<AppMenuTree> createState() => _AppMenuTreeState();
}

class _AppMenuTreeState extends State<AppMenuTree> with RouterChangeListenerMixin {
  late MenuTreeMeta _menuMeta;

  @override
  void initState() {
    super.initState();
    _initTreeMeta();
  }

  void _initTreeMeta() {
    MenuNode root = MenuNode.fromMap(layoutMenus);
    List<String> parts = Uri.parse(path).pathSegments;
    String parentPath = parts.sublist(0, parts.length - 1).join('/');
    _menuMeta = MenuTreeMeta(
      expandMenus: ['/$parentPath'],
      activeMenu: root.find(path),
      root: root,
    );
  }

  @override
  Widget build(BuildContext context) {
    Color expandBackgroundColor = context.isDark ? Colors.black : Colors.transparent;
    Color backgroundColor = context.isDark ? Color(0xff001529) : Colors.white;

    return TolyRailMenuTree(
      leading: const SizedBox(
        height: 18,
      ),
      enableWidthChange: true,
      maxWidth: 360,
      width: 190,
      meta: _menuMeta,
      backgroundColor: backgroundColor,
      expandBackgroundColor: expandBackgroundColor,
      onSelect: _onSelect,
    );
  }

  void _onMenuRouterChange(BuildContext context, String? path) {
    if (path != null) {
      context.go(path);
      DisplayScope.of(context).active(path);
    }
  }

  void _onSelect(MenuNode menu) {
    if (menu.isLeaf) {
      context.go(menu.id);
      print(path);
    } else {
      _menuMeta = _menuMeta.select(menu, singleExpand: true);
      setState(() {});
    }
  }

  @override
  void reassemble() {
    MenuNode root = MenuNode.fromMap(layoutMenus);
    _menuMeta = _menuMeta.copyWith(root: root);
    super.reassemble();
  }

  @override
  void onChangeRoute(String path) {
    _menuMeta = _menuMeta.selectPath(path, singleExpand: true);
    DisplayScope.of(context).active(path);
    setState(() {});
  }
}
