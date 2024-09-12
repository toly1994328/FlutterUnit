import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:l10n/ext.dart';

typedef IndexTapCallback = void Function(int);
typedef IndexLongTapCallback = void Function(BuildContext, int);

class PureBottomBar extends StatefulWidget {
  final int initPosition;

  // item 点击事件
  final IndexTapCallback? onItemTap;

  // item 长按事件
  final IndexLongTapCallback? onItemLongTap;
  const PureBottomBar(
      {Key? key, this.onItemTap, this.onItemLongTap, this.initPosition = 0})
      : super(key: key);

  @override
  State<PureBottomBar> createState() => _PureBottomBarState();
}

class _PureBottomBarState extends State<PureBottomBar> {
  List<String> get bottomBar => [
        context.l10n.homeTabWidget,
        context.l10n.homeTabPaint,
        context.l10n.homeTabKnowledge,
        context.l10n.homeTabTools,
        context.l10n.homeTabMine,
      ];

  List<IconData> get bottomBarIcon => const [
        TolyIcon.icon_layout,
        TolyIcon.dingzhi1,
        TolyIcon.icon_artifact,
        TolyIcon.icon_fast,
        TolyIcon.yonghu,
      ];

  int _position = 0;

  @override
  void initState() {
    super.initState();
    _position = widget.initPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        // Divider(height: 1,),
        BottomNavigationBar(
          // backgroundColor: Colors.white,
          onTap: (position) {
            // checkTokenExpires();
            _position = position;

            widget.onItemTap?.call(_position);
            setState(() {
              // _controller.jumpToPage(_position);
            });
          },
          currentIndex: _position,

          elevation: 3,
          // fixedColor: themeColor.activeColor,
          type: BottomNavigationBarType.fixed,
          iconSize: 22,
          selectedItemColor: Theme.of(context).primaryColor,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          showUnselectedLabels: true,
          showSelectedLabels: true,
          // backgroundColor: themeColor.itemColor,
          items: bottomBar
              .asMap()
              .keys
              .map((index) => BottomNavigationBarItem(
                  label: bottomBar[index], icon: Icon(bottomBarIcon[index])))
              .toList(),
        ),
      ],
    );
  }
}
