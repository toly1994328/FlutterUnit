import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com

class SoftWrapText extends StatelessWidget {
  const SoftWrapText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: TextOverflow.values
          .map((TextOverflow textOverflow) => Container(
                width: 150,
                color: Colors.cyanAccent.withAlpha(33),
                height: 150 * 0.618 * 0.618,
                child: Text(
                  " 张风捷特烈 toly " * 5,
                  overflow: textOverflow,
                  softWrap: false,
                ),
              ))
          .toList(),
    );
  }
}
