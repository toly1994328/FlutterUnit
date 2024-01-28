// import 'package:algorithm/algorithm.dart';
// import 'package:app/app.dart';
// import 'package:artifact/artifact.dart';
// import 'package:draw_system/draw_system.dart';
// import 'package:flutter/material.dart';
// import 'package:treasure_tools/treasure_tools.dart';
// import 'package:widget_module/views/mobile/widget_page/home_drawer.dart';
// import 'package:widget_module/widget_module.dart';
// import '../../menus/menu_meta.dart';
// import 'unit_rail_navigation.dart';
//
// class UnitDeskNavigation extends StatefulWidget {
//
//   const UnitDeskNavigation();
//
//   @override
//   _UnitDeskNavigationState createState() => _UnitDeskNavigationState();
//
// }
//
// class _UnitDeskNavigationState extends State<UnitDeskNavigation> {
//   late PageController _controller; //页面控制器，初始0
//   int _currentIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = PageController();
//
//     // ActionUnit.searchAction.onSearch = () {
//     //   Navigator.of(context).pushNamed(UnitRouter.search);
//     // };
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose(); //释放控制器
//     super.dispose();
//   }
//
//   // 构建悬浮按钮工具
//   // Widget wrapOverlayTool({required Widget child}) => Builder(
//   //     builder: (ctx) => OverlayToolWrapper(
//   //       child: child,
//   //     ));
//   final List<MenuMeta> deskNavBarMenus = const [
//     MenuMeta(label: '组件集录', icon: TolyIcon.icon_layout, path: '/widget'),
//     MenuMeta(label: '绘制集录', icon: Icons.palette, path: '/draw'),
//     MenuMeta(label: '知识集锦', icon: TolyIcon.icon_artifact, path: '/knowledge'),
//     MenuMeta(label: '收藏集录', icon: TolyIcon.icon_star, path: '/collection'),
//     MenuMeta(label: '算法演绎', icon: Icons.person, path: '/algorithm'),
//     MenuMeta(label: '工具宝箱', icon: TolyIcon.icon_fast, path: '/tools'),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//           drawer: const HomeDrawer(),
//           endDrawer: const HomeRightDrawer(),
//           body: Row(
//             children: [
//               UnitRailNavigation(
//                 selectedIndex: _currentIndex,
//                 onItemClick: _onItemClick, itemData: deskNavBarMenus
//               ),
//               // _buildLeftNav(),
//               Expanded(
//                 child: PageView(
//                   physics: const NeverScrollableScrollPhysics(),
//                   //使用PageView实现页面的切换
//                   controller: _controller,
//                   children: const <Widget>[
//                     DeskWidgetPanel(),
//                     CollectPageAdapter(),
//                     GalleryUnit(),
//                     DeskSortPage(),
//                     CodeGenPage(),
//                     DeskPointPage(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//   }
//
//   void _onItemClick(int value) {
//     _currentIndex = value;
//     _controller.jumpToPage(_currentIndex);
//     setState(() {
//
//     });
//   }
// }
//
