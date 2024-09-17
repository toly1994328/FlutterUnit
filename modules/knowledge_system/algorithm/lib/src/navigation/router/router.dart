// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-07-07
// Contact Me:  1981462002@qq.com

import 'package:algorithm/algorithm.dart';
import 'package:algorithm/src/finding/view/finding_page.dart';
import 'package:flutter/material.dart';
import 'package:fx_go_router_ext/fx_go_router_ext.dart';

import '../../sort/sort_page.dart';
import '../view/algo_desk_navigation.dart';

RouteBase get algoRoutes => GoRoute(
  path: '/',
  redirect: (_, __) => null,
  routes: [
    ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return  AppDeskNavigation(content: child);
        },
        routes: [
          GoRoute(
            path: 'sort/:name',
            builder: (BuildContext context, GoRouterState state) {
              return const DeskSortPage();
            },
          ),
          GoRoute(
            path: 'finding/:name',
            builder: (BuildContext context, GoRouterState state) {
              return const FindingPage();
            },
          ),
        ])
  ],
);
