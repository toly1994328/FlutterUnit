import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/app/router/unit_router.dart';

import 'package:flutter_unit/painter_system/gallery_unit.dart';
import 'package:flutter_unit/user_system/pages/user/user_page.dart';
import 'package:flutter_unit/components/project/nav/unit_bottom_bar.dart';
import 'package:flutter_unit/components/project/overlay_tool_wrapper.dart';
import 'package:flutter_unit/widget_system/blocs/widget_system_bloc.dart';

import 'package:flutter_unit/widget_system/views/widget_system_view.dart';


import '../../blocs/color_change_bloc.dart';

/// create by 张风捷特烈 on 2020-04-11
/// contact me by email 1981462002@qq.com
/// 说明: 主题结构 左右滑页 + 底部导航栏


class UnitNavigation extends StatefulWidget {
  const UnitNavigation();

  @override
  _UnitNavigationState createState() => _UnitNavigationState();
}

class _UnitNavigationState extends State<UnitNavigation> {
  //页面控制器，初始 0
  final PageController _controller = PageController();

  // 禁止 PageView 滑动
  final ScrollPhysics _neverScroll = const NeverScrollableScrollPhysics();

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
          physics: _neverScroll,
          controller: _controller,
          children: <Widget>[
            HomePage(),
            GalleryUnit(),
            CollectPage(),
            UserPage(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  // 构建悬浮按钮工具
  Widget wrapOverlayTool({required Widget child}) => Builder(
      builder: (ctx) => OverlayToolWrapper(
            child: child,
          ));

  // 主页搜索按钮
  // 由于 按钮 颜色需要随 点击头部栏 状态而改变，
  // 使用 BlocBuilder 构建
  Widget _buildSearchButton(BuildContext context) =>
      BlocBuilder<ColorChangeCubit, SelectTab>(
          builder: (_, state) => FloatingActionButton(
                elevation: 2,
                backgroundColor: state.color,
                child: const Icon(Icons.search),
                onPressed: () =>
                    Navigator.of(context).pushNamed(UnitRouter.search),
              ));

  // 由于 bottomNavigationBar 颜色需要随 点击头部栏 状态而改变，
  // 使用 BlocBuilder 构建
  Widget _buildBottomNav(BuildContext context) =>
      BlocBuilder<ColorChangeCubit, SelectTab>(
        builder: (context, state) => UnitBottomBar(
          color: state.color,
          onItemTap: _onTapBottomNav,
          onItemLongTap: _onItemLongTap,
        ),
      );

  // 点击底部按钮事件，切换页面
  _onTapBottomNav(int index) {
    _controller.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.linear);
    if(index!=0){
      context.read<ColorChangeCubit>().change(Theme.of(context).primaryColor);
    }else{
      Color color = Cons.tabColors[context.read<ColorChangeCubit>().state.family.index];
      context.read<ColorChangeCubit>().change(color);
    }

    if (index == 2) {
      BlocProvider.of<LikeWidgetBloc>(context).add(EventLoadLikeData());
    }
  }

  // 两侧
  void _onItemLongTap(BuildContext context , int index) {
    if (index == 0) {
      Scaffold.of(context).openDrawer();
    }
    if (index == 3) {
      Scaffold.of(context).openEndDrawer();
    }
  }
}
