
import 'dart:convert';
import 'dart:io';


import 'package:flutter_unit/repositories/app_start.dart';
import 'package:flutter_unit/repositories/bean/widget_po.dart';
import 'package:flutter_unit/repositories/dao/like_dao.dart';
import 'package:flutter_unit/repositories/local_db.dart';
import 'package:flutter_unit/repositories/dao/node_dao.dart';
import 'package:flutter_unit/repositories/dao/widget_dao.dart';
import 'package:flutter_unit/model/enums.dart';

import 'package:flutter_unit/model/node_model.dart';
import 'package:flutter_unit/model/widget_model.dart';
import 'package:flutter_unit/repositories/rep/widget_repository.dart';
import 'package:path_provider/path_provider.dart';


/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明 : Widget数据仓库

class WidgetDbRepository implements WidgetRepository {

  WidgetDao get _widgetDao => LocalDb.instance.widgetDao;
  NodeDao get _nodeDao => LocalDb.instance.nodeDao;
  LikeDao get _likeDao => LocalDb.instance.likeDao;

  @override
  Future<List<WidgetModel>> loadWidgets(WidgetFamily family) async {
    List<Map<String, dynamic>> data = await _widgetDao.queryByFamily(family);
    List<WidgetPo> widgets = data.map((e) => WidgetPo.fromJson(e)).toList();
    return widgets.map(WidgetModel.fromPo).toList();
  }

  @override
  Future<List<WidgetModel>> loadLikeWidgets() async {
    List<int> likeIds = await _likeDao.likeWidgetIds();
    List<Map<String, dynamic>> data = await _widgetDao.queryByIds(likeIds);
    List<WidgetPo> widgets = data.map((e) => WidgetPo.fromJson(e)).toList();
    return widgets.map(WidgetModel.fromPo).toList();
  }

  @override
  Future<List<WidgetModel>> searchWidgets(SearchArgs args) async {
    List<Map<String, dynamic>> data = await _widgetDao.search(args);
    List<WidgetPo> widgets = data.map((e) => WidgetPo.fromJson(e)).toList();
    return widgets.map(WidgetModel.fromPo).toList();
  }

  @override
  Future<List<NodeModel>> loadNode(WidgetModel widgetModel) async {
    List<Map<String, dynamic>> data = await _nodeDao.queryById(widgetModel.id);
    List<NodeModel> nodes = data.map((e) => NodeModel.fromJson(e)).toList();
    return nodes;
  }

  @override
  Future<List<WidgetModel>> loadWidget(List<int> id) async {
    List<Map<String, dynamic>> data = await _widgetDao.queryByIds(id);
    List<WidgetPo> widgets = data.map((e) => WidgetPo.fromJson(e)).toList();
    if (widgets.length > 0) return widgets.map(WidgetModel.fromPo).toList();
    return null;
  }

  @override
  Future<void> toggleLike(
    int id,
  ) {
    return _likeDao.toggleCollect(id);
  }


  @override
  Future<void> collected(int id) async{
    return  await _likeDao.like(id);
  }
}
