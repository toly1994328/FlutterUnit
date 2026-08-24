import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../views/base/size/size_display.dart';
import '../view/app_desk_navigation.dart';

RouteBase get deskNavRoute => ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return AppDeskNavigation(content: child);
        },
        routes: [
          GoRoute(
            path: 'home',
            builder: (BuildContext context, GoRouterState state) {
              return const FrameDisplayPanel();
            },
          ),
          GoRoute(
            path: 'base/:name',
            builder: (BuildContext context, GoRouterState state) {
              return const FrameDisplayPanel();
            },
          ),
          GoRoute(
            path: 'scroll/:name',
            builder: (BuildContext context, GoRouterState state) {
              return const FrameDisplayPanel();
            },
          ),
          GoRoute(
            path: 'popable/:name',
            builder: (BuildContext context, GoRouterState state) {
              return const FrameDisplayPanel();
            },
          ),
          GoRoute(
            path: 'multi/:name',
            builder: (BuildContext context, GoRouterState state) {
              return const FrameDisplayPanel();
            },
          ),
          // GoRoute(
          //   path: 'text/gen/secret',
          //   builder: (BuildContext context, GoRouterState state) {
          //     return SecretGenPage();
          //   },
          // ),
          // GoRoute(
          //   path: 'text/:name',
          //   pageBuilder: (BuildContext context, GoRouterState state) {
          //     return CustomTransitionPage(
          //       key: ValueKey(state.uri.path),
          //         // transitionDuration: const Duration(milliseconds: 500),
          //         // reverseTransitionDuration: const Duration(milliseconds: 500),
          //         child: ToolListPanel(
          //             key: ValueKey(state.fullPath??''),
          //             name: state.pathParameters['name'] ?? ''),
          //         transitionsBuilder: (BuildContext context,
          //             Animation<double> animation,
          //             Animation<double> secondaryAnimation,
          //             Widget child) {
          //           return FadeTransition(
          //             opacity: animation.drive(CurveTween(curve: Curves.easeIn)),
          //             child: child,
          //           );
          //         });
          //   },
          // ),
        ]);
