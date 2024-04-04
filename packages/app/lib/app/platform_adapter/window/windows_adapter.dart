import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class WindowsAdapter {

  static Future<void> setSize() async {
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    //仅对桌面端进行尺寸设置
      await windowManager.ensureInitialized();
      WindowOptions windowOptions = const WindowOptions(
        size: Size(920,680),
        minimumSize: Size(920/2,690/2),
        center: true,
        backgroundColor: Colors.transparent,
        skipTaskbar: false,
        titleBarStyle: TitleBarStyle.hidden,
      );
      windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.setTitleBarStyle(TitleBarStyle.hidden,windowButtonVisibility: false);
        await windowManager.show();
        await windowManager.focus();
      });
    }
  }

}


class DragToMoveAreaNoDouble extends StatelessWidget {
  final Widget child;

  const DragToMoveAreaNoDouble({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(Platform.isAndroid||Platform.isIOS) return child;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (details) {
        windowManager.startDragging();
      },
      child: child,
    );
  }
}

class DragToMoveWrapper extends StatelessWidget implements PreferredSizeWidget{
  final PreferredSizeWidget child;
  final bool canDouble;

  const DragToMoveWrapper({
    Key? key,
    required this.child,
    this.canDouble = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDesk = kIsWeb || Platform.isMacOS||Platform.isWindows||Platform.isLinux;
    if(!isDesk) return child;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onDoubleTap: !canDouble?null:() async{
        bool isMax = await windowManager.isMaximized();
        if(isMax){
          windowManager.unmaximize();
        }else{
          windowManager.maximize();

        }
      },
      onPanStart: (details) {
        windowManager.startDragging();
      },
      child: child,
    );
  }

  @override
  Size get preferredSize => child.preferredSize;
}