
import 'package:flutter_unit/storage/app_storage.dart';
import 'package:flutter_unit/app/enums.dart';
import 'package:flutter_unit/storage/dao/node_dao.dart';

import 'package:flutter_unit/storage/po/widget_po.dart';
import 'package:flutter_unit/storage/dao/widget_dao.dart';
import 'package:flutter_unit/model/node_model.dart';
import 'package:flutter_unit/model/widget_model.dart';
import 'package:flutter_unit/repositories/itf/widget_repository.dart';

/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明 : Widget数据仓库

class WidgetDbRepository implements WidgetRepository {
  final AppStorage storage;

  WidgetDao _widgetDao;
  NodeDao _nodeDao;

  WidgetDbRepository(this.storage) {
    _widgetDao = WidgetDao(storage);
    _nodeDao = NodeDao(storage);
  }

  @override
  Future<List<WidgetModel>> loadWidgets(WidgetFamily family) async {
    var data = await _widgetDao.queryByFamily(family);
    var widgets = data.map((e) => WidgetPo.fromJson(e)).toList();
    return widgets.map(WidgetModel.fromPo).toList();
  }

  @override
  Future<List<WidgetModel>> loadCollectWidgets() async {
    var data = await _widgetDao.queryCollect();
    var widgets = data.map((e) => WidgetPo.fromJson(e)).toList();
    var list = widgets.map(WidgetModel.fromPo).toList();
    return list;
  }

  @override
  Future<List<WidgetModel>> searchWidgets(SearchArgs args) async {
    var data = await _widgetDao.search(args);
    var widgets = data.map((e) => WidgetPo.fromJson(e)).toList();
    return widgets.map(WidgetModel.fromPo).toList();
  }

  @override
  Future<List<NodeModel>> loadNode(WidgetModel widgetModel) async {
    var data = await _nodeDao.queryById(widgetModel.id);
    var nodes = data.map((e) => NodeModel.fromJson(e)).toList();
    return nodes;
  }

  @override
  Future<List<WidgetModel>> loadWidget(List<int> id) async {
    var data = await _widgetDao.queryByIds(id);
    var widgets = data.map((e) => WidgetPo.fromJson(e)).toList();
    if (widgets.length > 0) return widgets.map(WidgetModel.fromPo).toList();
    return null;
  }

  @override
  Future<void> toggleCollect(
    int id,
  ) {
    return _widgetDao.toggleCollect(id);
  }


  @override
  Future<bool> collected(int id) async{
    return  await _widgetDao.collected(id);
  }
}
