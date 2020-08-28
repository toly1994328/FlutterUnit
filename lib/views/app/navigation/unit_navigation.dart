import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/blocs/bloc_exp.dart';
import 'package:flutter_unit/views/app/navigation/unit_bottom_bar.dart';
import 'package:flutter_unit/views/pages/category/collect_page.dart';
import 'package:flutter_unit/views/pages/category/home_right_drawer.dart';
import 'package:flutter_unit/views/pages/home/home_drawer.dart';
import 'package:flutter_unit/views/pages/home/home_page.dart';


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
        builder: (_, state) => Scaffold(
            drawer: HomeDrawer(color:state.homeColor), //左滑页
            endDrawer: HomeRightDrawer(color: state.homeColor), //右滑页
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: _buildSearchButton(state.homeColor),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              children: <Widget>[
                HomePage(),
                CollectPage(),
              ],
            ),
            bottomNavigationBar: UnitBottomBar(
                color: state.homeColor,
                itemData: Cons.ICONS_MAP,
                onItemClick: _onTapNav)));
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
    _controller.animateToPage(index,
        duration:const Duration(milliseconds: 200), curve: Curves.linear);
    if (index == 1) {
      BlocProvider.of<CollectBloc>(context).add(EventSetCollectData());
    }
  }
}
