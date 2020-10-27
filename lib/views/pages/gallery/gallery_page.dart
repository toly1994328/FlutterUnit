import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'art/circle_packing.dart';
import 'art/cubic_disarray.dart';
import 'art/draw_picture.dart';
import 'art/hypnotic_squares.dart';
import 'art/joy_division.dart';
import 'art/piet_mondrian.dart';
import 'art/random_portrait.dart';
import 'art/tiled_lines.dart';
import 'art/triangular_mesh.dart';
import 'art/un_deux_trois.dart';
import 'picture_frame.dart';

/// create by 张风捷特烈 on 2020/10/10
/// contact me by email 1981462002@qq.com
/// 说明:

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Flutter 绘制集录"),
      ),
        body: Column(children: [
      // _buildTitle(),
      Expanded(
        child: Container(
          // color: Colors.lightBlueAccent,
          child: Center(
            child: PageView(
              children: [
                FrameShower(
                    title: "The Chaos",
                    author: "张风捷特烈",
                    info:
                        "    本样例介绍如何进行图片的绘制。通过加载图片并将图片资源绘制到指定的区域。在上层绘制一批45°倾角的栅格线,可以练习基本的绘制。",
                    content: DrawPicture()),
                FrameShower(
                    title: "Random Portrait",
                    author: "张风捷特烈",
                    info:
                        "    本样例介绍绘制矩形及随机数处理。通过点位集合确定矩形位置信息，将其绘制出来。其中对点的随机生成和对称处理能让你练习对数据的控制力。",
                    content: RandomPortrait()),
                FrameShower(
                  title: "Tiled Line",
                  author: "generativeartistry.com",
                  info:
                      "本样例根源来自generativeartistry.com的tiled-lines,由xrr2016使用Flutter实现。仓库地址:flutter-generative-artistry",
                  content: TiledLines(),
                ),
                FrameShower(
                  title: "Joy Division",
                  author: "generativeartistry.com",
                  info:
                      "本样例根源来自generativeartistry.com的joy-division,由xrr2016使用Flutter实现。仓库地址:flutter-generative-artistry",
                  content: JoyDivision(),
                ),
                FrameShower(
                  title: "Cubic Disarray",
                  author: "generativeartistry.com",
                  info:
                      "本样例根源来自generativeartistry.com的cubic-disarray,由xrr2016使用Flutter实现。仓库地址:flutter-generative-artistry",
                  content: CubicDisarray(),
                ),
                FrameShower(
                  title: "Triangular Mesh",
                  author: "generativeartistry.com",
                  info:
                      "本样例根源来自generativeartistry.com的triangular-mesh,由xrr2016使用Flutter实现。仓库地址:flutter-generative-artistry",
                  content: TriangularMesh(),
                ),
                FrameShower(
                  title: "Un Deux Trois",
                  author: "generativeartistry.com",
                  info:
                      "本样例根源来自generativeartistry.com的un-deux-trois,由xrr2016使用Flutter实现。仓库地址:flutter-generative-artistry",
                  content: UnDeuxTrois(),
                ),
                FrameShower(
                  title: "Circle Packing",
                  author: "generativeartistry.com",
                  info:
                      "本样例根源来自generativeartistry.com的circle-packing,由xrr2016使用Flutter实现。仓库地址:flutter-generative-artistry",
                  content: CirclePacking(),
                ),
                FrameShower(
                  title: "Hypnotic Squares",
                  author: "generativeartistry.com",
                  info:
                      "本样例根源来自generativeartistry.com的hypnotic-squares,由xrr2016使用Flutter实现。仓库地址:flutter-generative-artistry",
                  content: HypnoticSquares(),
                ),
                FrameShower(
                  title: "Piet Mondrian",
                  author: "generativeartistry.com",
                  info:
                      "本样例根源来自generativeartistry.com的piet-mondrian,由xrr2016使用Flutter实现。仓库地址:flutter-generative-artistry",
                  content: PietMondrian(),
                )
              ],
            ),
          ),
        ),
      ),
    ]));
  }

  _buildTitle() {
    return Container(
      height: 70,
      padding: const EdgeInsets.only(top: 8.0),
      color: Colors.blue,
      child: Row(
        children: [
          BackButton(
            color: Colors.white,
          ),
          Spacer(),
          Text('Flutter绘制集录'),
          Spacer(),

        ],
      ),
    );
  }
}

class FrameShower extends StatelessWidget {
  final String title;
  final String author;
  final String srcUrl;
  final String info;
  final Widget content;

  FrameShower(
      {Key key,
      this.title = "",
      this.author = "",
      this.srcUrl = "",
      this.info = "",
      @required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PictureFrame(
            width: MediaQuery.of(context).size.shortestSide,
            height: MediaQuery.of(context).size.shortestSide,
            child: content,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Text(
                  "作者:    $author    ",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Spacer(),
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
          SizedBox(
            height: 10,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.topLeft,
              child: Text(
                info,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}
