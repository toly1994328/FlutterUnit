

/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 102,
//      "name": 'DataTable的sort',
//      "priority": 2,
//      "subtitle":
//          "【sortColumnIndex】 : 列号   【int】\n"
//          "【columnSpacing】 : 列间距   【double】\n"
//          "【sortAscending】 : 是否顺序  【bool】",
//    }

import 'package:flutter/material.dart';

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
  const SortDataTable({Key? key}) : super(key: key);

  @override
  _SortDataTableState createState() => _SortDataTableState();
}

class _SortDataTableState extends State<SortDataTable> {
  List<_BeanOp> data = [
    _BeanOp(101, 'DataTable', 'StatelessWidget', false),
    _BeanOp(44, 'RangeSlider', 'StatefulWidget', false),
    _BeanOp(2, 'Text', 'StatelessWidget', false),
    _BeanOp(1, 'Image', 'StatefulWidget', false),
  ];

  bool _sortAscending = false;
  List<_BeanOp> selectData = <_BeanOp>[];

  @override
  Widget build(BuildContext context) {
    return DataTable(
        columnSpacing: 20,
        sortColumnIndex: 1,
        sortAscending: _sortAscending,
        columns: [
          DataColumn(
            label: Checkbox(
              value: selectData.length == data.length,
              onChanged: _onSelectAll,
            ),
          ),
          DataColumn(label: const Text('id'), numeric: false, onSort: _onSortId),
          const DataColumn(label: Text('名称')),
          const DataColumn(label: Text('类型')),
        ],
        rows: data
            .map((e) => DataRow(selected: false, cells: [
          DataCell(Checkbox(
            value: e.select,
            onChanged: (v) => _onSelectOne(v, e),
          )),
          DataCell(Text('${e.id}')),
          DataCell(Text(e.name),
              showEditIcon: true, onTap: () {}),
          DataCell(Text(e.type)),
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

  void _onSelectOne(bool? selected, _BeanOp e) {
    if(selected==null) return;
    setState(() {
      if (selected) {
        selectData.add(e);
      } else {
        selectData.remove(e);
      }
      e.select = selected;
    });
  }

  void _onSelectAll(bool? select) {
    if(select==null) return;
    setState(() {
      if (select) {
        for (_BeanOp e in data) {
          e.select = true;
        }
        selectData = data.map((e) => e).toList();
      } else {
        for (_BeanOp e in data) {
          e.select = false;
        }
        selectData = [];
      }
    });
  }
}