import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/navigation/menus/menu_meta.dart';
import 'package:go_router/go_router.dart';
import 'unit_rail_navigation.dart';

class FlutterUnitDeskNavigation extends StatelessWidget {
  final Widget content;
  const FlutterUnitDeskNavigation({super.key, required this.content});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          DeskNavigationRail(),
          Expanded(child: content),
        ],
      ),
    );
  }


}

class DeskNavigationRail extends StatefulWidget {
  const DeskNavigationRail({super.key});

  @override
  State<DeskNavigationRail> createState() => _DeskNavigationRailState();
}

class _DeskNavigationRailState extends State<DeskNavigationRail> {
  @override
  Widget build(BuildContext context) {
    return UnitRailNavigation(
      selectedIndex: activeIndex??0,
      onItemClick: _onItemClick, itemData: deskNavBarMenus,
    );
  }

  final List<MenuMeta> deskNavBarMenus = const [
    MenuMeta(label: '组件集录', icon: TolyIcon.icon_layout, path: '/widget'),
    MenuMeta(label: '绘制集录', icon: Icons.palette, path: '/gallery'),
    MenuMeta(label: '知识集锦', icon: TolyIcon.icon_artifact, path: '/knowledge'),
    MenuMeta(label: '收藏集录', icon: TolyIcon.icon_star, path: '/collection'),
    MenuMeta(label: '算法演绎', icon: Icons.person, path: '/algorithm'),
    MenuMeta(label: '工具宝箱', icon: TolyIcon.icon_fast, path: '/tools'),
  ];

  final RegExp _segReg = RegExp(r'/\w+');

  int? get activeIndex {
    final String path = GoRouterState.of(context).uri.toString();
    RegExpMatch? match = _segReg.firstMatch(path);
    if (match == null) return null;
    String? target = match.group(0);
    int index = deskNavBarMenus.indexWhere((menu) => menu.path!.contains(target??''));
    if (index == -1) return null;
    return index;
  }

  void _onItemClick(int index) {
    String path = deskNavBarMenus[index].path!;
    GoRouter.of(context).go(path);
  }

}
