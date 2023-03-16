import 'package:app_config/app_config.dart';
import 'package:components/toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/app/plateform_adapter/window/windows_adapter.dart';
import 'package:url_launcher/url_launcher.dart';

class UnitRailNavigation extends StatelessWidget {
  final ValueChanged<int> onItemClick;
  final int selectedIndex;
  final Map<String, IconData> itemData;

  const UnitRailNavigation(
      {Key? key,
      required this.onItemClick,
      required this.selectedIndex,
      required this.itemData})
      : super(key: key);

  List<String> get info => itemData.keys.toList();
  List<IconData> get icons => itemData.values.toList();

  @override
  Widget build(BuildContext context) {
    // NavigationRail
    return DragToMoveAreaNoDouble(
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(right: 1),
        width: 120,
        decoration: const BoxDecoration(color: Color(0xff2C3036), boxShadow: [
          BoxShadow(color: Colors.grey, offset: Offset(1, 0), blurRadius: 2)
        ]),
        child: Column(
          children: [
            Wrap(
              direction: Axis.vertical,
              spacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: const [
                CircleImage(
                  image: AssetImage('assets/images/icon_head.webp'),
                  size: 60,
                ),
                Text(
                  '张风捷特烈',
                  style: TextStyle(color: Colors.white70),
                )
              ],
            ),
            buildIcons(),
            const Divider(
              color: Colors.white,
              height: 1,
              endIndent: 20,
            ),
//          SizedBox(height: 60,),
            Expanded(
              flex: 5,
              child: Center(
                  //const Size(120, 35)
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: info
                    .asMap()
                    .keys
                    .map((int index) => _UnitRailMenu(
                          onTap: () {onItemClick.call(index);},
                          selected: selectedIndex == index,
                          width: 120,
                          height: 35, activeColor: Theme.of(context).primaryColor, inactiveColor:
                Colors.white.withAlpha(33), icon: icons[index],label: info[index],
                        ))
                    .toList(),
              )

                  // RightNavBar(
                  //   itemData: Cons.iconMap,
                  //   onItemClick: onItemClick,
                  //   color: Theme.of(context).primaryColor,
                  // ),
                  ),
            ),
            Expanded(
              child: Container(),
              flex: 1,
            ),
            const Divider(
              indent: 20,
              color: Colors.white,
              height: 1,
            ),
            Builder(
              builder: (ctx) => FeedbackWidget(
                onPressed: () => Scaffold.of(ctx).openDrawer(),
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  child: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }

  Widget buildIcons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 20),
      child: Wrap(
        spacing: 5,
        children: [
          FeedbackWidget(
            onPressed: () => _launchURL("http://blog.toly1994.com"),
            child: const Icon(
              TolyIcon.icon_item,
              color: Colors.white,
            ),
          ),
          FeedbackWidget(
            onPressed: () =>
                _launchURL("https://github.com/toly1994328/FlutterUnit"),
            child: const Icon(
              TolyIcon.icon_github,
              color: Colors.white,
            ),
          ),
          FeedbackWidget(
            onPressed: () =>
                _launchURL("https://juejin.im/user/5b42c0656fb9a04fe727eb37"),
            child: const Icon(
              TolyIcon.icon_juejin,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      debugPrint('Could not launch $url');
    }
  }
}

class RightNavBar extends StatefulWidget {
  final Color color;
  final Map<String, IconData> itemData;
  final ValueChanged<int> onItemClick;
  final Size itemSize;

  RightNavBar({
    this.color = Colors.blue,
    required this.itemData,
    required this.onItemClick,
    this.itemSize = const Size(120, 35),
  });

  @override
  _RightNavBarState createState() => _RightNavBarState();
}

class _RightNavBarState extends State<RightNavBar> {
  int _position = 0;

  List<String> get info => widget.itemData.keys.toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: info
          .map((e) => _buildChild(context, info.indexOf(e), widget.color))
          .toList(),
    );
  }

  Widget _buildChild(BuildContext context, int i, Color color) {
    var active = i == _position;

    return GestureDetector(
        onTap: () => _tapTab(i),
        child: Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(top: 10),
          width: widget.itemSize.width,
          child: UnconstrainedBox(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: active ? widget.color : Colors.white.withAlpha(33),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              width: active
                  ? widget.itemSize.width * 0.95
                  : widget.itemSize.width * 0.85,
              height: widget.itemSize.height,
              child: Wrap(
                spacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(
                    widget.itemData[info[i]],
                    size: active ? 24 : 20,
                    color: active ? Colors.white : Colors.white70,
                  ),
                  Text(
                    info[i],
                    style: TextStyle(
                      color: active ? Colors.white : Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _tapTab(int i) {
    setState(() {
      _position = i;
      if (widget.onItemClick != null) {
        widget.onItemClick(_position);
      }
    });
  }
}

class _UnitRailMenu extends StatelessWidget {
  final VoidCallback onTap;
  final bool selected;
  final Color activeColor;
  final Color inactiveColor;
  final double width;
  final double height;
  final IconData icon;
  final String label;

  const _UnitRailMenu({
    Key? key,
    required this.onTap,
    required this.selected,
    required this.width,
    required this.activeColor,
    required this.inactiveColor,
    required this.height,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(top: 10),
          width: width,
          child: UnconstrainedBox(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: selected ? activeColor : inactiveColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              width: selected ? width * 0.95 : width * 0.85,
              height: height,
              child: Wrap(
                spacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: selected ? 24 : 20,
                    color: selected ? Colors.white : Colors.white70,
                  ),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: selected ? Colors.white : Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
