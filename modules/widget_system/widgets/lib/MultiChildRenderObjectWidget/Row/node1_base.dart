import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-30
/// contact me by email 1981462002@qq.com


class CustomRow extends StatelessWidget {
  const CustomRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
