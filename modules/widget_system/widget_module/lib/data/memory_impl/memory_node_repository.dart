import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:storage/storage.dart';

import '../model/node_model.dart';
import '../node_repository.dart';

/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明 : Node 数据仓库

class MemoryNodeRepository implements NodeRepository {
  List<NodePo>? _nodeCache;


  MemoryNodeRepository();

  Future<void> initData() async {
    if (_nodeCache != null) {
      return;
    }
    ByteData byteData = await rootBundle.load('assets/data/web/node.json');
    String content = utf8.decode(byteData.buffer.asUint8List());
    var data = json.decode(content) as List;
    _nodeCache = data.map((e) => NodePo.fromJson(e)).toList();
  }

  @override
  Future<List<NodeModel>> loadNode(int widgetId) async {
    await initData();
    return _nodeCache!
        .where((element) => element.widgetId == widgetId)
        .map<NodeModel>((e) => NodeModel(name: e.name, subtitle: e.subtitle, code: e.code))
        .toList();
  }
}
