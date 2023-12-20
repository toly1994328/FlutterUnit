import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../menu_meta.dart';


final List<MenuMeta> deskNavBarMenus = const [
  MenuMeta(label: '组件集录', icon: Icons.color_lens_outlined, path: '/widgets'),
  MenuMeta(label: '收藏集录', icon: Icons.add_chart, path: '/collection'),
  MenuMeta(label: '绘制集录', icon: Icons.sort, path: '/painter'),
  MenuMeta(label: '可视化', icon: Icons.person, path: '/visual'),
  MenuMeta(label: '代码生成', icon: Icons.settings, path: '/code_gen'),
  MenuMeta(label: '要点集录', icon: Icons.settings, path: '/pointer'),
];


// final RouteBase appRoute = ShellRoute(
//   builder: (BuildContext context, GoRouterState state, Widget child) {
//     return AppNavigation(navigator: child);
//   },
//   routes: <RouteBase>[
//     colorRouters,
//     GoRoute(
//         path: 'counter',
//         builder: (BuildContext context, GoRouterState state) {
//           return const CounterPage();
//         }),
//     sortRouters,
//     GoRoute(
//       path: 'user',
//       builder: (BuildContext context, GoRouterState state) {
//         return const UserPage();
//       },
//     ),
//     GoRoute(
//       path: 'settings',
//       builder: (BuildContext context, GoRouterState state) {
//         return const SettingPage();
//       },
//     ),
//     GoRoute(
//       path: '404',
//       builder: (BuildContext context, GoRouterState state) {
//         String msg = '无法访问: ${state.extra}';
//         return EmptyPanel(msg: msg);
//       },
//     )
//   ],
// );
