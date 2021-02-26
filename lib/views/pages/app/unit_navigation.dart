import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/router/unit_router.dart';
import 'package:flutter_unit/blocs/bloc_exp.dart';
import 'package:flutter_unit/views/components/project/overlay_tool_wrapper.dart';
import 'package:flutter_unit/views/pages/app/unit_bottom_bar.dart';
import 'package:flutter_unit/views/pages/category/collect_page.dart';
import 'package:flutter_unit/views/pages/category/home_right_drawer.dart';
import 'package:flutter_unit/painter_system/gallery_unit.dart';
import 'package:flutter_unit/views/pages/user/user_page.dart';
import 'package:flutter_unit/views/pages/widget_home/home_drawer.dart';
import 'package:flutter_unit/views/pages/widget_home/home_page.dart';

/// create by 张风捷特烈 on 2020-04-11
/// contact me by email 1981462002@qq.com
/// 说明: 主题结构 左右滑页 + 底部导航栏


class UnitNavigation extends StatefulWidget {
  @override
  _UnitNavigationState createState() => _UnitNavigationState();
}

class _UnitNavigationState extends State<UnitNavigation> {
  //页面控制器，初始 0
  final PageController _controller = PageController();

  // 禁止 PageView 滑动
  final ScrollPhysics neverScroll = const NeverScrollableScrollPhysics();


  @override
  void dispose() {
    _controller.dispose(); //释放控制器
    super.dispose();
  }

  /// extendBody = true 凹嵌透明，需要处理底部 边距
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        drawer: HomeDrawer(),
        endDrawer: HomeRightDrawer(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _buildSearchButton(context),
        body: wrapOverlayTool(
          child: PageView(
            physics: neverScroll,
            controller: _controller,
            children: <Widget>[
              HomePage(),
              GalleryUnit(),
              CollectPage(),
              UserPage(),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNav(context));
  }

  // 构建悬浮按钮工具
  Widget wrapOverlayTool({Widget child}) => Builder(
      builder: (ctx) => OverlayToolWrapper(
            child: child,
          ));

  // 主页搜索按钮
  // 由于 按钮 颜色需要随 点击头部栏 状态而改变，
  // 使用 BlocBuilder 构建
  Widget _buildSearchButton(BuildContext context) =>
      BlocBuilder<WidgetsBloc, WidgetsState>(
          builder: (_, state) => FloatingActionButton(
                elevation: 2,
                backgroundColor: state.color,
                child: const Icon(Icons.search),
                onPressed: () =>
                    Navigator.of(context).pushNamed(UnitRouter.search),
              ));

  // 由于 bottomNavigationBar 颜色需要随 点击头部栏 状态而改变，
  // 使用 BlocBuilder 构建
  BlocBuilder<WidgetsBloc, WidgetsState> _buildBottomNav(BuildContext context) =>
      BlocBuilder<WidgetsBloc, WidgetsState>(
          builder: (_, state) => UnitBottomBar(
              color: state.color,
              onItemClick: _onTapBottomNav));

  // 点击底部按钮事件，切换页面
  _onTapBottomNav(int index) {
    _controller.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.linear);
    if (index == 2) {
      BlocProvider.of<LikeWidgetBloc>(context).add(EventLoadLikeData());
    }
  }
}
