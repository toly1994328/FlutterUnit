import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:widget_repository/widget_repository.dart';

import '../model/widget_filter.dart';
import '../repository/widget_repository.dart';


/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明 : Widget 数据仓库

class MemoryWidgetRepository implements WidgetRepository {
  List<WidgetPo>? _widgetCache;

  List<WidgetPo> get widgets => _widgetCache!;

  MemoryWidgetRepository();

  Future<void> _initData() async {
    if (_widgetCache != null) {
      return;
    }
    ByteData byteData = await rootBundle.load('assets/data/web/widget.json');
    String content = utf8.decode(byteData.buffer.asUint8List());
    var data = json.decode(content) as List;
    _widgetCache = data.map((e) => WidgetPo.fromJson(e)).toList();
  }

  @override
  Future<List<WidgetModel>> searchWidgets(WidgetFilter args) async {
    await _initData();
    var result = widgets.map(WidgetModel.fromPo).where((e) => checkSearch(e, args)).toList();
    result.sort((a, b) => b.lever.compareTo(a.lever));
    return result;
  }

  bool checkSearch(WidgetModel model, WidgetFilter args) {
    bool nameMatch = model.name.toLowerCase().contains(args.name.toLowerCase());
    bool nameCNMatch = model.nameCN.toLowerCase().contains(args.name.toLowerCase());
    bool familyMatch = model.family == args.family;

    return nameMatch || nameCNMatch || familyMatch;
  }

  @override
  Future<List<WidgetModel>> loadWidget(List<int> id) async {
    await _initData();
    var data = widgets.where((element) => id.contains(element.id));
    return data.map(WidgetModel.fromPo).toList();
  }

  @override
  Future<List<WidgetModel>> loadLikeWidgets() async {
    return [];
  }

  @override
  Future<WidgetModel?> queryWidgetByName(String? name) async {
    await _initData();
    Iterable<WidgetModel> ret =
        widgets.map(WidgetModel.fromPo).where((element) => element.name == name);
    if (ret.isNotEmpty) {
      return ret.first;
    }
    return null;
  }

  @override
  Future<void> toggleLike(int id) async {}

  @override
  Future<int> total(WidgetFilter args) async {
    return 0;
  }

  @override
  Future<int> collected(int id) async {
    return 0;
  }
}
