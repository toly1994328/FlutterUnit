import 'package:algorithm/src/finding/data_scope/finding_state.dart';
import 'package:algorithm/src/navigation/router/router.dart';
import 'package:flutter/material.dart';
import 'package:fx_go_router_ext/fx_go_router_ext.dart';

import '../../algorithm.dart';

class AlgoScope extends StatelessWidget {
  final Widget child;

  const AlgoScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SortStateScope(
      notifier: SortState(),
      child: FindingStateScope(
        notifier: FindingState(),
        child: child,
      ),
    );
  }
}

class AlgoRouterPage extends StatefulWidget {
  const AlgoRouterPage({super.key});

  @override
  State<AlgoRouterPage> createState() => _AlgoRouterPageState();
}

class _AlgoRouterPageState extends State<AlgoRouterPage> {
  final GoRouter _router = GoRouter(
    initialLocation: '/finding/BFS',
    routes: <RouteBase>[algoRoutes],
    onException: (BuildContext ctx, GoRouterState state, GoRouter router) {
      router.go('/404', extra: state.uri.toString());
    },
  );

  // late final DisplayLogic logic;

  @override
  void initState() {
    // logic = DisplayLogic(DisplayState(
    //   router: '/base/size',
    //   activeIndex: 0,
    //   total: kDisplayMap['/base/size']!.length,
    // ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Expanded(
          child: Router.withConfig(config: _router),
        ),
      ],
    );
  }
}
