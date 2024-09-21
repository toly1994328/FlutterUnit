import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-12
/// contact me by email 1981462002@qq.com



class DividerThemeDemo extends StatelessWidget {
  const DividerThemeDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DividerTheme(
      data: const DividerThemeData(
        color: Colors.orange,
        thickness: 2,
        space: 10,
        indent: 10,
        endIndent: 10,
      ),
      child: Wrap(
        spacing: 10,
        children: [
          const Divider(),
          const Divider(),
          const Divider(),
          const Divider(),
          const Divider(),
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                VerticalDivider(),
                VerticalDivider(),
                VerticalDivider(),
                VerticalDivider(),
                VerticalDivider(),
              ],
            ),
          )
        ],
      ),
    );
  }
}