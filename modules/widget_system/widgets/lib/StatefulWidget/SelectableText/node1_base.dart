import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-31
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 53,
//      "name": 'SelectableText基本使用',
//      "priority": 1,
//      "subtitle":
//          "【入参】 : 显示文字   【String】\n"
//          "【style】 : 文字样式   【TextStyle】\n"
//          "【cursorRadius】 : 光标半径   【Radius】\n"
//          "【cursorColor】 : 光标颜色   【Color】\n"
//          "【cursorWidth】 : 光标宽度   【double】\n"
//          "【showCursor】 : 是否显示光标   【bool】\n"
//          "【autofocus】 : 自动聚焦   【bool】",
//    }
class CustomSelectableText extends StatelessWidget {
  const CustomSelectableText({Key? key}) : super(key: key);

  final String text = "        始臣之解牛之时，所见无非牛者。三年之后，未尝见全牛也。方今之时，"
      "臣以神遇而不以目视，官知止而神欲行。依乎天理，批大郤，导大窾，因其固然，"
      "技经肯綮之未尝，而况大軱乎！良庖岁更刀，割也；族庖月更刀，折也。"
      "今臣之刀十九年矣，所解数千牛矣，而刀刃若新发于硎。彼节者有间，而刀刃者无厚；"
      "以无厚入有间，恢恢乎其于游刃必有余地矣，是以十九年而刀刃若新发于硎。"
      "虽然，每至于族，吾见其难为，怵然为戒，视为止，行为迟。动刀甚微，謋然已解，如土委地。"
      "提刀而立，为之四顾，为之踌躇满志，善刀而藏之.";

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      text,
      style: const TextStyle(fontSize: 18, color: Colors.orange),
      cursorColor: Colors.green,
      cursorRadius: const Radius.circular(3),
      cursorWidth: 5,
      showCursor: true,
      autofocus: false,
    );
  }
}
