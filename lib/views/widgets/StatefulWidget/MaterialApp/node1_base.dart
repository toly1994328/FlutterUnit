import 'package:flutter/material.dart';
import '../../../../app/router.dart';
import '../../StatefulWidget/Scaffold/node1_base.dart';

/// create by 张风捷特烈 on 2020-03-17
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 65,
//      "name": 'MaterialApp基本用法',
//      "priority": 1,
//      "subtitle":
//          "【theme】 : 主题   【ThemeData】\n"
//          "【title】 : 任务栏标题   【String】\n"
//          "【debugShowCheckedModeBanner】 : 开启角标   【bool】\n"
//          "【showPerformanceOverlay】 : 开启性能浮层   【bool】\n"
//          "【debugShowMaterialGrid】 : 开启网格   【bool】\n"
//          "【onGenerateRoute】 : 路由生成器   【RouteFactory】\n"
//          "【home】 : 主页   【Widget】",
//    }
class MaterialAppDemo extends StatefulWidget {
  @override
  _WidgetsAppDemoState createState() => _WidgetsAppDemoState();
}

class _WidgetsAppDemoState extends State<MaterialAppDemo> {
  var _debugShowCheckedModeBanner = false;
  var _showPerformanceOverlay = false;
  var _debugShowMaterialGrid = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSwitchers(),
        Container(
          height: 250,
          child: MaterialApp(
            debugShowCheckedModeBanner: _debugShowCheckedModeBanner,
            showPerformanceOverlay: _showPerformanceOverlay,
            debugShowMaterialGrid: _debugShowMaterialGrid,
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
                value: _debugShowMaterialGrid,
                onChanged: (v) {
                  setState(() {
                    _debugShowMaterialGrid = v;
                  });
                },
              ),
              Text('开启网格')
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
