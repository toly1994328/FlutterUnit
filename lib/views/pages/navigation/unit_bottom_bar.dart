import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-11
/// contact me by email 1981462002@qq.com
/// 说明: 

class UnitBottomBar extends StatefulWidget {
  final Color color;
  final Map<String, IconData> itemData;
  final Function(int) onItemClick;

  UnitBottomBar(
      {this.color = Colors.blue,
        @required this.itemData,
        @required this.onItemClick});

  @override
  _UnitBottomBarState createState() => _UnitBottomBarState();
}

class _UnitBottomBarState extends State<UnitBottomBar> {
  int _position = 0;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        elevation: 0,
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        color: widget.color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widget.itemData.keys
              .map((e) => _buildChild(info.indexOf(e), widget.color))
              .toList(),
        ));
  }

  List<String> get info => widget.itemData.keys.toList();

  Widget _buildChild(int i, Color color) {
    var active = i == _position;
    bool left = i == 0;
    return GestureDetector(
      onTap: () => setState(() {
        _position = i;
        if (widget.onItemClick != null) {
          widget.onItemClick(_position);
        }
      }),
      child: Material(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: left
                ? BorderRadius.only(topRight: Radius.circular(10))
                : BorderRadius.only(topLeft: Radius.circular(10))),
        child: Container(
            margin: left
                ? EdgeInsets.only(top: 2, right: 2)
                : EdgeInsets.only(top: 2, left: 2),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: color.withAlpha(88),
                borderRadius: left
                    ? BorderRadius.only(topRight: Radius.circular(10))
                    : BorderRadius.only(topLeft: Radius.circular(10))),
            height: 45,
            width: 100,
            child: Icon(
              widget.itemData[info[i]],
              color: active ? color : Colors.white,
              size: active ? 28 : 24,
            )),
      ),
    );
  }
}
