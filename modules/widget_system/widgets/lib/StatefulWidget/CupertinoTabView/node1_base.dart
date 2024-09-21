import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com


class CupertinoTabViewDemo extends StatelessWidget {
  const CupertinoTabViewDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const CupertinoTabViewPage()),
          );
        },
        child: const Text("进入 CupertinoTabView 测试页"),
      ),
    );
  }
}


class CupertinoTabViewPage extends StatelessWidget {
  const CupertinoTabViewPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: CupertinoTabView(
        routes: {
          '/': (context) => _HomePage(),
          '/test_detail': (context) => const DetailPage(),
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('我是详情页'),
      ),
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.blue,
        ),
      ),
    );
  }
}

class _HomePage extends StatelessWidget {

  final String info = "CupertinoTabView 可以像 MaterialApp 一样维护一个路由栈。"
      "通过 routes 、onGenerateRoute 来构建路由，可以通过 navigatorObservers 监听路由。"
      "在这个路由栈中可以进行指定名称跳转，如下通过 /test_detail 跳到详情页。";

  @override
  Widget build(BuildContext context) {
    return  CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('我是主页'),
      ),
      child: Center(child: Column(

        children: [
          const Spacer(),
          Material(child: Padding(
            padding: const EdgeInsets.only(left:18.0,right: 18,bottom: 20),
            child: Text(info),
          )),
          CupertinoButton(
            padding: const EdgeInsets.only(left: 10,right: 10),
            color: Colors.blue,
            onPressed: () {
              Navigator.pushNamed(
                context, "/test_detail"
              );
            },
            child: const Text("进入详情页"),
          ),
          const Spacer(),
        ],
      )),
    );
  }
}
