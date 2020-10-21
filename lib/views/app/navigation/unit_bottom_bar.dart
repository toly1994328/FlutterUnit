import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-11
/// contact me by email 1981462002@qq.com
/// 说明: 自定义底部导航栏

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
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        color: widget.color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: info
              .map((e) => _buildChild(context, info.indexOf(e), widget.color))
              .toList(),
        ));
  }

  List<String> get info => widget.itemData.keys.toList();

  final borderTR = const BorderRadius.only(topRight: Radius.circular(10));
  final borderTL = const BorderRadius.only(topLeft: Radius.circular(10));
  final paddingTR = const EdgeInsets.only(top: 2, right: 2);
  final paddingTL = const EdgeInsets.only(top: 2, left: 2);

  Widget _buildChild(BuildContext context, int i, Color color) {
    final bool active = i == _position;
    final bool left = i == 0;

    return GestureDetector(
      onTap: () => _tapTab(i),
      onLongPress: () => _onLongPress(context, i),
      child: Material(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: left ? borderTR : borderTL),
        child: Container(
            margin: left ? paddingTR : paddingTL,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: color.withAlpha(88),
                borderRadius: left ? borderTR : borderTL),
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

  _tapTab(int i) {
    setState(() {
      _position = i;
      if (widget.onItemClick != null) {
        widget.onItemClick(_position);
      }
    });
  }

  _onLongPress(BuildContext context, int i) {
    if (i == 0) {
      Scaffold.of(context).openDrawer();
    }
    if (i == 1) {
      Scaffold.of(context).openEndDrawer();
    }
  }
}
