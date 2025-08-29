import 'package:equatable/equatable.dart';
import 'widget_filter.dart';

/// Widget统计数据模型
class WidgetStatistics extends Equatable {
  /// 各Family对应的组件数量
  final Map<WidgetFamily, int> familyCount;
  
  /// 总组件数量
  final int totalWidgets;
  
  /// 总字段数量
  final int totalFields;
  
  /// 平均字段数量
  final double averageFields;
  
  /// 星级分布 (1-5星对应的组件数量)
  final Map<int, int> leverDistribution;
  
  /// 每个组件的属性个数 (widgetId -> 属性个数)
  final Map<int, int> widgetFieldsCount;

  const WidgetStatistics({
    required this.familyCount,
    required this.totalWidgets,
    required this.totalFields,
    required this.averageFields,
    required this.leverDistribution,
    required this.widgetFieldsCount,
  });

  @override
  List<Object> get props => [
        familyCount,
        totalWidgets,
        totalFields,
        averageFields,
        leverDistribution,
        widgetFieldsCount,
      ];

  /// 获取指定组件的属性个数
  int getWidgetFieldCount(int widgetId) {
    return widgetFieldsCount[widgetId] ?? 0;
  }

  @override
  String toString() {
    return 'WidgetStatistics{familyCount: $familyCount, totalWidgets: $totalWidgets, totalFields: $totalFields, averageFields: $averageFields, leverDistribution: $leverDistribution, widgetFieldsCount: ${widgetFieldsCount.length} widgets}';
  }
}