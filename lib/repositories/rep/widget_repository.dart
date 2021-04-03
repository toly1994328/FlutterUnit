import 'package:flutter_unit/model/enums.dart';
import 'package:flutter_unit/model/node_model.dart';
import 'package:flutter_unit/model/widget_model.dart';
import 'package:flutter_unit/repositories/dao/widget_dao.dart';

/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com

abstract class WidgetRepository {
  Future<List<WidgetModel>> loadWidgets(WidgetFamily family);

  Future<List<WidgetModel>> loadWidget(List<int> ids);

  Future<List<WidgetModel>> searchWidgets(SearchArgs args);

  Future<List<NodeModel>> loadNode(WidgetModel widgetModel);

  Future<void> toggleLike(int id);

  Future<List<WidgetModel>> loadLikeWidgets();

  Future<void> collected(int id);
}
