import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/19
/// contact me by email 1981462002@qq.com
/// 说明:
///
//    {
//      "widgetId": 232,
//      "name": 'Navigator基本用法',
//      "priority": 1,
//      "subtitle":
//          "【initialRoute】 : 最初显示路由   【String】\n"
//          "【onGenerateRoute】 : 路由生成器   【RouteFactory】\n"
//          "【observers】 : 路由监听器   【List<NavigatorObserver>】\n"
//          "【onPopPage】 : 出栈回调   【PopPageCallback】",
//    }
class NavigatorDemo extends StatelessWidget {
  const NavigatorDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 300,
      child: Navigator(
        onPopPage: _onPopPage,
        initialRoute: '/home-content',
        onGenerateRoute: _onGenerateRoute,
        observers: [TolyNavigatorObservers()],
      ),
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home-content':
        return MaterialPageRoute(
            builder: (_) => const HomeContent(), settings: settings);
      case "/red":
        return MaterialPageRoute(builder: (_) => const RedPage(), settings: settings);
      case "/yellow":
        return MaterialPageRoute(
            builder: (_) => const YellowPage(), settings: settings);
      case "/green":
        return MaterialPageRoute(
            builder: (_) => const GreenPage(), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => const HomeContent(), settings: settings);
    }
  }

  bool _onPopPage(Route<dynamic> route, result) {
    print('----_onPopPage-----');
    return true;
  }
}

//路由监听器
class TolyNavigatorObservers extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print(
        '--didPush:--route:--${route.settings}--previousRoute:--${previousRoute?.settings}');
  }

  @override
  void didStopUserGesture() {
    print('--didStopUserGesture:--');
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print(
        '--didStartUserGesture:--route:--${route.settings}--previousRoute:--${previousRoute?.settings}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    print(
        '--didReplace:--newRoute:--${newRoute?.settings}--oldRoute:--${oldRoute?.settings}');
  }

  @override
  void didRemove(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    print(
        '--didRemove:--route:--${route?.settings}--previousRoute:--${previousRoute?.settings}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print(
        '--didPop:--route:--${route.settings}--previousRoute:--${previousRoute?.settings}');
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                shape: const CircleBorder(
                  side: BorderSide(width: 2.0, color: Color(0xFFDFDFDF)),
                ),
              ),
              child: const Text('to red'),
              onPressed: () {
                Navigator.pushNamed(context, '/red');
              },
            ),
            ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.yellow,
                shape: const CircleBorder(
                  side: BorderSide(width: 2.0, color: Color(0xFFDFDFDF)),
                ),
              ),
              child: const Text('to yellow'),
              onPressed: () {
                Navigator.pushNamed(context, '/yellow');
              },
            ),
            ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                shape: const CircleBorder(
                  side: BorderSide(width: 2.0, color: Color(0xFFDFDFDF)),
                ),
              ),
              child: const Text('to yellow'),
              onPressed: () {
                Navigator.pushNamed(context, '/green');
              },
            )
          ],
        ),
      ],
    );
  }
}

class RedPage extends StatelessWidget {
  const RedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RedPage"),
      ),
      body: Container(
        color: Colors.red,
      ),
    );
  }
}

class YellowPage extends StatelessWidget {
  const YellowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("YellowPage"),
      ),
      body: Container(
        color: Colors.yellow,
      ),
    );
  }
}

class GreenPage extends StatelessWidget {
  const GreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GreenPage"),
      ),
      body: Container(
        color: Colors.green,
      ),
    );
  }
}
