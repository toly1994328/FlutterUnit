import 'dart:async';

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 173,
//      "name": 'StreamBuilder基本使用',
//      "priority": 1,
//      "subtitle":
//          "【stream】 : 子组件   【Stream<T>】\n"
//          "【initialData】 : 初始数据   【T】\n"
//          "【builder】 : 点击事件  【AsyncWidgetBuilder<T>】",
//    }
class CustomStreamBuilder extends StatefulWidget {
  const CustomStreamBuilder({Key? key}) : super(key: key);

  @override
  _CustomStreamBuilderState createState() => _CustomStreamBuilderState();
}

class _CustomStreamBuilderState extends State<CustomStreamBuilder> {
  final CountGenerator _generator = CountGenerator()..increment();

  @override
  void dispose() {
    _generator.dispose(); //关闭控制器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(
                side: BorderSide(width: 2.0, color: Color(0xFFDFDFDF)),
              )),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () async {
            await _generator.increment();
          },
        ),
        _buildStreamBuilder(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(
                side: BorderSide(width: 2.0, color: Color(0xFFDFDFDF)),
              )),
          child: const Icon(
            Icons.remove,
            color: Colors.white,
          ),
          onPressed: () async {
            await _generator.minus();
          },
        ),
      ],
    );
  }

  Widget _buildStreamBuilder() => StreamBuilder<int>(
      stream: _generator.state,
      builder: (BuildContext context, AsyncSnapshot snap) {
        print(snap);
        if (snap.connectionState == ConnectionState.done) {
          return const Text('Done');
        }
        if (snap.connectionState == ConnectionState.active) {
          return Text(
            snap.data.toString(),
            style: Theme.of(context).textTheme.bodyText2,
          );
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

class CountGenerator {
  int _count = 0; //计数器数据
  final StreamController<int> _controller = StreamController(); //控制器

  Stream<int> get state => _controller.stream; //获取状态流
  int get count => _count; //获取计数器数据

  void dispose() {//关闭控制器
    _controller.close();
  }

  Future<void> increment() async {//增加记数方法
    _controller.add(++_count);
  }

  Future<void> minus() async {//增加记数方法
    _controller.add(--_count);
  }
}
