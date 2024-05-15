import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:l10n/l10n.dart';
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
          const DragToMoveAreaNoDouble(child: DeskNavigationRail()),
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
    String widget = context.l10n.widgetCollection;
    String canvas = context.l10n.paintCollection;
    String knowledge = context.l10n.knowledgeCollection;
    String treasure = context.l10n.treasureTools;
    String account = context.l10n.homeAccount;

    deskNavBarMenus = [
      MenuMeta(label: widget, icon: TolyIcon.icon_layout, router: '/widget'),
      MenuMeta(label: canvas, icon: Icons.palette, router: '/painter'),
      MenuMeta(label: knowledge, icon: TolyIcon.icon_artifact, router: '/knowledge'),
      MenuMeta(label: treasure, icon: TolyIcon.icon_fast, router: '/tools'),
      MenuMeta(label: account, icon: Icons.person, router: '/account'),
    ];
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
