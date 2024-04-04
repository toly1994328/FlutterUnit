import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toly_menu_manager/view/menu_router_scope.dart';

import '../../../layout.dart';
import '../../views/base/size/size_loss_by_align.dart';
import '../../views/base/size/size_tight_constraint.dart';
import '../../views/base/size/size_display.dart';
import '../../views/test_show.dart';
import '../menu/menu_repository_impl.dart';
import '../view/app_desk_navigation.dart';


 RouteBase get deskNavRoute => ShellRoute(
    builder: (BuildContext context, GoRouterState state, Widget child) {
      return MenuRouterScope(
        repository: MenuRepositoryImpl(),
        child: AppDeskNavigation(content: child),
      );
    },
    routes: [
      GoRoute(
        path: 'home',
        builder: (BuildContext context, GoRouterState state) {
          return const LayoutPage();
        },
      ),
      GoRoute(
        path: 'base/:name',
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
        path: 'multi',
        builder: (_,__)=>Text("暂未实现"),
        routes: [
          GoRoute(
            path: 'row',
            builder: (BuildContext context, GoRouterState state) {
              return TextShow(
                info: 'row',
              );
            },
          ),
          GoRoute(
            path: 'column',
            builder: (BuildContext context, GoRouterState state) {
              return TextShow(
                info: 'column',
              );
            },
          ),          GoRoute(
            path: 'expanded',
            builder: (BuildContext context, GoRouterState state) {
              return TextShow(
                info: 'expanded',
              );
            },
          ),
          GoRoute(
            path: 'holy',
            builder: (BuildContext context, GoRouterState state) {
              return TextShow(
                info: 'holy',
              );
            },
          ),
        ]
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
