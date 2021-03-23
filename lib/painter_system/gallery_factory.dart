import 'package:flutter/material.dart';

import 'anim/bezier3_player/bezier3_palyer.dart';
import 'art/circle_packing.dart';
import 'art/cubic_disarray.dart';
import 'art/hypnotic_squares.dart';
import 'art/joy_division.dart';
import 'art/piet_mondrian.dart';
import 'art/tiled_lines.dart';
import 'art/triangular_mesh.dart';
import 'art/un_deux_trois.dart';
import 'anim/draw_path.dart';
import 'base/clock_widget.dart';
import 'base/draw_path_fun.dart';
import 'base/draw_grid_axis.dart';
import 'base/draw_picture.dart';
import 'base/random_portrait.dart';
import 'gallery.dart';

/// create by 张风捷特烈 on 2020/12/5
/// contact me by email 1981462002@qq.com
/// 说明:
///

enum GalleryType { base, anim, particle, fun, art }

class GalleryFactory {
  static List<Widget> getGalleryByName(GalleryType type) {
    switch (type) {
      case GalleryType.base:
        return [
          FrameShower(
              title: "The Chaos",
              author: "张风捷特烈",
              srcUrl: "",
              info:
                  "    本样例介绍如何进行图片的绘制：通过加载图片并将图片资源绘制到指定的区域。在上层绘制一批 45° 倾角的栅格线，来练习线条的绘制。",
              content: DrawPicture()),
          FrameShower(
              title: "The Coordinate",
              author: "张风捷特烈",
              srcUrl: "",
              info:
                  "    本样例介绍如何使用线路径和文字绘制网格坐标系，并将绘制对象进行封装，方便重用。坐标系也会在绘制时提供参考，入门必备。",
              content: DrawGridAxis()),
          FrameShower(
              title: "曲线拟合",
              author: "张风捷特烈",
              info: "    本样例介绍如何使用路径对函数曲线进行绘制，通过函数曲线上的少量点通过贝塞尔曲线进行拟合。",
              content: DrawPathFun()),
          FrameShower(
              title: "随机对称图",
              author: "张风捷特烈",
              info:
                  "    本样例介绍绘制矩形及随机数处理。通过点位集合确定矩形位置信息，将其绘制出来。可以练习对数据的控制力。",
              content: RandomPortrait()),          FrameShower(
              title: "简单时钟",
              author: "张风捷特烈",
              info:
                  "    本样例通过时钟的绘制，练习 Flutter 中旋转刻度类型的绘制技巧，并通过动画使表盘指针转动。",
              content: ClockWidget()),
        ];
      case GalleryType.anim:
        return [
          FrameShower(
              title: "Bezier3 演示 (双击清除)",
              author: "张风捷特烈",
              info: "    本样例介绍如何绘制三次贝塞尔曲线，通过触点判断某点是否激活，据此控制点的位置达到拖动控制效果。",
              content: Bezier3Player()),          FrameShower(
              title: "Draw Curve",
              author: "张风捷特烈",
              info: "    本样例介绍如何使用路径绘制函数曲线，并使用路径测量进行动画",
              content: DrawPath()),
        ];
      case GalleryType.particle:
        return [];
      case GalleryType.fun:
        return [
          FrameShower(
              title: "Random Portrait",
              author: "张风捷特烈",
              info:
                  "    本样例介绍绘制矩形及随机数处理。通过点位集合确定矩形位置信息，将其绘制出来。其中对点的随机生成和对称处理能让你练习对数据的控制力。",
              content: RandomPortrait()),
        ];
      case GalleryType.art:
        return [
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
        ];
      default:
        return [];
    }
  }
}
