import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/blocs/collect/collect_bloc.dart';
import 'package:flutter_unit/blocs/collect/collect_event.dart';
import 'package:flutter_unit/blocs/global/global_bloc.dart';
import 'package:flutter_unit/blocs/global/global_state.dart';
import 'package:flutter_unit/blocs/search/search_bloc.dart';
import 'package:flutter_unit/blocs/search/search_event.dart';
import 'package:flutter_unit/database/widget_dao.dart';
import 'package:flutter_unit/views/home/home_light_drawer.dart';
import 'package:flutter_unit/views/widgets/StatelessWidget/FloatingActionButton.dart';
import 'collect_page.dart';
import 'setting/home_drawer.dart';
import 'home_page.dart';
import 'love_page.dart';
import 'me_page.dart';
import 'note_page.dart';

class UnitNavigation extends StatefulWidget {
  @override
  _UnitNavigationState createState() => _UnitNavigationState();
}

class _UnitNavigationState extends State<UnitNavigation> {
  var _position = 0; //当前激活页
  PageController _controller; //页面控制器，初始0

  @override
  void initState() {
    _controller = PageController(
      initialPage: _position,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose(); //释放控制器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
        builder: (_, state) => Scaffold(
            drawer: HomeDrawer(), //左滑页
            endDrawer: HomeDrawer(), //右滑页
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              backgroundColor: state.color,
              child: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).pushNamed(Router.search);
              },
            ),
            body: PageView(
              physics: NeverScrollableScrollPhysics(),
              //使用PageView实现页面的切换
              controller: _controller,
              children: <Widget>[
                HomePage(),
                CollectPage(),
              ],
            ),
            bottomNavigationBar:
                UnitBottomBar(
                    color: state.color,
                    itemData: Cons.ICONS_MAP, onItemClick: _onTapNav)

//              _buildBottomNavigationBar(state.color),
            ));
  }

  _onTapNav(int index) {
    _controller.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.linear);
    if (index == 1) {
      BlocProvider.of<CollectBloc>(context).add(EventSetCollectData());
    }
  }
}

class UnitBottomBar extends StatefulWidget {
  final Color color;
  final Map<String, IconData> itemData;
  final Function(int) onItemClick;

  UnitBottomBar(
      {this.color = Colors.blue,
      @required this.itemData,
      @required this.onItemClick});

  @override
  _UnitBottomBarState createState() => _UnitBottomBarState();
}

class _UnitBottomBarState extends State<UnitBottomBar> {
  int _position = 0;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        elevation: 0,
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        color: widget.color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widget.itemData.keys
              .map((e) => _buildChild(info.indexOf(e), widget.color))
              .toList(),
        ));
  }

  List<String> get info => widget.itemData.keys.toList();

  Widget _buildChild(int i, Color color) {
    var active = i == _position;
    bool left = i == 0;
    return GestureDetector(
      onTap: () => setState(() {
        _position = i;
        if (widget.onItemClick != null) {
          widget.onItemClick(_position);
        }
//        _controller.animateToPage(_position,
//            duration: Duration(milliseconds: 200), curve: Curves.linear);
//        if(_position==1){
//          BlocProvider.of<CollectBloc>(context).add(EventSetCollectData());
//        }
      }),
      child: Material(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: left
                ? BorderRadius.only(topRight: Radius.circular(10))
                : BorderRadius.only(topLeft: Radius.circular(10))),
        child: Container(
            margin: left
                ? EdgeInsets.only(top: 2, right: 2)
                : EdgeInsets.only(top: 2, left: 2),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: color.withAlpha(88),
                borderRadius: left
                    ? BorderRadius.only(topRight: Radius.circular(10))
                    : BorderRadius.only(topLeft: Radius.circular(10))),
            height: 45,
            width: 100,
            child: Icon(
              widget.itemData[info[i]],
              color: active ? color : Colors.white,
              size: active ? 28 : 24,
            )),
      ),
    );
  }
}
