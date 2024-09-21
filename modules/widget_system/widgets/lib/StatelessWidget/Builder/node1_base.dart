import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/5/3
/// contact me by email 1981462002@qq.com


class BuilderDemo extends StatelessWidget {
  const BuilderDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Builder'),
        ),
        floatingActionButton: Builder(
          builder: (ctx) => FloatingActionButton(
            onPressed: () {
              ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(content: Text('hello builder')));
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
