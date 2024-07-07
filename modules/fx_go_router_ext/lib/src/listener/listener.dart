// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-05-25
// Contact Me:  1981462002@qq.com

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

mixin RouterChangeListenerMixin<T extends StatefulWidget> on State<T> {
  late GoRouterDelegate _delegate;

  String get path => '/${_delegate.currentConfiguration.matches.last.matchedLocation}';

  @override
  void initState() {
    super.initState();
    _delegate = GoRouter.of(context).routerDelegate;
    _delegate.addListener(_onChange);
  }

  @override
  void dispose() {
    _delegate.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() {
    RouteMatchBase match = _delegate.currentConfiguration.matches.last;
    onChangeRoute("/${match.matchedLocation}");
  }

  void onChangeRoute(String path);
}
