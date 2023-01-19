import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/21
/// contact me by email 1981462002@qq.com
/// 说明: 255 ValueListenableBuilder 1 可以监听一个值，当其变化时通过builder回调能重建界面，避免使用setState刷新。
//    {
//      "widgetId": 255,
//      "name": 'ValueListenableBuilder基本使用',
//      "priority": 1,
//      "subtitle": "【builder】: 组件构造器   【ValueWidgetBuilder<T>】\n"
//          "【valueListenable】: 监听值    【ValueListenable<T>】\n"
//          "【child】: 子组件    【Widget】",
//    }

class ValueListenableBuilderDemo extends StatelessWidget {
  ValueListenableBuilderDemo({Key? key}) : super(key: key);

  final ValueNotifier<int> _counter = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Scaffold(
        appBar: AppBar(title: const Text("ValueListenableBuilder")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have pushed the button this many times:'),
              ValueListenableBuilder<int>(
                builder: _buildWithValue,
                valueListenable: _counter,
                child: const Text('I am Child!'),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.plus_one),
          onPressed: () => _counter.value += 1,
        ),
      ),
    );
  }

  Widget _buildWithValue(BuildContext context, int value, Widget? child) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text('$value'),
        child ?? const SizedBox.shrink(),
      ],
    );
  }
}
