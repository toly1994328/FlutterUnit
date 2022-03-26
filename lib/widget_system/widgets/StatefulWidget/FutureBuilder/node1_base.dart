import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 172,
//      "name": 'FutureBuilder基本使用',
//      "priority": 1,
//      "subtitle":
//          "【builder】 : 子组件   【AsyncWidgetBuilder<T>】\n"
//          "【initialData】 : 初始数据   【T】\n"
//          "【future】 : 异步任务  【Future<T>】",
//    }
class CustomFutureBuilder extends StatefulWidget {
  const CustomFutureBuilder({Key? key}) : super(key: key);

  @override
  _CustomFutureBuilderState createState() => _CustomFutureBuilderState();
}

class _CustomFutureBuilderState extends State<CustomFutureBuilder> {
 late Future<String> _future;

  @override
  void initState() {
    _future = loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        initialData: 'Load',
        future: _future,
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.done) {
            return Text('${snap.data}');
          }
          if (snap.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snap.hasError) {
            return const Text('Error');
          }
          return Container();
        });
  }

  Future<String> loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'LoadeSuccess';
  }
}
