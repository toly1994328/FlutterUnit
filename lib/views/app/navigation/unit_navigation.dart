import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/blocs/bloc_exp.dart';
import 'package:flutter_unit/components/permanent/overlay_tool_wrapper.dart';
import 'package:flutter_unit/views/app/navigation/unit_bottom_bar.dart';
import 'package:flutter_unit/views/pages/category/collect_page.dart';
import 'package:flutter_unit/views/pages/category/home_right_drawer.dart';
import 'package:flutter_unit/views/pages/home/home_drawer.dart';
import 'package:flutter_unit/views/pages/home/home_page.dart';

/// create by 张风捷特烈 on 2020-04-11
/// contact me by email 1981462002@qq.com
/// 说明: 主题结构 左右滑页 + 底部导航栏

class UnitNavigation extends StatefulWidget {
  @override
  _UnitNavigationState createState() => _UnitNavigationState();
}

class _UnitNavigationState extends State<UnitNavigation> {
  PageController _controller; //页面控制器，初始0

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose(); //释放控制器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {

        final Color color =  BlocProvider.of<HomeBloc>(context).activeHomeColor;


        return Scaffold(
          drawer: HomeDrawer(),
          //左滑页
          endDrawer: HomeRightDrawer(),
          //右滑页
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _buildSearchButton(color),
          body: wrapOverlayTool(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              children: <Widget>[
                HomePage(),
                CollectPage(),
              ],
            ),
          ),
          bottomNavigationBar: UnitBottomBar(
              color: color,
              itemData: Cons.ICONS_MAP,
              onItemClick: _onTapNav));
      },
    );
  }

  // OverlayToolWrapper 在此 添加 因为Builder外层: 因为需要 Scaffold 的上下文，打开左右滑页
  Widget wrapOverlayTool({Widget child}) {
    return Builder(
        builder: (ctx) => OverlayToolWrapper(
              child: child,
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
    _controller.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.linear);
    if (index == 1) {
      BlocProvider.of<CollectBloc>(context).add(EventSetCollectData());
    }
  }
}
