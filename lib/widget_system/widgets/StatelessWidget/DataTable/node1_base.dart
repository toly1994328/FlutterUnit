

/// create by 张风捷特烈 on 2020-03-21
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 102,
//      "name": 'DataTable基本使用',
//      "priority": 1,
//      "subtitle":
//          "【columns】 : 列   【List<DataColumn>】\n"
//          "【rows】 : 行  【List<DataRow>】",
//    }
import 'package:flutter/material.dart';

class _Bean {
  final int id;
  final String name;
  final String type;

  _Bean(this.id, this.name, this.type);
}

class CustomDataTable extends StatelessWidget {
  final data = [
    _Bean(101, 'DataTable', 'StatelessWidget'),
    _Bean(44, 'RangeSlider', 'StatefulWidget'),
    _Bean(2, 'Text', 'StatelessWidget'),
    _Bean(1, 'Image', 'StatefulWidget'),
  ];

  final columns = ['id', '名称', '类型'];

  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: columns.map((e) => DataColumn(label: Text(e))).toList(),
        rows: data
            .map((e) => DataRow(cells: [
          DataCell(Text('${e.id}')),
          DataCell(Text('${e.name}')),
          DataCell(Text('${e.type}')),
        ]))
            .toList());
  }
}