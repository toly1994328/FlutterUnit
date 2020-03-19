


import 'package:flutter_unit/database/node_dao.dart';
import 'package:flutter_unit/database/po/widget_po.dart';
import 'package:flutter_unit/database/widget_dao.dart';
import 'package:flutter_unit/model/node_model.dart';
import 'package:flutter_unit/model/widget_model.dart';
import 'package:flutter_unit/repositorys/widget_repository.dart';

/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明 : Widget数据仓库

class WidgetDbRepository implements WidgetRepository {
  WidgetDao _widgetDao;
  NodeDao _nodeDao;

  WidgetDbRepository() {
    _widgetDao = WidgetDao();
    _nodeDao = NodeDao();
  }

  @override
  Future<List<WidgetModel>> loadWidgets() async {
    var data = await _widgetDao.queryAll();
    var widgets = data.map((e) => WidgetPo.fromJson(e)).toList();
    return widgets.map(WidgetModel.fromPo).toList();
  }

  @override
  Future<List<NodeModel>> loadNode(WidgetModel widgetModel) async{
    var data = await _nodeDao.queryById(widgetModel.id);
    var nodes = data.map((e) => NodeModel.fromJson(e)).toList();
    return nodes;
  }
}
