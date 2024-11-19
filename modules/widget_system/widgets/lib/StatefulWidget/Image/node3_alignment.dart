import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com

enum AlignmentType {
  center(Alignment.center, 'center'),
  centerLeft(Alignment.centerLeft, 'centerLeft'),
  centerRight(Alignment.centerRight, 'centerRight'),
  topCenter(Alignment.topCenter, 'topCenter'),
  topLeft(Alignment.topLeft, 'topLeft'),
  topRight(Alignment.topRight, 'topRight'),
  bottomCenter(Alignment.bottomCenter, 'bottomCenter'),
  bottomLeft(Alignment.bottomLeft, 'bottomLeft'),
  bottomRight(Alignment.bottomRight, 'bottomRight'),
  ;

  const AlignmentType(this.alignment, this.title);

  final Alignment alignment;
  final String title;
}

class AlignmentImage extends StatelessWidget {
  const AlignmentImage({Key? key}) : super(key: key);

  //测试数组

  @override
  Widget build(BuildContext context) {
    List<Widget> imgLi = AlignmentType.values
        .map((v) => //生成子Widget列表
            Column(children: [
              Container(
                  margin: const EdgeInsets.all(5),
                  width: 90,
                  height: 60,
                  color: Colors.grey.withAlpha(88),
                  child: Image(
                    image: const AssetImage("assets/images/wy_30x20.webp"),
                    alignment: v.alignment,
                  )),
              Text(v.title),
            ]))
        .toList();
    var imageAlignment = Wrap(children: imgLi);
    return imageAlignment;
  }
}
