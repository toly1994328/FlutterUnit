//
//
//
//import 'dart:convert';
//
//import 'package:flutter/services.dart';
//import 'package:flutter_unit/app/enums.dart';
//import 'package:flutter_unit/database/node_dao.dart';
//import 'package:flutter_unit/database/po/widget_po.dart';
//import 'package:flutter_unit/database/widget_dao.dart';
//import 'package:flutter_unit/model/node_model.dart';
//import 'package:flutter_unit/model/widget_model.dart';
//import 'package:flutter_unit/repositorys/widget_repository.dart';
//import 'package:flutter_unit/tools/node_data.dart';
///// create by 张风捷特烈 on 2020-03-03
///// contact me by email 1981462002@qq.com
///// 说明 : Widget数据仓库
//
//class WidgetMeRepository implements WidgetRepository {
//
//
//  @override
//  Future<List<WidgetModel>> loadWidgets(WidgetFamily family) async {
//    var jsonStr = await rootBundle.loadString('assets/data/widget.json');
//    var widgets = (json.decode(jsonStr)["items"] as List)
//        .map((item) => WidgetPo.fromJson(item))
//        .toList();
//    var where = widgets.map(WidgetModel.fromPo).where((e)=>e.family==family).toList();
//    return where;
//  }
//
//  @override
//  Future<List<NodeModel>> loadNode(WidgetModel widgetModel) async{
//    return nodeData[widgetModel.name].map((e)=>NodeModel.fromJson(e)).toList();
//  }
//
//  @override
//  Future<List<WidgetModel>> searchWidgets(SearchArgs args) {
//    return null;
//  }
//
//  @override
//  Future<List<WidgetModel>> loadWidget(List<int> ids) async{
//    var jsonStr = await rootBundle.loadString('assets/data/widget.json');
//    var widgets = (json.decode(jsonStr)["items"] as List)
//        .map((item) => WidgetPo.fromJson(item))
//        .toList();
//    var where = widgets.map(WidgetModel.fromPo).where((e)=>ids.contains(e.id)).toList();
//    return where;
//  }
//
//  @override
//  Future<List<WidgetModel>> loadCollectWidgets() async{
//    // TODO: implement loadCollectWidgets
//    return [];
//  }
//
//  @override
//  Future<void> toggleCollect(int id) {
//    // TODO: implement setCollect
//    return null;
//  }
//}
