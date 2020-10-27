import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/8/16
/// contact me by email 1981462002@qq.com
/// 说明: 236 WidgetsApp 集合一个应用程序需要的部件,如路由、语言、一些调试开关等。也是实现MaterialApp和CupertinoApp的核心组件。
//    {
//      "widgetId": 236,
//      "name": "WidgetsApp基本使用",
//      "priority": 1,
//      "subtitle": "【pageRouteBuilder】 : *路由构造器   【PageRouteFactory】\n"
//          "【color】: *颜色    【Color】\n"
//          "【debugShowWidgetInspector】: 是否显示z组件查看器   【bool】\n"
//          "其他属性基本上同MaterialApp,详见之。",
//    }
class WidgetsAppDemo extends StatefulWidget {
  @override
  _WidgetsAppDemoState createState() => _WidgetsAppDemoState();
}

class _WidgetsAppDemoState extends State<WidgetsAppDemo> {
  var _debugShowCheckedModeBanner = false;
  var _debugShowWidgetInspector = false;
  var _showPerformanceOverlay = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSwitchers(),
        Container(
          height: 250,
          child: WidgetsApp(
            color: Colors.blue,
            debugShowCheckedModeBanner: _debugShowCheckedModeBanner,
            showPerformanceOverlay: _showPerformanceOverlay,
            debugShowWidgetInspector: _debugShowWidgetInspector,
            pageRouteBuilder:
                <T>(RouteSettings settings, WidgetBuilder builder) {
              return MaterialPageRoute<T>(settings: settings, builder: builder);
            },
            home: HomePage(),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchers() {
    return DefaultTextStyle(
      style: TextStyle(color: Colors.blue),
      child: Wrap(
        spacing: 10,
        children: [
          Column(
            children: [
              Switch(
                value: _showPerformanceOverlay,
                onChanged: (v) {
                  setState(() {
                    _showPerformanceOverlay = v;
                  });
                },
              ),
              Text('性能浮层')
            ],
          ),
          Column(
            children: [
              Switch(
                value: _debugShowCheckedModeBanner,
                onChanged: (v) {
                  setState(() {
                    _debugShowCheckedModeBanner = v;
                  });
                },
              ),
              Text('开启角标')
            ],
          ),
          Column(
            children: [
              Switch(
                value: _debugShowWidgetInspector,
                onChanged: (v) {
                  setState(() {
                    _debugShowWidgetInspector = v;
                  });
                },
              ),
              Text('检查器')
            ],
          )
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment(0, 0.7),
        child: Text(
          '你点击了$_count次',
          style: TextStyle(fontSize: 18, color: Colors.blue),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            _count++;
          });
        },
      ),
    );
  }
}
