import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 345 InheritedTheme 传承主题
/// 它是抽象类，有非常多的 XXXTheme 相关子类，用于定义颜色、文字样式等属性，在子树中共享这些属性。
/// link 324,326,328,329
///
//    {
//      "widgetId": 345,
//      "name": 'InheritedTheme 介绍',
//      "priority": 1,
//      "subtitle":
//          "InheritedTheme.capture 可以抓取上层主题，获取 CapturedThemes 对象，通过该对象 wrap 方法可以跨路由使用抓到的主题。",
//    }

class InheritedThemeDemo extends StatelessWidget {
  const InheritedThemeDemo({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const DefaultTextStyle(
      style: TextStyle(fontSize: 24, color: Colors.blue),
      child: TestBody(),
    );
  }
}

class TestBody extends StatelessWidget {
  const TestBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: () => _toNextPage(context),
        child: Container(
            height: 60,
            margin: const EdgeInsets.only(left: 40,right: 40),
            alignment: Alignment.center,
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: const Text('InheritedTheme')));
  }

  void _toNextPage(BuildContext context) {
    // final NavigatorState navigator = Navigator.of(context);
    // final CapturedThemes themes =
    // InheritedTheme.capture(from: context, to: navigator.context);
    //
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (BuildContext _) {
    //       return themes.wrap(Container(
    //         alignment: Alignment.center,
    //         color: Colors.white,
    //         child: Text('Flutter Unit'),
    //       ));
    //     },
    //   ),
    // );
  }
}
