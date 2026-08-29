import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:layout/src/navigation/router/app_router.dart';

import '../bloc/display_logic.dart';
import '../bloc/display_state.dart';
import '../data/display_map/display_map.dart';
import 'mobile/mobile_layout_knowledge_page.dart';

class LayoutRouterPage extends StatefulWidget {
  /// 是否使用适合手机宽度的紧凑导航。
  final bool compact;

  const LayoutRouterPage({super.key, this.compact = false});

  @override
  State<LayoutRouterPage> createState() => _LayoutRouterPageState();
}

class _LayoutRouterPageState extends State<LayoutRouterPage> {
  late final GoRouter _router;

  late final DisplayLogic logic;

  @override
  void initState() {
    _router = GoRouter(
      initialLocation: '/home',
      routes: <RouteBase>[layoutRoutes],
      onException: (BuildContext ctx, GoRouterState state, GoRouter router) {
        router.go('/home');
      },
    );
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
    if (widget.compact) {
      return const MobileLayoutKnowledgePage();
    }
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
