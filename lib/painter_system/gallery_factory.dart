import 'package:flutter/material.dart';
import 'package:flutter_unit/painter_system/anim/spring_widget.dart';

import 'anim/bezier3_player/bezier3_palyer.dart';
import 'anim/circle_halo.dart';
import 'anim/curve_shower/curve_anim_shower.dart';
import 'anim/draw_path.dart';
import 'anim/dundun_path.dart';
import 'anim/rotate_by_point/rotate_by_point.dart';
import 'art/circle_packing.dart';
import 'art/cubic_disarray.dart';
import 'art/hypnotic_squares.dart';
import 'art/joy_division.dart';
import 'art/piet_mondrian.dart';
import 'art/tiled_lines.dart';
import 'art/triangular_mesh.dart';
import 'art/un_deux_trois.dart';
import 'base/clock_widget.dart';
import 'base/draw_grid_axis.dart';
import 'base/draw_path_fun.dart';
import 'base/draw_picture.dart';

import 'base/n_side/n_side_page.dart';
import 'base/polar/polar_painter_widget.dart';
import 'fun/dundun_view.dart';
import 'fun/random_portrait.dart';
import 'fun/stemp/stamp_paper.dart';
import 'particle/random/random_particle.dart';
import 'particle/split/particle_split.dart';
import 'particle/split_img/split_image.dart';
import 'picture_frame.dart';

/// create by 张风捷特烈 on 2020/12/5
/// contact me by email 1981462002@qq.com
/// 说明:
///

enum GalleryType { base, anim, particle, fun, art }

class GalleryFactory {
  static List<Widget> getGalleryByName(GalleryType type) {
    switch (type) {
      case GalleryType.base:
        return const [
          FrameShower(
              title: "The Chaos",
              author: "张风捷特烈",
              srcUrl: "/base/draw_picture.dart",
              info: "本样例介绍如何进行图片的绘制：通过加载图片并将图片资源绘制到指定的区域。在上层绘制一批 45° 倾角的栅格线，来练习线条的绘制。",
              content: DrawPicture()),
          FrameShower(
              title: "平面直角坐标系",
              author: "张风捷特烈",
              srcUrl: "/base/draw_grid_axis.dart",
              info:
                  "本样例介绍如何使用线路径和文字绘制网格坐标系，并将绘制对象进行封装，方便重用。坐标系也会在绘制时提供参考，入门必备。",
              content: DrawGridAxis()),
          FrameShower(
              title: "平面极坐标系",
              author: "张风捷特烈",
              srcUrl: "/base/polar",
              info:
              "本样例介绍如何使用绘制平面的极坐标系，并根据函数方程收集极坐标进行绘制。",
              content: PolarPainterWidget()),
          FrameShower(
              title: "曲线拟合",
              author: "张风捷特烈",
              srcUrl: "/base/draw_path_fun.dart",
              info: "本样例介绍如何使用路径对函数曲线进行绘制，通过函数曲线上的少量点通过贝塞尔曲线进行拟合。",
              content: DrawPathFun()),
          FrameShower(
              title: "圆中取形",
              author: "张风捷特烈",
              srcUrl: "/base/n_side",
              info: "本样例介绍如何在圆中收集点位，绘制正多边形，是练习绘制及形成路径的很好案例。\n特殊操作：+、- 修改边数",
              content: NSidePage()),
          FrameShower(
              title: "随机对称图",
              author: "张风捷特烈",
              srcUrl: '/fun/random_portrait.dart',
              info: "本样例介绍绘制矩形及随机数处理。通过点位集合确定矩形位置信息，将其绘制出来。可以练习对数据的控制能力。\n特殊操作：点击随机生成",
              content: RandomPortrait()),
          FrameShower(
              title: "简单时钟",
              author: "张风捷特烈",
              srcUrl: '/base/clock_widget.dart',
              info: "本样例通过时钟的绘制，练习 Flutter 中旋转刻度类型的绘制技巧，并通过动画使表盘指针转动。",
              content: ClockWidget()),
        ];
      case GalleryType.anim:
        return const [
          FrameShower(
              title: "手势弹簧",
              author: "张风捷特烈",
              srcUrl: '/anim/spring_widget.dart',
              info: "本样例介绍如何绘制弹簧，通过触点竖直拖拽拉伸、压缩，放手时进行恢复动画，是一个很好的综合小案例。\n特殊操作：上下拖拽伸缩弹簧",
              content: SpringWidget()),
          FrameShower(
              title: "绕定点旋转",
              author: "张风捷特烈",
              srcUrl: '/anim/rotate_by_point',
              info: "本样例介绍如何根据以某个点为中心，进行旋转运动。以此学习两点间的角度在绘制中的应用。\n特殊操作：点击运行",
              content: RotateByPointWidget()),
          FrameShower(
              title: "流光",
              author: "张风捷特烈",
              srcUrl: '/anim/circle_halo.dart',
              info: "本样例介绍如何在绘制中使用着色器和过滤器，并通过动画进行数值变化达到旋转流光效果。",
              content: CircleHalo()),
          FrameShower(
              title: "曲线路径动画",
              author: "张风捷特烈",
              srcUrl: '/anim/draw_path.dart',
              info: "本样例介绍如何使用路径绘制函数曲线，并使用路径测量进行动画",
              content: DrawPath()),
          FrameShower(
              title: "冰墩墩线条动画",
              author: "张风捷特烈",
              srcUrl: '/anim/dundun_path.dart',
              info: "本样例会绘制 2022 年北京冬奥会吉祥物冰墩墩的路径，并使用路径测量进行动画。\n特殊操作：点击运行",
              content: DunDunPathPage()),
          FrameShower(
              title: "Bezier3 演示",
              author: "张风捷特烈",
              srcUrl: '/anim/bezier3_player',
              info: "本样例介绍如何绘制三次贝塞尔曲线，通过触点判断某点是否激活，据此控制点的位置达到拖动控制效果。\n特殊操作：单击绘点，双击清除",
              content: Bezier3Player()),
          FrameShower(
              title: "动画曲线散点图",
              author: "张风捷特烈",
              srcUrl: '/anim/curve_shower',
              info: "本样例通过直观的方式，来查看动画曲线 curve 的作用效果，让大家对动画有更深的理解。\n特殊操作：点击运行",
              content: CurveAnimShower()),

        ];
      case GalleryType.particle:
        return const [
          FrameShower(
              title: "随机粒子生成器",
              author: "张风捷特烈",
              srcUrl: '/particle/random',
              info: "本样例介绍如何创建随机粒子及边界反弹逻辑处理，是学习粒子运动非常好的入门案例。\n特殊操作：单击停止/运行",
              content: RandomParticle()),
          FrameShower(
              title: "粒子分裂",
              author: "张风捷特烈",
              srcUrl: '/particle/split',
              info: "本样例介绍如何对个粒子进行碰撞检测，并分裂处多个粒子，是一个比较有趣的案例。\n特殊操作：单击重置",
              content: ParticleSplit()),
          FrameShower(
              title: "图片粒子分裂",
              author: "张风捷特烈",
              srcUrl: '/particle/split_img',
              info: "本样例介绍将图片使用粒子表示，并对粒子进行动画处理，达到爆炸的效果。\n特殊操作：单击运行",
              content: SplitImage()),
        ];
      case GalleryType.fun:
        return const[
           FrameShower(
              title: "Random Portrait",
              author: "张风捷特烈",
               srcUrl: '/fun/random_portrait.dart',
               info: "本样例介绍绘制矩形及随机数处理。通过点位集合确定矩形位置信息，将其绘制出来。可以练习对数据的控制能力。\n特殊操作：点击随机生成",
              content: RandomPortrait()),
          FrameShower(
              title: "冰墩墩",
              author: "张风捷特烈",
              srcUrl: '/fun/dundun_view.dart',
              info: "本样例是绘制 2022 年北京冬奥会吉祥物冰墩墩的形体，从中可以学到路径绘制、渐变色等知识。",
              content: DunDunView()),
          FrameShower(
              title: "井字棋",
              author: "张风捷特烈",
              srcUrl: '/fun/stemp',
              info: "本例通过井字棋的绘制与逻辑校验，集合了手势、绘制、动画、校验等重要的技能，是一个非常好的联系案例。\n特殊操作：双击重置",
              content: StampPaper()),
        ];
      case GalleryType.art:
        return const [
          FrameShower(
            title: "Tiled Line",
            author: "generativeartistry.com",
            srcUrl: '/art/tiled_lines.dart',
            info:
                "本样例根源来自generativeartistry.com的tiled-lines,由xrr2016使用Flutter实现。仓库地址:flutter-generative-artistry",
            content: TiledLines(),
          ),
          FrameShower(
            title: "Joy Division",
            author: "generativeartistry.com",
            srcUrl: '/art/joy_division.dart',
            info:
                "本样例根源来自generativeartistry.com的joy-division,由xrr2016使用Flutter实现。仓库地址:flutter-generative-artistry",
            content: JoyDivision(),
          ),
          FrameShower(
            title: "Cubic Disarray",
            author: "generativeartistry.com",
            srcUrl: '/art/cubic_disarray.dart',
            info:
                "本样例根源来自generativeartistry.com的cubic-disarray,由xrr2016使用Flutter实现。仓库地址:flutter-generative-artistry",
            content: CubicDisarray(),
          ),
          FrameShower(
            title: "Triangular Mesh",
            author: "generativeartistry.com",
            srcUrl: '/art/triangular_mesh.dart',
            info:
                "本样例根源来自generativeartistry.com的triangular-mesh,由xrr2016使用Flutter实现。仓库地址:flutter-generative-artistry",
            content: TriangularMesh(),
          ),
          FrameShower(
            title: "Un Deux Trois",
            srcUrl: '/art/un_deux_trois.dart',
            author: "generativeartistry.com",
            info:
                "本样例根源来自generativeartistry.com的un-deux-trois,由xrr2016使用Flutter实现。仓库地址:flutter-generative-artistry",
            content: UnDeuxTrois(),
          ),
          FrameShower(
            title: "Circle Packing",
            author: "generativeartistry.com",
            srcUrl: '/art/circle_packing.dart',
            info:
                "本样例根源来自generativeartistry.com的circle-packing,由xrr2016使用Flutter实现。仓库地址:flutter-generative-artistry",
            content: CirclePacking(),
          ),
          FrameShower(
            title: "Hypnotic Squares",
            author: "generativeartistry.com",
            srcUrl: '/art/hypnotic_squares.dart',
            info:
                "本样例根源来自generativeartistry.com的hypnotic-squares,由xrr2016使用Flutter实现。仓库地址:flutter-generative-artistry",
            content: HypnoticSquares(),
          ),
          FrameShower(
            title: "Piet Mondrian",
            author: "generativeartistry.com",
            srcUrl: '/art/piet_mondrian.dart',
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
