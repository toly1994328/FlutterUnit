import 'package:flutter/material.dart';
import 'package:storage/storage.dart';
import 'package:widget_repository/widget_repository.dart';

/// 初始化统计数据
Future<void> initWidgetStatistics() async {
  await WidgetStatisticsProvider().loadStatistics(
    AppStorage().flutter<WidgetStatisticsDao>(),
  );
}
