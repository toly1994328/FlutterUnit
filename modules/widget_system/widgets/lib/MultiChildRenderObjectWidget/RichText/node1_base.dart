import 'package:flutter/material.dart';

import '../../utils/color_utils.dart';

/// create by 张风捷特烈 on 2020-03-30
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 101,
//      "name": 'RichText基本使用',
//      "priority": 1,
//      "subtitle":
//          "【text】 : 文字   【TextSpan】\n"
//          "    其他属性与Text相同,详见之。",
//    }
class CustomRichText extends StatelessWidget {
  const CustomRichText({Key? key}) : super(key: key);

  final str = "        发光强度简称光强，国际单位是（坎德拉）简写cd。"
      "1cd是指光源在指定方向的单位立体角内发出的光通量。"
      "光源辐射是均匀时，则光强为I=F/Ω，Ω为立体角，单位为球面度（sr）,F为光通量，"
      "单位是流明，对于点光源由I=F/4π 。光亮度是表示发光面明亮程度的，"
      "指发光表面在指定方向的发光强度与垂直且指定方向的发光面的面积之比，"
      "单位是坎德拉/平方米。对于一个漫散射面，尽管各个方向的光强和光通量不同，"
      "但各个方向的亮度都是相等的。电视机的荧光屏就是近似于这样的漫散射面，"
      "所以从各个方向上观看图像，都有相同的亮度感。";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10,
      ),
      child: RichText(
          text: TextSpan(
              children: str
                  .split("")
                  .map((str) => TextSpan(
                      text: str,
                      style: TextStyle(
                          fontSize: 14, color: ColorUtils.randomColor())))
                  .toList())),
    );
  }
}
