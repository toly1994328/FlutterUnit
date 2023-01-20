import 'package:app_config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/plateform_adapter/window/windows_adapter.dart';
import 'package:flutter_unit/app/views/unit_todo/layout_unit_page.dart';
import 'package:flutter_unit/app/views/unit_todo/point_unit_page.dart';
import 'package:components/toly_ui/toly_ui.dart';

import 'package:flutter_unit/painter_system/gallery_unit.dart';
import 'package:flutter_unit/widget_ui/desk/widget_panel/widget_panel.dart';
import 'package:flutter_unit/widget_ui/mobile/category_page/collect_page.dart';
import 'package:flutter_unit/widget_ui/mobile/category_page/home_right_drawer.dart';
import 'package:old_fancy_mobile_ui/bloc/color_change_bloc.dart';

import 'package:url_launcher/url_launcher.dart';

import 'home_drawer.dart';



class UnitDeskNavigation extends StatefulWidget {

  const UnitDeskNavigation();

  @override
  _UnitDeskNavigationState createState() => _UnitDeskNavigationState();

}

class _UnitDeskNavigationState extends State<UnitDeskNavigation> {
  late PageController _controller; //页面控制器，初始0

  @override
  void initState() {
    super.initState();
    _controller = PageController();

    // ActionUnit.searchAction.onSearch = () {
    //   Navigator.of(context).pushNamed(UnitRouter.search);
    // };
  }

  @override
  void dispose() {
    _controller.dispose(); //释放控制器
    super.dispose();
  }

  // 构建悬浮按钮工具
  // Widget wrapOverlayTool({required Widget child}) => Builder(
  //     builder: (ctx) => OverlayToolWrapper(
  //       child: child,
  //     ));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorChangeCubit, SelectTab>(
        builder: (_, state) => Scaffold(
              drawer: const HomeDrawer(),
              endDrawer: const HomeRightDrawer(),
              //右滑页
              // floatingActionButton: _buildSearchButton(state.tabColor),
              body: Row(
                children: [
                  _buildLeftNav(),
                  Expanded(
                    child: Container(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        //使用PageView实现页面的切换
                        controller: _controller,
                        children: const <Widget>[
                          // HomePage(),
                          DeskWidgetPanel(),
                          CollectPage(),
                          GalleryUnit(),
                          // GalleryPage(),
                          // PaintUnitPage(),
                          LayoutUnitPage(),
                          BugUnitPage(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  Widget _buildSearchButton(Color color) {
    return FloatingActionButton(
      elevation: 2,
      backgroundColor: color,
      child: const Icon(Icons.search),
      onPressed: () => Navigator.of(context).pushNamed(UnitRouter.search),
    );
  }

  _onTapNav(int index) {
    _controller.jumpToPage(index);
    if (index == 1) {
      // BlocProvider.of<CollectBloc>(context).add(EventSetCollectData());
    }
  }

  Widget _buildLeftNav() {
    return DragToMoveAreaNoDouble(
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(right: 1),
        width: 120,
        decoration: const BoxDecoration(color:
        Color(0xff2C3036),
            boxShadow: [
          BoxShadow(color: Colors.grey, offset: Offset(1, 0), blurRadius: 2)
        ]
        ),
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
                child: RightNavBar(
                  itemData: Cons.iconMap,
                  onItemClick: _onTapNav,
                  color: Theme.of(context).primaryColor,
                ),
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
  final Function(int) onItemClick;
  final Size itemSize;

  RightNavBar(
      {this.color = Colors.blue,
     required this.itemData,
        required this.onItemClick,
      this.itemSize = const Size(120, 35)});

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
