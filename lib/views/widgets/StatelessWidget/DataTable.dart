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

//    {
//      "widgetId": 102,
//      "name": 'DataTable的sort',
//      "priority": 2,
//      "subtitle":
//          "【sortColumnIndex】 : 列号   【int】\n"
//          "【columnSpacing】 : 列间距   【double】\n"
//          "【sortAscending】 : 是否顺序  【bool】",
//    }

class _BeanOp {
  final int id;
  final String name;
  final String type;
  bool select;

  _BeanOp(this.id, this.name, this.type, this.select);

  @override
  String toString() {
    return '_BeanOp{id: $id, name: $name, type: $type, select: $select}';
  }
}

class SortDataTable extends StatefulWidget {
  @override
  _SortDataTableState createState() => _SortDataTableState();
}

class _SortDataTableState extends State<SortDataTable> {
  var data = [
    _BeanOp(101, 'DataTable', 'StatelessWidget', false),
    _BeanOp(44, 'RangeSlider', 'StatefulWidget', false),
    _BeanOp(2, 'Text', 'StatelessWidget', false),
    _BeanOp(1, 'Image', 'StatefulWidget', false),
  ];

  bool _sortAscending = false;
  var selectData = <_BeanOp>[];

  @override
  Widget build(BuildContext context) {
    return DataTable(
        columnSpacing: 20,
        sortColumnIndex: 1,
        sortAscending: _sortAscending,
        columns: [
          DataColumn(
            label: Container(
              child: Checkbox(
                value: selectData.length == data.length,
                onChanged: _onSelectAll,
              ),
            ),
          ),
          DataColumn(label: Text('id'), numeric: false, onSort: _onSortId),
          DataColumn(label: Text('名称')),
          DataColumn(label: Text('类型')),
        ],
        rows: data
            .map((e) => DataRow(selected: false, cells: [
                  DataCell(Checkbox(
                    value: e.select,
                    onChanged: (v) => _onSelectOne(v, e),
                  )),
                  DataCell(Text('${e.id}')),
                  DataCell(Text('${e.name}'),
                      showEditIcon: true, onTap: () {}),
                  DataCell(Text('${e.type}')),
                ]))
            .toList());
  }

  _onSortId(int index, bool ascending) {
    setState(() {
      _sortAscending = ascending;
      data.sort(
          (a, b) => ascending ? a.id.compareTo(b.id) : b.id.compareTo(a.id));
    });
  }

  _onSelectOne(bool selected, _BeanOp e) {
    setState(() {
      if (selected) {
        //选中
        selectData.add(e);
      } else {
        selectData.remove(e);
      }
      e.select = selected;
      print(selectData);
    });
  }

  _onSelectAll(bool select) {
    setState(() {
      if (select) {
        data.forEach((e) => e.select = true);
        selectData = data.map((e) => e).toList();
      } else {
        data.forEach((e) => e.select = false);
        selectData = [];
      }
    });
  }
}
