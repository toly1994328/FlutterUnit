
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import '../../../layout.dart';
import 'desk_router.dart';



 RouteBase get layoutRoutes => GoRoute(
  path: '/',
  redirect: (_, __) => null,
  routes: [


    // GoRoute(
    //   path: 'start_error',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return AppStartFixListener<AppState>(
    //       child: ErrorPage(
    //         error: state.extra.toString(),
    //       ),
    //     );
    //   },
    // ),
    deskNavRoute
  ],
);
