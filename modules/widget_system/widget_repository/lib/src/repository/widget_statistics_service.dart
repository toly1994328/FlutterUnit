import '../model/widget_statistics.dart';
import '../database/dao/widget_statistics_dao.dart';
import '../model/widget_filter.dart';

/// Widget统计服务
class WidgetStatisticsService {
  final WidgetStatisticsDao dao;

  const WidgetStatisticsService({required this.dao});

  /// 获取Widget统计数据
  Future<WidgetStatistics> getStatistics() async {
    final results = await Future.wait([
      dao.getFamilyCount(),
      dao.getTotalWidgets(),
      dao.getTotalFields(),
      dao.getAverageFields(),
      dao.getLeverDistribution(),
      dao.getWidgetFieldsCount(),
    ]);

    final rawFamilyCount = results[0] as Map<int, int>;
    final totalWidgets = results[1] as int;
    final totalFields = results[2] as int;
    final averageFields = results[3] as double;
    final leverDistribution = results[4] as Map<int, int>;
    final widgetFieldsCount = results[5] as Map<int, int>;

    final familyCount = <WidgetFamily, int>{};
    for (var entry in rawFamilyCount.entries) {
      final family = _intToWidgetFamily(entry.key);
      familyCount[family] = entry.value;
    }

    return WidgetStatistics(
      familyCount: familyCount,
      totalWidgets: totalWidgets,
      totalFields: totalFields,
      averageFields: averageFields,
      leverDistribution: leverDistribution,
      widgetFieldsCount: widgetFieldsCount,
    );
  }

  WidgetFamily _intToWidgetFamily(int index) {
    switch (index) {
      case 0: return WidgetFamily.stateless;
      case 1: return WidgetFamily.stateful;
      case 2: return WidgetFamily.singleChildRender;
      case 3: return WidgetFamily.multiChildRender;
      case 4: return WidgetFamily.sliver;
      case 5: return WidgetFamily.proxy;
      case 6: return WidgetFamily.other;
      default: return WidgetFamily.stateless;
    }
  }
}