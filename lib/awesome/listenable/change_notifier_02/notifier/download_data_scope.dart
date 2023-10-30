import 'package:flutter/cupertino.dart';

import 'progress_value_notifier.dart';

class DownloadDataScope extends InheritedNotifier<ProgressValueNotifier>{

  const DownloadDataScope({super.key, required super.child,super.notifier});

  static ProgressValueNotifier of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DownloadDataScope>()!.notifier!;
  }

  static ProgressValueNotifier read(BuildContext context) {
    return context.getInheritedWidgetOfExactType<DownloadDataScope>()!.notifier!;
  }
}