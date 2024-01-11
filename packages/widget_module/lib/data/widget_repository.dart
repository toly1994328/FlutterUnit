import 'model/model.dart';

/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com

abstract class WidgetRepository {
  // Future<List<WidgetModel>> loadWidgets(WidgetFamily family);

  ///
  Future<List<WidgetModel>> loadWidget(List<int> ids);

  Future<WidgetModel?> queryWidgetByName(String? name);

  /// 根据 [WidgetFilter] 搜索 [WidgetModel] 列表
  Future<List<WidgetModel>> searchWidgets(WidgetFilter args);

  Future<void> toggleLike(int id);

  Future<int> total(WidgetFilter args);

  Future<List<WidgetModel>> loadLikeWidgets();

  Future<int> collected(int id);
}
