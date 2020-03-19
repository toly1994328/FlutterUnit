import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_unit/app/res/node_data.dart';
import 'package:flutter_unit/database/flutter_db.dart';
import 'package:flutter_unit/database/node_dao.dart';
import 'package:flutter_unit/database/po/node_po.dart';
import 'package:flutter_unit/database/po/widget_po.dart';
import 'package:flutter_unit/database/widget_dao.dart';



/// create by 张风捷特烈 on 2020-03-04
/// contact me by email 1981462002@qq.com
/// 说明:

class Initial {
  static init() async {
    var widgetDao = WidgetDao();
    var nodeDao = NodeDao();
    await FlutterDb.db.initDB();

    var jsonStr = await rootBundle.loadString('assets/data/widget.json');
    var widgets = (json.decode(jsonStr)["items"] as List)
        .map((item) => WidgetPo.fromJson(item))
        .toList();
    widgets.forEach((widget) async {
      print("insert:${widget.name}");
      await widgetDao.insert(widget);
    });

    nodeData.values.forEach((nodes) {
      nodes.forEach((nodeMap) async {
        var node = NodePo.fromJson(nodeMap);
        nodeDao.insert(node);
        print("insert:${node.name}");
      });
    });

    print("============Complete==================");
  }
}
