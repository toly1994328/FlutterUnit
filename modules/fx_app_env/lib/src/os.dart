// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-07-13
// Contact Me:  1981462002@qq.com

import 'dart:io';

import 'package:flutter/foundation.dart';

enum OS {
  android,
  ios,
  windows,
  macos,
  linux,
  web,
  unknown,
}


class OSChecker {
  bool isAndroid = false;
  bool isIos = false;
  bool isWindows = false;
  bool isMacOS = false;
  bool isLinux = false;
  bool isWeb = false;

  bool isDesktop = false;
  bool isDesktopUI = false;
  bool isMobile = false;

  OSChecker(OS os) {
    isWeb = os == OS.web;
    isAndroid = !isWeb && os == OS.android;
    isIos = !isWeb && os == OS.ios;
    isWindows = !isWeb && os == OS.windows;
    isMacOS = !isWeb && os == OS.macos;
    isLinux = !isWeb && os == OS.linux;

    isDesktop = !isWeb && (isMacOS || isWindows || isLinux);
    isMobile =  !isWeb && (isAndroid || isIos);
    isDesktopUI = isWeb || isDesktop;
  }
}
