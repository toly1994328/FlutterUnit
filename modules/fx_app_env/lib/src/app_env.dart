// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-07-13
// Contact Me:  1981462002@qq.com

import 'dart:io';

import 'package:flutter/foundation.dart';

import 'os.dart';

AppEnv kAppEnv = AppEnv();

class AppEnv {
  late OS _os;
  late OSChecker _checker;

  OS get os => _os;

  AppEnv() {
    _os = _initOS();
    _checker = OSChecker(os);
  }

  OS _initOS() {
    if (kIsWeb) return OS.web;
    if (Platform.isWindows) return OS.windows;
    if (Platform.isMacOS) return OS.macos;
    if (Platform.isLinux) return OS.linux;
    if (Platform.isIOS) return OS.ios;
    if (Platform.isAndroid) return OS.android;
    return OS.unknown;
  }

  bool get isAndroid => _checker.isAndroid;

  bool get isIos => _checker.isIos;

  bool get isWindows => _checker.isWindows;

  bool get isMacOS => _checker.isMacOS;

  bool get isLinux => _checker.isLinux;

  bool get isWeb => _checker.isWeb;

  bool get isDesktop => _checker.isDesktop;

  bool get isDesktopUI => _checker.isDesktopUI;

  bool get isMobile => _checker.isMobile;
}
