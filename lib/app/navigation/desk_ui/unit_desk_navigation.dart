import 'package:algorithm/algorithm.dart';
import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/code_gen/code_gen_page.dart';

import 'package:flutter_unit/painter_system/gallery_unit.dart';
import 'package:flutter_unit/widget_ui/desk_ui/widget_panel/widget_panel.dart';
import 'package:flutter_unit/widget_ui/mobile/category_page/collect_page.dart';
import 'package:flutter_unit/widget_ui/mobile/category_page/home_right_drawer.dart';
import '../../../point_system/views/desk_ui/desk_point_page.dart';
import '../home_drawer.dart';
import 'unit_rail_navigation.dart';

class UnitDeskNavigation extends StatefulWidget {

  const UnitDeskNavigation();

  @override
  _UnitDeskNavigationState createState() => _UnitDeskNavigationState();

}

class _UnitDeskNavigationState extends State<UnitDeskNavigation> {
  late PageController _controller; //页面控制器，初始0
  int _currentIndex = 0;

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
    return Scaffold(
          drawer: const HomeDrawer(),
          endDrawer: const HomeRightDrawer(),
          body: Row(
            children: [
              UnitRailNavigation(
                selectedIndex: _currentIndex,
                onItemClick: _onItemClick, itemData: const {
                "组件集录": TolyIcon.icon_layout,
                "收藏集录": TolyIcon.icon_star,
                "绘制集录": Icons.palette,
                "可视排序": Icons.sort,
                "代码生成": TolyIcon.icon_fast,
                "要点集录": TolyIcon.icon_bug,
                },
              ),
              // _buildLeftNav(),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  //使用PageView实现页面的切换
                  controller: _controller,
                  children: const <Widget>[
                    DeskWidgetPanel(),
                    CollectPageAdapter(),
                    GalleryUnit(),
                    DeskSortPage(),
                    CodeGenPage(),
                    DeskPointPage(),
                  ],
                ),
              ),
            ],
          ),
        );
  }

  void _onItemClick(int value) {
    _currentIndex = value;
    _controller.jumpToPage(_currentIndex);
    setState(() {

    });
  }
}

