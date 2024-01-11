import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef WidthConditionFun = bool Function(double width);
typedef WidgetBuilder = Widget Function(BuildContext context);

enum ViewAdapterType { width, platform }

class PlatformViewAdapter extends StatelessWidget {
  final Widget mobile;
  final Widget desk;
  final ViewAdapterType type;

  const PlatformViewAdapter({
    super.key,
    required this.mobile,
    required this.desk,
    this.type = ViewAdapterType.width,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ViewAdapterType.width:
        return WidthConditionBuilder(
          conditionMap: {
            phoneSize: (_) => mobile,
            deskSize: (_) => desk,
          },
        );
      case ViewAdapterType.platform:
        bool isDesk = kIsWeb ||
            Platform.isMacOS ||
            Platform.isWindows ||
            Platform.isLinux;
        return isDesk ? desk : mobile;
    }
  }

  bool phoneSize(double size) {
    return size > 0 && size <= 500;
  }

  bool deskSize(double size) {
    return size > 500;
  }
}

class WidthConditionBuilder extends StatelessWidget {
  final Map<WidthConditionFun, WidgetBuilder> conditionMap;
  final Widget unMatchWidget;

  const WidthConditionBuilder({
    super.key,
    required this.conditionMap,
    this.unMatchWidget = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, c) {
      List<WidthConditionFun> conditions = conditionMap.keys.toList();
      WidthConditionFun? active;
      for (int i = 0; i < conditions.length; i++) {
        if (conditions[i](c.maxHeight)) {
          active = conditions[i];
        }
      }
      if (active != null) {
        return conditionMap[active]!(context);
      }
      return unMatchWidget;
    });
  }
}
