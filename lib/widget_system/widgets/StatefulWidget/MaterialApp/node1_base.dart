import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-17
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 65,
//      "name": 'MaterialApp基本用法',
//      "priority": 1,
//      "subtitle": "【theme】 : 主题   【ThemeData】\n"
//          "【title】 : 任务栏标题   【String】\n"
//          "【debugShowCheckedModeBanner】 : 开启角标   【bool】\n"
//          "【showPerformanceOverlay】 : 开启性能浮层   【bool】\n"
//          "【debugShowMaterialGrid】 : 开启网格   【bool】\n"
//          "【onGenerateRoute】 : 路由生成器   【RouteFactory】\n"
//          "【home】 : 主页   【Widget】",
//    }
class MaterialAppDemo extends StatefulWidget {
  const MaterialAppDemo({Key? key}) : super(key: key);

  @override
  _WidgetsAppDemoState createState() => _WidgetsAppDemoState();
}

class _WidgetsAppDemoState extends State<MaterialAppDemo> {
  bool _debugShowCheckedModeBanner = false;
  bool _showPerformanceOverlay = false;
  bool _debugShowMaterialGrid = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSwitchers(),
        SizedBox(
          height: 250,
          child: MaterialApp(
            debugShowCheckedModeBanner: _debugShowCheckedModeBanner,
            showPerformanceOverlay: _showPerformanceOverlay,
            debugShowMaterialGrid: _debugShowMaterialGrid,
            home: const HomePage(),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchers() {
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.blue),
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
              const Text('性能浮层')
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
              const Text('开启角标')
            ],
          ),
          Column(
            children: [
              Switch(
                value: _debugShowMaterialGrid,
                onChanged: (v) {
                  setState(() {
                    _debugShowMaterialGrid = v;
                  });
                },
              ),
              const Text('开启网格')
            ],
          )
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: const Alignment(0, 0.7),
        child: Text(
          '你点击了$_count次',
          style: const TextStyle(fontSize: 18, color: Colors.blue),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            _count++;
          });
        },
      ),
    );
  }
}
