// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-05-25
// Contact Me:  1981462002@qq.com

import 'package:go_router/go_router.dart';

extension GoRouterPath on GoRouter{
  String get path =>  '/${routerDelegate.currentConfiguration.matches.last.matchedLocation}';
}

