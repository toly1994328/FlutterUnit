import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 221 DraggableScrollableActuator 拖滑重置器 它可以通知后代的 DraggableScrollableSheet，将其位置重置为初始状态。
//    {
//      "widgetId": 221,
//      "name": '基本使用方法',
//      "priority": 1,
//      "subtitle": "【child】 : 子组件   【Widget】\n"
//          "使用 DraggableScrollableActuator.reset(context) 重置后代 DraggableScrollableSheet 位初始位置。",
//    }

class DraggableScrollableActuatorDemo extends StatelessWidget {
  const DraggableScrollableActuatorDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DraggableScrollableActuatorPage()),
          );
        },
        child: const Text("进入 DraggableScrollableActuator 测试页"),
      ),
    );
  }
}

class DraggableScrollableActuatorPage extends StatelessWidget {
  DraggableScrollableActuatorPage({Key? key}) : super(key: key);

  final List<Color> data = [
    Colors.orange[50]!,
    Colors.orange[100]!,
    Colors.orange[200]!,
    Colors.orange[300]!,
    Colors.orange[400]!,
    Colors.orange[500]!,
    Colors.orange[600]!,
    Colors.orange[700]!,
    Colors.orange[800]!,
    Colors.orange[900]!,
    Colors.red[50]!,
    Colors.red[100]!,
    Colors.red[200]!,
    Colors.red[300]!,
    Colors.red[400]!,
    Colors.red[500]!,
    Colors.red[600]!,
    Colors.red[700]!,
    Colors.red[800]!,
    Colors.red[900]!,
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DraggableScrollableActuator"),
      ),
      body: DraggableScrollableActuator(
        child: Builder(
          builder: (ctx) => Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  DraggableScrollableActuator.reset(ctx);
                },
                child: const Text("重置位置"),
              ),
              Expanded(
                child: buildSheet(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSheet() => DraggableScrollableSheet(
        initialChildSize: 0.3,
        minChildSize: 0.2,
        maxChildSize: 1,
        expand: true,
        builder: (BuildContext context, ScrollController scrollController) =>
            ListView.builder(
          controller: scrollController,
          itemCount: data.length,
          itemBuilder: buildColorItem,
        ),
      );

  Widget buildColorItem(BuildContext context, int index) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      color: data[index],
      child: Text(
        colorString(data[index]),
        style: const TextStyle(color: Colors.white, shadows: [
          Shadow(color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)
        ]),
      ),
    );
  }

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}
