import 'package:app_config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/app/update_part/views/update_red_point.dart';
import 'package:flutter_unit/components/permanent/feedback_widget.dart';

/// create by 张风捷特烈 on 2020-04-11
/// contact me by email 1981462002@qq.com
/// 说明: 自定义底部导航栏

typedef IndexTapCallback = void Function(int);
typedef IndexLongTapCallback = void Function(BuildContext, int);

class UnitBottomBar extends StatefulWidget {
  final Color color;
  final int initPosition;
  // item 点击事件
  final IndexTapCallback? onItemTap;

  // item 长按事件
  final IndexLongTapCallback? onItemLongTap;

  const UnitBottomBar({Key? key,
    this.color = Colors.blue,
    this.initPosition = 0,
    required this.onItemTap,
    this.onItemLongTap,
  }) : super(key: key);

  @override
  _UnitBottomBarState createState() => _UnitBottomBarState();
}

class _UnitBottomBarState extends State<UnitBottomBar> {
  int _position = 0;

  @override
  void initState() {
    super.initState();
    _position = widget.initPosition;
  }

  final NotchedShape shape = const CircularNotchedRectangle();

  final borderTR = const BorderRadius.only(
    topRight: Radius.circular(10),
  );

  final borderTL = const BorderRadius.only(topLeft: Radius.circular(10));
  final paddingTR = const EdgeInsets.only(top: 2, right: 2);
  final paddingTL = const EdgeInsets.only(top: 2, left: 2);
  final paddingL = const EdgeInsets.only(left: 8);
  final paddingR = const EdgeInsets.only(right: 8);

  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  Color get color {
    if(isDark){
      return Theme.of(context).bottomNavigationBarTheme.backgroundColor??const Color(0xff181818);
    }else{
      return widget.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        elevation: 0,
        shape: shape,
        notchMargin: 5,
        color: color,
        child: IconTheme(
          data: IconTheme.of(context).copyWith(color: isDark?null:Colors.white, size: 25),
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
              color: color.withAlpha(88), borderRadius: borderTR),
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
                        size: getIconSizeByPosition(0),
                        color: getIconColorByPosition(0),
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
                        size: getIconSizeByPosition(1),
                        color: getIconColorByPosition(1),
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
              color: color.withAlpha(88), borderRadius: borderTL),
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
                        size: getIconSizeByPosition(2),
                        color: getIconColorByPosition(2),
                      )),
                ),
              ),
              Expanded(
                child: FeedbackWidget(
                  onPressed: () => _updateIndex(3),
                  onLongPressed: () => _onLongPress(context, 3),
                  child: Stack(
                    children: [
                      Container(
                          padding: paddingR,
                          height: SizeUnit.bottom_nav_height,
                          child: Icon(
                            TolyIcon.yonghu,
                            size: getIconSizeByPosition(3),
                            color: getIconColorByPosition(3),
                          )),
                      const Positioned(
                        left: 20,
                          top: 5,
                          child: UpdateRedPoint())
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  double getIconSizeByPosition(int position) => _position == position
      ? SizeUnit.active_bottom_nav_icon
      : SizeUnit.default_bottom_nav_icon;

  Color getIconColorByPosition(int position) =>
      _position == position ? isDark? Colors.blue: widget.color : Colors.white;

  void _updateIndex(int index) {
    setState(() {
      _position = index;
      widget.onItemTap?.call(_position);
    });
  }

  void _onLongPress(BuildContext context, int index) {
    widget.onItemLongTap?.call(context, index);
  }


}
