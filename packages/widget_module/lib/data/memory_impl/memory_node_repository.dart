import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:storage/storage.dart';

import '../model/enums.dart';
import '../model/node_model.dart';
import '../model/widget_filter.dart';
import '../model/widget_model.dart';
import '../widget_repository.dart';

/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明 : Widget数据仓库

class MemoryWidgetRepository implements WidgetRepository {

  List<WidgetPo> _widgetCache = [];
  List<WidgetPo> get widgets => _widgetCache;

  MemoryWidgetRepository();

  Future<void> _initData() async{

  }

  // Future<List<WidgetModel>> loadWidgets(WidgetFamily family) async {
  //   var result =
  //       widgets.map(WidgetModel.fromPo).where((element) => element.family == family).toList();
  //   result.sort((a, b) => b.lever.compareTo(a.lever));
  //   return result;
  // }


  @override
  Future<List<WidgetModel>> searchWidgets(WidgetFilter args) async {
    print(args);
    var result = widgets
        .map(WidgetModel.fromPo)
        .where((element) =>
            element.name.toLowerCase().contains(args.name.toLowerCase()) ||
            element.nameCN.toLowerCase().contains(args.name.toLowerCase()))
        .toList();
    result.sort((a, b) => b.lever.compareTo(a.lever));
    return result;
  }

  @override
  Future<List<NodeModel>> loadNode(WidgetModel widgetModel) async {
    var str = await rootBundle.loadString('assets/data/node.json');
    var data = json.decode(str) as List;
    List<NodeModel> nodes = data
        .map((e) => NodePo.fromJson(e))
        .toList()
        .where((element) => element.widgetId == widgetModel.id)
        .map<NodeModel>(NodeModel.fromPo)
        .toList();
    return nodes;
  }

  @override
  Future<List<WidgetModel>> loadWidget(List<int> id) async {
    var data = widgets.where((element) => id.contains(element.id));
    return data.map(WidgetModel.fromPo).toList();
  }



  @override
  Future<List<WidgetModel>> loadLikeWidgets() async{
    return [];
  }

  @override
  Future<WidgetModel?> queryWidgetByName(String? name) async{
    // TODO: implement queryWidgetByName
    throw UnimplementedError();
  }

  @override
  Future<void> toggleLike(int id) async {}

  @override
  Future<int> total(WidgetFilter args) async {
    return 0;
  }

  @override
  Future<int> collected(int id) async{
    return 0;
  }
}
