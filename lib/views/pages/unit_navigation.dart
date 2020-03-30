import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/blocs/global/global_bloc.dart';
import 'package:flutter_unit/views/widgets/StatelessWidget/button/FloatingActionButton.dart';
import 'act_page.dart';
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
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                backgroundColor: state.color,
//        shape: StarBorder(),
                child: Icon(Icons.search),
                onPressed: () {
                  Navigator.of(context).pushNamed(Router.search);
                },
              ),
              body: PageView(
                //使用PageView实现五个页面的切换
                controller: _controller,
                children: <Widget>[
                  HomePage(),
                  ActPage(),
//          LovePage(),
//          NotePage(),
//          MePage(),
                ],
              ),
              bottomNavigationBar: _buildBottomNavigationBar(state.color),
            ));
  }

//  Color antiColor(Color color) {
//    print(color.alpha);
//    return Color.fromARGB(
//            color.alpha, 255 - color.red, 255 - color.green, 255 - color.blue)
//        .withAlpha(99);
//  }

  Widget _buildBottomNavigationBar(Color color) {
    return BottomAppBar(
        elevation: 0,
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: Cons.ICONS_MAP.keys
              .map((e) => _buildChild(info.indexOf(e), color))
              .toList(),
        ));
  }

  List<String> get info => Cons.ICONS_MAP.keys.toList();

  var activeColor = Colors.blue.withAlpha(240);

  Widget _buildChild(int i, Color color) {
    var active = i == _position;
    bool left = i == 0;
    return GestureDetector(
      onTap: () {
        setState(() {
          _position = i;
          _controller.animateToPage(_position,
              duration: Duration(milliseconds: 200), curve: Curves.linear);
        });
      },
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
              Cons.ICONS_MAP[info[i]],
              color: active ? color : Colors.white,
              size: active ? 28 : 24,
            )),
      ),
    );
  }
}
