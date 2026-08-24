import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:layout/src/navigation/router/app_router.dart';

import '../bloc/display_logic.dart';
import '../bloc/display_state.dart';
import '../data/display_map/display_map.dart';

class LayoutRouterPage extends StatefulWidget {
  const LayoutRouterPage({super.key});

  @override
  State<LayoutRouterPage> createState() => _LayoutRouterPageState();
}

class _LayoutRouterPageState extends State<LayoutRouterPage> {
  final GoRouter _router = GoRouter(
    initialLocation: '/home',
    routes: <RouteBase>[layoutRoutes],
    onException: (BuildContext ctx, GoRouterState state, GoRouter router) {
      router.go('/404', extra: state.uri.toString());
    },
  );

  late final DisplayLogic logic;

  @override
  void initState() {
    logic = DisplayLogic(DisplayState(
      router: '/home',
      activeIndex: 0,
      total: kDisplayMap['/base/size']!.length,
    ));
    super.initState();
  }

  @override
  void dispose() {
    logic.dispose();
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DisplayScope(
      notifier: logic,
      child: Column(
        children: [
          const Divider(),
          Expanded(
            child: Router.withConfig(config: _router),
          ),
        ],
      ),
    );
  }
}

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LayoutRouterPage();
  }
}
