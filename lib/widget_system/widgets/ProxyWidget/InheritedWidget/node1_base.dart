import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 346 InheritedWidget 传承组件
/// 该类是抽象类，作用是可以在本上下文存储数据，在其后续节点的上下文中共享该数据。有很多实现类，包括各种主题组件、MediaQuery等。
/// link: 167,319,328,324,331
///
//    {
//      "widgetId": 346,
//      "name": 'InheritedWidget 使用',
//      "priority": 1,
//      "subtitle": "【child】 : 子组件   【Widget】\n"
//          "下面是一个简单的自定义 InheritedWidget，实现信息的子树共享。",
//    }

class InheritedWidgetDemo extends StatelessWidget {
  final String info =
      'InheritedWidget 是一个抽象类，不可以直接使用。可以自定义对应共享数据的子类，如这里的通过 InfoInheritedWidget 实现：当前这段话可以在任意子树节点上下文获取。'
      '一般都会定义一个 XXX.of(context) 的方法来获取数据，如 MediaQuery.of，Theme.of 等。';

  const InheritedWidgetDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoInheritedWidget(
      info: info,
      child: const InfoWidget(),
    );
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String info = InfoInheritedWidget.of(context)?.info??'';

    return Container(
      color: Colors.blue.withOpacity(0.1),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Text(info),
    );
  }
}

class InfoInheritedWidget extends InheritedWidget {
  final String info;

  const InfoInheritedWidget({Key? key,required this.info, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InfoInheritedWidget oldWidget) =>
      info != oldWidget.info;

  static InfoInheritedWidget? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InfoInheritedWidget>();
}
