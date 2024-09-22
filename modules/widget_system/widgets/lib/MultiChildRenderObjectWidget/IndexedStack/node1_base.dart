import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com

class IndexedStackNode01 extends StatefulWidget {
  const IndexedStackNode01({Key? key}) : super(key: key);

  @override
  State createState() => _IndexedStackNode01State();
}

class _IndexedStackNode01State extends State<IndexedStackNode01> {
  int _index = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSwitch(),
        Container(
          width: 200,
          height: 100,
          color: Colors.grey.withAlpha(33),
          child: IndexedStack(
            index: _index,
            children: <Widget>[
              Container(
                color: Colors.red,
                width: 80,
                height: 80
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  color: Colors.blue,
                  width: 80,
                  height: 80,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSwitch() => Switch(
        value: _index == 0,
        onChanged: (v) => setState(() => _index = v ? 0 : 1),
      );
}
