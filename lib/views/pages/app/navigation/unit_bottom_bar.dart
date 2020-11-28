import 'package:flutter/material.dart';
import 'package:flutter_unit/app/res/toly_icon.dart';
import 'package:flutter_unit/components/permanent/feedback_widget.dart';

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

  final NotchedShape shape = const CircularNotchedRectangle();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        elevation: 0,
        shape: shape,
        notchMargin: 5,
        color: widget.color,
        child: IconTheme(
          data: IconTheme.of(context).copyWith(color: Colors.white, size: 25),
          child: Stack(
            children: [
              Material(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: borderTR),
                child: Container(
                  margin: paddingTR,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: widget.color.withAlpha(88),
                      borderRadius: borderTR),
                  height: 50,
                  width: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FeedbackWidget(
                        onPressed: () => _updateIndex(0),
                        onLongPressed: () => _onLongPress(context, 0),
                        child: Container(
                            width: 50,
                            height: 50,
                            child: Icon(
                              TolyIcon.icon_layout,
                              size: _position == 0 ? 28 : 25,
                              color:
                                  _position == 0 ? widget.color : Colors.white,
                            )),
                      ),
                      FeedbackWidget(
                        onPressed: () => _updateIndex(1),
                        child: Container(
                            width: 50,
                            height: 50,
                            child: Icon(
                              TolyIcon.kujialeqiyezhan_tiaosepan,
                              size: _position == 1 ? 28 : 25,
                              color:
                                  _position == 1 ? widget.color : Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Material(
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: borderTL),
                  child: Container(
                    margin: paddingTL,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: widget.color.withAlpha(88),
                        borderRadius: borderTL),
                    height: 50,
                    width: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FeedbackWidget(
                          onPressed: () => _updateIndex(2),
                          child: Container(
                              width: 50,
                              height: 50,
                              child: Icon(
                                TolyIcon.icon_collect,
                                size: _position == 2 ? 28 : 25,
                                color: _position == 2
                                    ? widget.color
                                    : Colors.white,
                              )),
                        ),
                        FeedbackWidget(
                          onPressed: () => _updateIndex(3),
                          onLongPressed: () => _onLongPress(context, 1),
                          child: Container(
                              width: 50,
                              height: 50,
                              child: Icon(
                                TolyIcon.yonghu,
                                size: _position == 3 ? 28 : 25,
                                color: _position == 3
                                    ? widget.color
                                    : Colors.white,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void _updateIndex(int index) {
    setState(() {
      _position = index;
      widget.onItemClick(_position);
    });
  }

  List<String> get info => widget.itemData.keys.toList();

  final borderTR = const BorderRadius.only(
    topRight: Radius.circular(10),
  );
  final borderTL = const BorderRadius.only(topLeft: Radius.circular(10));
  final paddingTR = const EdgeInsets.only(top: 2, right: 2);
  final paddingTL = const EdgeInsets.only(top: 2, left: 2);
}

_onLongPress(BuildContext context, int i) {
  if (i == 0) {
    Scaffold.of(context).openDrawer();
  }
  if (i == 1) {
    Scaffold.of(context).openEndDrawer();
  }
}
