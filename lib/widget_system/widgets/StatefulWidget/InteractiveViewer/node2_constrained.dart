import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 351,
//      "name": "constrained属性测试",
//      "priority": 2,
//      "subtitle": "【constrained】 :  受约束的  【bool】",
//    }

class InteractiveViewerDemo2 extends StatelessWidget {

  Widget build(BuildContext context) {
    const int _rowCount = 20;
    const int _columnCount = 4;

    return Container(
      width: 300,
      height: 200,
      child: InteractiveViewer(
        constrained: false,
        scaleEnabled: false,
        child: Table(
          columnWidths: <int, TableColumnWidth>{
            for (int column = 0; column < _columnCount; column += 1)
              column: const FixedColumnWidth(150.0),
          },
          children: buildRows(_rowCount, _columnCount),
        ),
      ),
    );
  }

  List<TableRow> buildRows(int rowCount, int columnCount) {
    return <TableRow>[
          for (int row = 0; row < rowCount; row += 1)
            TableRow(
              children: <Widget>[
                for (int column = 0; column < columnCount; column += 1)
                  Container(
                    margin: EdgeInsets.all(2),
                    height: 50,
                    alignment: Alignment.center,
                    color: _colorful(row,column),
                    child: Text('($row,$column)',style: TextStyle(fontSize: 20,color: Colors.white),),
                  ),
              ],
            ),
        ];
  }

  final colors = [Colors.red,Colors.yellow,Colors.blue,Colors.green];
  final colors2 = [Colors.yellow,Colors.blue,Colors.green,Colors.red];

  _colorful(int row, int column ) => row % 2==0?colors[column]:colors2[column];
}
