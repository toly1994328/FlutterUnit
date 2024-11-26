import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-30
/// contact me by email 1981462002@qq.com


class InheritedWidgetDemo extends StatelessWidget {
  final String info =
      'InheritedWidget 是一个抽象类，不可以直接使用。可以自定义对应共享数据的子类，如这里的通过 InfoInheritedWidget 实现：当前这段话可以在任意子树节点上下文获取。'
      '一般都会定义一个 XXX.of(context) 的方法来获取数据，如 MediaQuery.of，Theme.of 等。';

  const InheritedWidgetDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoInheritedWidget(
      info: info,
      child: const InfoWidget(),
    );
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key});

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

  const InfoInheritedWidget({super.key,required this.info, required super.child});

  @override
  bool updateShouldNotify(covariant InfoInheritedWidget oldWidget) =>
      info != oldWidget.info;

  static InfoInheritedWidget? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InfoInheritedWidget>();
}
