import 'package:flutter/material.dart';
import 'package:flutter_unit/app/utils/toly_utils.dart';

/// create by 张风捷特烈 on 2020-03-07
/// contact me by email 1981462002@qq.com
/// 说明:

class ColorfulText extends StatelessWidget {
  final String text;

  ColorfulText(this.text,);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            children: text
                .split("")
                .map((str) => //对文字数组化，并通过map遍历生成TextSpan数组
                    TextSpan(
                        text: str,
                        style: TextStyle(
                            fontSize: 45,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(1, 1)
                              ),
                              Shadow(
                                  color: Colors.red,
                                  offset: Offset(0.5, 0.5),
                                blurRadius: 2
                              ),

                            ],
                            color: ColorUtils.randomColor())))
                .toList()));
  }
}
