import 'dart:io';
import 'dart:ui';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';

class WindowSizeHelper{

  static Future<void> setFixSize({Size size = const Size(800,600)}) async{
    bool isDesk = Platform.isMacOS||Platform.isWindows||Platform.isLinux;
    if(isDesk){
      // size = size*window.devicePixelRatio;
      await DesktopWindow.setWindowSize(size);
      await DesktopWindow.setMinWindowSize(size);
      await DesktopWindow.setMaxWindowSize(size);
    }
  }
}