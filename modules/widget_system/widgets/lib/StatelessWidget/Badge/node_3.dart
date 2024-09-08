import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2023/01/27
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 258,
//      "name": 'Badge 的偏移量',
//      "priority": 3,
//      "subtitle": "【offset】 : 标记偏移量  【Offset?】\n"
//          "【alignment】 : 标题偏移   【AlignmentDirectional?】",
//    }

class BadgeAlignOffsetDemo extends StatelessWidget {
  const BadgeAlignOffsetDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> info = ['默认偏移和对齐', '偏移-4,-4', '偏移-2,-2;右下角'];
    final List<Offset?> offsets = [
      null,
      const Offset(-4, -4),
      const Offset(-2, -2)
    ];
    final List<Alignment?> alignments = [null, null, Alignment.bottomRight];

    return Wrap(
      spacing: 40,
      children: info
          .asMap()
          .keys
          .map((int i) => _buildShowItem(info[i], offsets[i], alignments[i]))
          .toList(),
    );
  }

  Widget _buildShowItem(String info, Offset? offset, Alignment? alignment) {
    return Wrap(
      spacing: 8,
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Badge(
          backgroundColor: Colors.red,
          label: const Text('99'),
          textStyle: const TextStyle(fontSize: 8, color: Colors.red),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          largeSize: 14,
          offset: offset,
          alignment: alignment,
          child: const Icon(Icons.message, size: 36, color: Colors.indigo),
        ),
        Text(
          info,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        )
      ],
    );
  }
}
