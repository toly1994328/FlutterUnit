import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:layout/src/navigation/router/app_router.dart';
import 'package:toly_menu_manager/toly_menu_manager.dart';

import '../bloc/display_logic.dart';
import '../bloc/display_state.dart';
import '../data/display_map/display_map.dart';
import '../data/model/display_frame.dart';

class LayoutRouterPage extends StatefulWidget {
  LayoutRouterPage({super.key});

  @override
  State<LayoutRouterPage> createState() => _LayoutRouterPageState();
}

class _LayoutRouterPageState extends State<LayoutRouterPage> {
  final GoRouter _router = GoRouter(
    initialLocation: '/base/size',
    routes: <RouteBase>[layoutRoutes],
    onException: (BuildContext ctx, GoRouterState state, GoRouter router) {
      router.go('/404', extra: state.uri.toString());
    },
  );

  late final DisplayLogic logic;

  @override
  void initState() {
    logic = DisplayLogic(DisplayState(
      router: '/base/size',
      activeIndex: 0,
      total: kDisplayMap['/base/size']!.length,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DisplayScope(
      notifier: logic,
      child: Column(
        children: [
          const Divider(),
          Expanded(child: Router.withConfig(config: _router)),
        ],
      ),
    );
  }

}

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white, child: const Center(child: Text("TODO")));
  }
}
