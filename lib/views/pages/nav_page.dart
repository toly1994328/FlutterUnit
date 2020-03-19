import 'package:flutter/material.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'act_page.dart';
import 'home_page.dart';
import 'love_page.dart';
import 'me_page.dart';
import 'note_page.dart';

class NavPage extends StatefulWidget {
  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
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
    return Scaffold(
      body: PageView(
        //使用PageView实现五个页面的切换
        controller: _controller,
        children: <Widget>[
          HomePage(),
          ActPage(),
          LovePage(),
          NotePage(),
          MePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        //底部栏
        items: Cons.ICONS_MAP.keys
            .map((key) => BottomNavigationBarItem(
                //生成条目
                title: Text(
                  key,
                ), //标题
                icon: Icon(Cons.ICONS_MAP[key]), //图标
                backgroundColor: Colors.blue))
            .toList(), //背景色
        currentIndex: _position, //激活位置
        onTap: (position) {
          _controller.jumpToPage(position); //点击时通过控制器切换PageView页面
          setState(() {
            _position = position; //更新索引位
          });
        },
      ),
    );
  }
}
