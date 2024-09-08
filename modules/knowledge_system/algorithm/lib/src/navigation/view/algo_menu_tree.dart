import 'package:algorithm/algorithm.dart';
import 'package:flutter/material.dart';
import 'package:fx_go_router_ext/fx_go_router_ext.dart';
import 'package:tolyui/tolyui.dart';

import '../../finding/data_scope/finding_state.dart';
import '../menu/algo_menu.dart';
import 'package:path/path.dart' as p ;

import 'algo_menu_cell.dart';

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
    MenuNode root = MenuNode.fromMap(algoMenus);
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
      enableWidthChange: true,
      maxWidth: 360,
      width: 190,
      meta: _menuMeta,
      builder: (node, display) => AlgoMenuCell(
        menuNode: node,
        display: display,
      ),
      backgroundColor: backgroundColor,
      expandBackgroundColor: expandBackgroundColor,
      onSelect: _onSelect,
    );
  }


  void _onSelect(MenuNode menu) {
    if (menu.isLeaf) {
      FindingState state = FindingStateScope.read(context);
      if(state.status==FindingStatus.finding){
        $message.warning(message: '正在寻路中,请稍后');
        return;
      }
      context.go(menu.id);
    } else {
      _menuMeta = _menuMeta.select(menu, singleExpand: true);
      setState(() {});
    }
  }

  @override
  void reassemble() {
    MenuNode root = MenuNode.fromMap(algoMenus);
    _menuMeta = _menuMeta.copyWith(root: root);
    super.reassemble();
  }

  @override
  void onChangeRoute(String path) {
    if(path.startsWith('/sort')){
      SortState state = SortStateScope.of(context);
      state.config = state.config.copyWith(name: p.basename(path));
    }else{
      FindingState state = FindingStateScope.read(context);
      state.changeAlgo(p.basename(path));
    }

    _menuMeta = _menuMeta.selectPath(path, singleExpand: true);
    setState(() {});
  }
}
