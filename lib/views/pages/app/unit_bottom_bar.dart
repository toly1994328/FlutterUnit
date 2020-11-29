import 'package:flutter/material.dart';
import 'package:flutter_unit/app/res/size_unit.dart';
import 'package:flutter_unit/app/res/toly_icon.dart';
import 'package:flutter_unit/views/components/permanent/feedback_widget.dart';

/// create by 张风捷特烈 on 2020-04-11
/// contact me by email 1981462002@qq.com
/// 说明: 自定义底部导航栏

class UnitBottomBar extends StatefulWidget {
  final Color color;
  final Function(int) onItemClick;

  UnitBottomBar(
      {this.color = Colors.blue,
      @required this.onItemClick});

  @override
  _UnitBottomBarState createState() => _UnitBottomBarState();
}

class _UnitBottomBarState extends State<UnitBottomBar> {
  int _position = 0;

  final NotchedShape shape = const CircularNotchedRectangle();

  final borderTR = const BorderRadius.only(
    topRight: Radius.circular(10),
  );

  final borderTL = const BorderRadius.only(topLeft: Radius.circular(10));
  final paddingTR = const EdgeInsets.only(top: 2, right: 2);
  final paddingTL = const EdgeInsets.only(top: 2, left: 2);
  final paddingL = const EdgeInsets.only(left: 8);
  final paddingR = const EdgeInsets.only(right: 8);

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
              _buildLeftBtn(context),
              Positioned(
                right: 0,
                child: _buildRightBtn(context),
              ),
            ],
          ),
        ));
  }

  Widget _buildLeftBtn(BuildContext context) => Material(
        shape: RoundedRectangleBorder(borderRadius: borderTR),
        child: Container(
          margin: paddingTR,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: widget.color.withAlpha(88), borderRadius: borderTR),
          height: SizeUnit.bottom_nav_height,
          width: SizeUnit.bottom_nav_right_width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: FeedbackWidget(
                  onPressed: () => _updateIndex(0),
                  onLongPressed: () => _onLongPress(context, 0),
                  child: Container(
                      padding: paddingL,
                      height: SizeUnit.bottom_nav_height,
                      child: Icon(
                        TolyIcon.icon_layout,
                        size: iconSize(0),
                        color: iconColor(0),
                      )),
                ),
              ),
              Expanded(
                child: FeedbackWidget(
                  onPressed: () => _updateIndex(1),
                  child: Container(
                      height: SizeUnit.bottom_nav_height,
                      padding: paddingR,
                      child: Icon(
                        TolyIcon.dingzhi1,
                        size: iconSize(1),
                        color: iconColor(1),
                      )),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildRightBtn(BuildContext context) => Material(
        shape: RoundedRectangleBorder(borderRadius: borderTL),
        child: Container(
          margin: paddingTL,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: widget.color.withAlpha(88), borderRadius: borderTL),
          height: SizeUnit.bottom_nav_height,
          width: SizeUnit.bottom_nav_right_width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: FeedbackWidget(
                  onPressed: () => _updateIndex(2),
                  child: Container(
                      padding: paddingL,
                      height: SizeUnit.bottom_nav_height,
                      child: Icon(
                        TolyIcon.icon_collect,
                        size: iconSize(2),
                        color: iconColor(2),
                      )),
                ),
              ),
              Expanded(
                child: FeedbackWidget(
                  onPressed: () => _updateIndex(3),
                  onLongPressed: () => _onLongPress(context, 1),
                  child: Container(
                      padding: paddingR,
                      height: SizeUnit.bottom_nav_height,
                      child: Icon(
                        TolyIcon.yonghu,
                        size: iconSize(3),
                        color: iconColor(3),
                      )),
                ),
              ),
            ],
          ),
        ),
      );

  double iconSize(int position) => _position == position
      ? SizeUnit.active_bottom_nav_icon
      : SizeUnit.default_bottom_nav_icon;

  Color iconColor(int position) =>
      _position == position ? widget.color : Colors.white;

  void _updateIndex(int index) {
    setState(() {
      _position = index;
      widget.onItemClick(_position);
    });
  }
}

_onLongPress(BuildContext context, int i) {
  if (i == 0) {
    Scaffold.of(context).openDrawer();
  }
  if (i == 1) {
    Scaffold.of(context).openEndDrawer();
  }
}
