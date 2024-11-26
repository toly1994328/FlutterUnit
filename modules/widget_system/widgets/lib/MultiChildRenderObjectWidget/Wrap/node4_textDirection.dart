import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com

class TextDirectionWrap extends StatelessWidget {
  const TextDirectionWrap({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: TextDirection.values
            .map((mode) => Column(children: <Widget>[
          Container(
              margin: const EdgeInsets.all(5),
              width: 160,
              height: 100,
              color: Colors.grey.withAlpha(88),
              child: _buildItem(mode)),
          Text(mode.toString().split('.')[1])
        ]))
            .toList());
  }

  Widget get yellowBox => Container(
    color: Colors.yellow,
    height: 30,
    width: 50,
  );

  Widget get redBox => Container(
    color: Colors.red,
    height: 40,
    width: 40,
  );
  Widget get greenBox => Container(
    color: Colors.green,
    height: 40,
    width: 20,
  );
  Widget get blackBox => Container(
    color: Colors.black,
    height: 10,
    width: 10,
  );
  Widget get purpleBox => Container(
    color: Colors.purple,
    height: 20,
    width: 20,
  );
  Widget get orangeBox => Container(
    color: Colors.orange,
    height: 80,
    width: 20,
  );
  Widget get cyanBox => Container(
    color: Colors.cyanAccent,
    height: 10,
    width: 20,
  );

  Widget _buildItem(mode) => Wrap(
    textDirection: mode,
    runSpacing: 10,
    spacing: 10,
    children: <Widget>[
      yellowBox, redBox, greenBox, cyanBox,
      blackBox, purpleBox, orangeBox,
    ],
  );
}
