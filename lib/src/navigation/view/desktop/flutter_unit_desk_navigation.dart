import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/src/l10n/gen/app_l10n.dart';
import 'package:flutter_unit/src/navigation/model/app_tab.dart';
import 'package:go_router/go_router.dart';
import 'package:tolyui_navigation/tolyui_navigation.dart';
import 'menu_bar_leading.dart';
import 'menu_bar_tail.dart';
import 'toly_unit_menu_cell.dart';
class FlutterUnitDeskNavigation extends StatelessWidget {
  final Widget content;

  const FlutterUnitDeskNavigation({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const DragToMoveWrapper(child: DeskNavigationRail()),
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
    return TolyRailMenuBar(
      cellBuilder: FlutterUnitMenuCell.create,
      width: 130,
      gap: 8,
      padding: EdgeInsets.zero,
      backgroundColor: const Color(0xff2C3036),
      menus: deskNavBarMenus,
      activeId: activePath,
      enableWidthChange: false,
      onSelected: context.go,
      tail: (_) => const MenuBarTail(),
      leading: (_) => const MenuBarLeading(),
    );
  }

  late List<MenuMeta> deskNavBarMenus;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppL10n l10n = AppL10n.of(context);
    deskNavBarMenus = AppTab.values.map((e)=>e.menu(l10n)).toList();
  }

  final RegExp _segReg = RegExp(r'/\w+');

  String? get activePath {
    final String path = GoRouterState.of(context).uri.toString();
    RegExpMatch? match = _segReg.firstMatch(path);
    if (match == null) return null;
    String? target = match.group(0);
    return target;
  }
}
