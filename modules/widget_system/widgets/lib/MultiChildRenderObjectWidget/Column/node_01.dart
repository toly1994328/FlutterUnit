import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-30
/// contact me by email 1981462002@qq.com

class ColumnNode1 extends StatelessWidget {
  const ColumnNode1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildTitle(),
        _buildContent(context),
      ],
    );
  }

  Widget _buildTitle() {
    return Container(
        height: 70,
        color: const Color(0x4484FFFF),
        child: Row(
          children: const [
            Padding(
              child: Icon(
                Icons.add_location,
                size: 30,
                color: Colors.pink,
              ),
              padding: EdgeInsets.only(left: 25, right: 20),
            ),
            Expanded(
              child: Text(
                "附近",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              child: Icon(Icons.keyboard_arrow_right, color: Colors.black38),
              padding: EdgeInsets.only(right: 25),
            ),
          ],
        ));
  }

  Widget _buildContent(ctx) => Container(
        width: MediaQuery.of(ctx).size.width,
        color: Colors.orangeAccent,
        height: 100,
        child: const Icon(
          Icons.android,
          size: 50,
          color: Colors.white,
        ),
      );
}
