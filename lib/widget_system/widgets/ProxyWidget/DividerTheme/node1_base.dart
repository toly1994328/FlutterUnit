import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-12
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 329,
//      "name": 'DividerTheme使用',
//      "priority": 1,
//      "subtitle": "属性参数与Divider类似，可以通过DividerTheme.of获取分割线主题数据，"
//          "也可以为DividerTheme【后代】的分割线设置默认样式，包括颜色、粗细、高度等。",
//    }


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