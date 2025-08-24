import 'package:flutter/foundation.dart';
import '../../widget_repository.dart';
import '../model/widget_statistics.dart';
import 'widget_statistics_service.dart';

/// 全局统计数据提供器
class WidgetStatisticsProvider extends ChangeNotifier {
  static final WidgetStatisticsProvider _instance =
      WidgetStatisticsProvider._internal();
  factory WidgetStatisticsProvider() => _instance;
  WidgetStatisticsProvider._internal();

  WidgetStatistics? _statistics;
  bool _isLoaded = false;

  WidgetStatistics? get statistics => _statistics;
  bool get isLoaded => _isLoaded;

  /// 加载统计数据
  Future<void> loadStatistics(WidgetStatisticsDao dao) async {
    if (_isLoaded) return;

    final stopwatch = Stopwatch()..start();
    try {
      _statistics = await getStatistics(dao);
      _isLoaded = true;
      stopwatch.stop();
      debugPrint('统计数据加载耗时: ${stopwatch.elapsedMilliseconds} ms');
      notifyListeners();
    } catch (e) {
      stopwatch.stop();
      debugPrint('加载统计数据失败: $e (耗时: ${stopwatch.elapsedMilliseconds} ms)');
    }
  }

  /// 获取Widget统计数据
  Future<WidgetStatistics> getStatistics(WidgetStatisticsDao dao) async {
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
      case 0:
        return WidgetFamily.stateless;
      case 1:
        return WidgetFamily.stateful;
      case 2:
        return WidgetFamily.singleChildRender;
      case 3:
        return WidgetFamily.multiChildRender;
      case 4:
        return WidgetFamily.sliver;
      case 5:
        return WidgetFamily.proxy;
      case 6:
        return WidgetFamily.other;
      default:
        return WidgetFamily.stateless;
    }
  }
}
