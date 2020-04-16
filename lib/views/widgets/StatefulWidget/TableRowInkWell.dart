import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 151,
//      "name": 'TableRowInkWell基本事件',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 子组件   【Widget】\n"
//          "【onTap】 : 点击事件   【Function()】\n"
//          "【onDoubleTap】 : 双击事件   【Function()】\n"
//          "【onLongPress】 : 长按事件   【Function()】\n"
//          "【onHighlightChanged】 : 高亮变化回调   【Function(bool)】",
//    }
class CustomTableRowInkWell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var title = _ItemBean("单位称", "量纲", "单位", "单位名称", "单位符号");
    var m = _ItemBean("长度", "L", "1m", "米", "m");
    var kg = _ItemBean("质量", "M", "1Kg", "千克", "Kg");
    var s = _ItemBean("时间", "T", "1s", "秒", "s");
    var a = _ItemBean("安培", "Ι", "1A", "安培", "A");
    var k = _ItemBean("热力学温度", "θ", "1K", "开尔文", "K");
    var mol = _ItemBean("物质的量", "N", "1mol", "摩尔", "mol");
    var cd = _ItemBean("发光强度", "J", "1cd", "坎德拉", "cd");

    var data = <_ItemBean>[title, m, kg, s, a, k, mol, cd];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(80.0),
          1: FixedColumnWidth(80.0),
          2: FixedColumnWidth(80.0),
          3: FixedColumnWidth(80.0),
          4: FixedColumnWidth(80.0),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(
            color: Colors.orangeAccent, width: 1.0, style: BorderStyle.solid),
        children: data
            .map((item) => TableRow(children: <Widget>[
          TableRowInkWell(
            onTap: () => print('onTap'),
            onDoubleTap: () => print('onDoubleTap'),
            onLongPress: () => print('onLongPress'),
            onHighlightChanged: (v) => print('onHighlightChanged:$v'),
            child: Center(
                child: Text(
                  item.name,
                  style: TextStyle(color: Colors.blue),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(item.symbol)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(item.unitSymbol)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(item.unitName)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(item.unit)),
          ),
        ]))
            .toList(),
      ),
    );
  }
}

class _ItemBean {
  String name;
  String symbol;
  String unit;
  String unitName;
  String unitSymbol;

  _ItemBean(this.name, this.symbol, this.unit, this.unitName, this.unitSymbol);
}

