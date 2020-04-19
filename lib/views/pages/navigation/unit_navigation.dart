import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/blocs/collect/collect_bloc.dart';
import 'package:flutter_unit/blocs/collect/collect_event.dart';
import 'package:flutter_unit/blocs/widgets/home_bloc.dart';
import 'package:flutter_unit/blocs/widgets/home_state.dart';
import 'package:flutter_unit/views/pages/collect/default_collect_page.dart';
import 'package:flutter_unit/views/pages/collect/home_right_drawer.dart';
import 'package:flutter_unit/views/pages/navigation/unit_bottom_bar.dart';
import '../collect/collect_page.dart';
import '../home/home_page.dart';
import '../setting/home_drawer.dart';

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
            drawer: HomeDrawer(color:state.homeColor),
            //左滑页
            endDrawer: HoneRightDrawer(color: state.homeColor,),
            //右滑页
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: _buildSearchButton(state.homeColor),
            body: PageView(
              physics: NeverScrollableScrollPhysics(),
              //使用PageView实现页面的切换
              controller: _controller,
              children: <Widget>[
                HomePage(),
                DefaultCollectPage(),
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
      child: Icon(Icons.search),
      onPressed: () => Navigator.of(context).pushNamed(Router.search),
    );
  }

  _onTapNav(int index) {
    _controller.animateToPage(index,
        duration: Duration(milliseconds: 200), curve: Curves.linear);
    if (index == 1) {
      BlocProvider.of<CollectBloc>(context).add(EventSetCollectData());
    }
  }
}
