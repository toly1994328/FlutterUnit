import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/8/16
/// contact me by email 1981462002@qq.com

class WidgetInspectorDemo extends StatelessWidget {
  const WidgetInspectorDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: WidgetInspector(
        child: const HomePage(),
        selectButtonBuilder: _selectButtonBuilder,
      ),
    );
  }

  Widget _selectButtonBuilder(BuildContext context, onPressed) {
    onPressed();
    return Container();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _count = 0;

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
