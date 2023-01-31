import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-01
/// contact me by email 1981462002@qq.com
/// 说明: 235 PaginatedDataTable 可分页表格
/// 一个功能丰富的可分页表格组件，可指定分页数、排列、页码前后切换。
/// link: 110,102
//    {
//      "widgetId": 235 ,
//      "name": 'PaginatedDataTable 使用',
//      "priority": 1,
//      "subtitle":
//          "【header】 : 表名   【Widget】\n"
//          "【rowsPerPage】 : 每页记录数   【int】\n"
//          "【actions】 : 操作组件   【List<Widget>】\n"
//          "【columns】 : 数据列   【List<DataColumn>】\n"
//          "【sortColumnIndex】 : 排序列索引   【int】\n"
//          "【sortAscending】 : 是否升序   【bool】\n"
//          "【onSelectAll】 : 全选回调   【ValueSetter<bool>】\n"
//          "【onRowsPerPageChanged】 : 分页改变监听   【ValueChanged<int>】\n"
//          "【availableRowsPerPage】 : 可用分页列表   【List<int>】\n"
//          "【source】 : 数据源   【DataTableSource】",
//    }
class PaginatedDataTableDemo extends StatefulWidget {
  const PaginatedDataTableDemo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PaginatedDataTableDemoState();
}

class _PaginatedDataTableDemoState extends State<PaginatedDataTableDemo> {
  int _rowsPerPage = 5;

  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  final DessertDataSource _dessertsDataSource = DessertDataSource();

  void sort<T>(
    Comparable<T> Function(HeroInfo d) getField,
    int columnIndex,
    bool ascending,
  ) {
    _dessertsDataSource.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300,
        width: 350,
        child: SingleChildScrollView(
          child: PaginatedDataTable(
              actions: const <Widget>[
                IconButton(icon: Icon(Icons.add), onPressed: null),
              ],
              header: const Text(
                '《旷古奇书》-角色预设',
                style: TextStyle(color: Colors.blue),
              ),
              rowsPerPage: _rowsPerPage,
              availableRowsPerPage: const [5, 8, 10, 15],
              onRowsPerPageChanged: (int? value) {
                setState(() {
                  _rowsPerPage = value ?? 0;
                });
              },
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              onSelectAll: _dessertsDataSource._selectAll,
              columns: <DataColumn>[
                DataColumn(
                    label: const Text('角色名称'),
                    onSort: (int columnIndex, bool ascending) => sort<String>(
                        (HeroInfo d) => d.name, columnIndex, ascending)),
                DataColumn(
                    label: const Text('主场卷部'),
                    tooltip: '人物主要出场的作品.',
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => sort<String>(
                        (HeroInfo d) => d.calories, columnIndex, ascending)),
                DataColumn(
                    label: const Text('种族'),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => sort<String>(
                        (HeroInfo d) => d.fat, columnIndex, ascending)),
                DataColumn(
                    label: const Text('性别'),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => sort<String>(
                        (HeroInfo d) => d.carbs, columnIndex, ascending)),
              ],
              source: _dessertsDataSource),
        ));
  }
}

class HeroInfo {
  HeroInfo(this.name, this.calories, this.fat, this.carbs);

  final String name;
  final String calories;
  final String fat;
  final String carbs;
  bool selected = false;
}

class DessertDataSource extends DataTableSource {
  final List<HeroInfo> _desserts = [
    HeroInfo('捷特', '《幻将录》', "人族", "男"),
    HeroInfo('龙少', '《幻将录》', "人族", "男"),
    HeroInfo('巫缨', '《幻将录》', "人族", "女"),
    HeroInfo('林兮', '《幻将录》', "人族", "男"),
    HeroInfo('九方玄玉', '《风神传》', "神族", "男"),
    HeroInfo('七日洪荒', '《风神传》', "魔族", "男"),
    HeroInfo('林昔瑶', '《封妖志》', "鬼族", "女"),
    HeroInfo('林兮鬼帝', '《封妖志》', "鬼族", "男"),
    HeroInfo('艾隆', '《封妖志》', "鬼族", "男"),
    HeroInfo('语熙华', '《风神传》', "道族", "男"),
    HeroInfo('雪玉宛如', '《幻将录》', "人族", "女"),
    HeroInfo('破千', '《幻将录》', "人族", "男"),
    HeroInfo('浪封', '《幻将录》', "人族", "男"),
    HeroInfo('虎翼穷奇', '《封妖志》', "妖族", "男"),
    HeroInfo('凯', '《幻将录》', "人族", "男"),
    HeroInfo('荆棘', '《幻将录》', "人族", "女"),
    HeroInfo('龙右', '《幻将录》', "人族", "男"),
    HeroInfo('梦千', '《幻将录》', "人族", "男"),
    HeroInfo('梦小梦', '《幻将录》', "人族", "女"),
    HeroInfo('梦瞳', '《幻将录》', "人族", "男"),
    HeroInfo('十戈', '《幻将录》', "人族", "男"),
    HeroInfo('计画天', '《幻将录》', "人族", "女"),
    HeroInfo('士方', '《幻将录》', "人族", "男"),
    HeroInfo('巫妻孋', '《幻将录》', "人族", "女"),
    HeroInfo('木时黎', '《永恒传说》', "人族", "男"),
    HeroInfo('木艾奇', '《永恒传说》', "人族", "男"),
    HeroInfo('张风', '《永恒传说》', "人族", "男"),
    HeroInfo('薛剑儿', '《永恒传说》', "人族", "男"),
    HeroInfo('李月', '《永恒传说》', "人族", "女"),
    HeroInfo('刘雪', '《永恒传说》', "人族", "女"),
    HeroInfo('葛心', '《永恒传说》', "人族", "女"),
    HeroInfo('步映容', '《幻将录》', "人族", "女"),
    HeroInfo('莫慈良', '《幻将录》', "人族", "男"),
    HeroInfo('莫向阳', '《幻将录》', "人族", "男"),
    HeroInfo('莫子薇', '《永恒传说》', "人族", "女"),
    HeroInfo('藏凯阳', '《永恒传说》', "人族", "男"),
    HeroInfo('奇雨歆', '《永恒传说》', "人族", "女"),
    HeroInfo('林天蕊', '《永恒传说》', "人族", "女"),
    HeroInfo('吴灏然', '《永恒传说》', "人族", "男"),
    HeroInfo('何解连', '《永恒传说》', "人族", "男"),
    HeroInfo('步络尘', '《幻将录》', "人族", "男"),
    HeroInfo('拓雷', '《幻将录》', "人族", "男"),
    HeroInfo('炽阳骑', '《幻将录》', "人族", "男"),
    HeroInfo('正构', '《幻将录》', "人族", "男"),
    HeroInfo('烈', '《幻将录》', "人族", "男"),
    HeroInfo('梦华君', '《幻将录》', "人族", "男"),
    HeroInfo('初星', '《幻将录》', "人族", "男"),
    HeroInfo('梦飞烟', '《幻将录》', "人族", "男"),
    HeroInfo('武落英', '《幻将录》', "人族", "女"),
    HeroInfo('古千缘', '《幻将录》', "人族", "男"),
  ];

  void sort<T>(
    Comparable<T> Function(HeroInfo d) getField,
    bool ascending,
  ) {
    _desserts.sort((HeroInfo a, HeroInfo b) {
      if (!ascending) {
        final HeroInfo c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    if (index >= _desserts.length) return null;
    final HeroInfo dessert = _desserts[index];
    return DataRow.byIndex(
        index: index,
        selected: dessert.selected,
        onSelectChanged: (bool? value) {
          if (dessert.selected != value && value != null) {
            _selectedCount += value ? 1 : -1;
            assert(_selectedCount >= 0);
            dessert.selected = value;
            notifyListeners();
          }
        },
        cells: <DataCell>[
          DataCell(Center(child: Text(dessert.name))),
          DataCell(Center(child: Text(dessert.calories))),
          DataCell(Center(child: Text(dessert.fat))),
          DataCell(Center(child: Text(dessert.carbs))),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _desserts.length;

  @override
  int get selectedRowCount => _selectedCount;

  void _selectAll(bool? checked) {
    if (checked == null) return;
    for (HeroInfo dessert in _desserts) {
      dessert.selected = checked;
    }
    _selectedCount = checked ? _desserts.length : 0;
    notifyListeners();
  }
}
