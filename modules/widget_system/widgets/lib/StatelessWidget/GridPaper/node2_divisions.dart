import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com

class DivisionsGridPaper extends StatelessWidget {
  const DivisionsGridPaper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        height: 100,
        child: GridPaper(
            color: Colors.red,
            interval: 50,
            divisions: 4,
            subdivisions: 4,
            child: Image.asset(
              "assets/images/wy_300x200.webp",
              fit: BoxFit.cover,
            )));
  }
}
