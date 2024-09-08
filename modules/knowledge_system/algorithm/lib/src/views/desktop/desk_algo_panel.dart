// Copyright 2014 The 张风捷特烈 . All rights reserved.

// Author:      张风捷特烈
// CreateTime:  2024-07-07
// Contact Me:  1981462002@qq.com

import 'package:flutter/material.dart';

// class LayoutRouterPage extends StatefulWidget {
//   LayoutRouterPage({super.key});
//
//   @override
//   State<LayoutRouterPage> createState() => _LayoutRouterPageState();
// }
//
// class _LayoutRouterPageState extends State<LayoutRouterPage> {
//   final GoRouter _router = GoRouter(
//     initialLocation: '/base/size',
//     routes: <RouteBase>[layoutRoutes],
//     onException: (BuildContext ctx, GoRouterState state, GoRouter router) {
//       router.go('/404', extra: state.uri.toString());
//     },
//   );
//
//   late final DisplayLogic logic;
//
//   @override
//   void initState() {
//     logic = DisplayLogic(DisplayState(
//       router: '/base/size',
//       activeIndex: 0,
//       total: kDisplayMap['/base/size']!.length,
//     ));
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DisplayScope(
//       notifier: logic,
//       child: Column(
//         children: [
//           const Divider(),
//           Expanded(
//             child: Router.withConfig(config: _router),
//           ),
//         ],
//       ),
//     );
//   }
// }

class DeskAlgoPanel extends StatelessWidget {
  const DeskAlgoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(

    );
  }
}
