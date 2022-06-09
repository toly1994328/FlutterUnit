import 'package:flutter/material.dart';
import 'package:flutter_unit/components/permanent/feedback_widget.dart';
import 'package:flutter_unit/components/project/items/gallery/gallery_card_item.dart';
import 'package:flutter_unit/painter_system/picture_frame.dart';


/// create by 张风捷特烈 on 2020/12/4
/// contact me by email 1981462002@qq.com
/// 说明:

class DeskFrameShower extends StatelessWidget {
  final String title;
  final String author;
  final String srcUrl;
  final String info;
  final Widget content;

  const DeskFrameShower(
      {Key? key,
        this.title = "",
        this.author = "",
        this.srcUrl = "",
        this.info = "",
        required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment(0,-0.7),
            child: Wrap(
              direction: Axis.vertical,
              spacing: 5,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "作者:  $author    ",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(
                  "源码地址    ",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
              ],
            ),
          ),
        ),

        PictureFrame(
          width: MediaQuery.of(context).size.shortestSide*0.6,
          height: MediaQuery.of(context).size.shortestSide*0.6,
          child: content,
        ),

        Expanded(
          child: Column(
            children: [
              Spacer(flex: 70,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  info,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.grey),
                ),
              ),
              Spacer(flex: 20,),

            ],
          ),
        ),
      ],
    );
  }
}
