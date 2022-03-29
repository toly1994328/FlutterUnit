import 'package:flutter/material.dart';

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

class _Bean {
  final int id;
  final String name;
  final String type;

  _Bean(this.id, this.name, this.type);
}

class CustomDataTable extends StatelessWidget {
  CustomDataTable({Key? key}) : super(key: key);

  final List<_Bean> data = [
    _Bean(101, 'DataTable', 'StatelessWidget'),
    _Bean(44, 'RangeSlider', 'StatefulWidget'),
    _Bean(2, 'Text', 'StatelessWidget'),
    _Bean(1, 'Image', 'StatefulWidget'),
  ];

  final List<String> columns = ['id', '名称', '类型'];

  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: columns
            .map((String title) => DataColumn(label: Text(title)))
            .toList(),
        rows: data
            .map((_Bean bean) => DataRow(cells: [
                  DataCell(Text('${bean.id}')),
                  DataCell(Text(bean.name)),
                  DataCell(Text(bean.type)),
                ]))
            .toList());
  }
}