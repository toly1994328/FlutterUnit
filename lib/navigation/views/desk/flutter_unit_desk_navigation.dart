import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/navigation/menus/menu_meta.dart';
import 'package:go_router/go_router.dart';
import 'package:l10n/l10n.dart';
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
      selectedIndex: activeIndex,
      onAction: _onAction,
      itemData: deskNavBarMenus,
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

    deskNavBarMenus =  [
      MenuMeta(label: widget, icon: TolyIcon.icon_layout, path: '/widget'),
      MenuMeta(label: canvas, icon: Icons.palette, path: '/painter'),
      MenuMeta(label: knowledge, icon: TolyIcon.icon_artifact, path: '/knowledge'),
      MenuMeta(label: treasure, icon: TolyIcon.icon_fast, path: '/tools'),
      MenuMeta(label: account, icon: Icons.person, path: '/account'),
    ];
  }
  
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

  void _onAction(ActionType value) {
    String? path = value.path;
    if(path!=null){
      if(value == ActionType.settings || value == ActionType.collection){
        context.push(path);
      }else{
        context.go(path);
      }
    }
  }
}
