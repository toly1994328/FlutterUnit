import 'package:flutter/material.dart';

import 'anim/bezier3_player/bezier3_palyer.dart';
import 'anim/circle_halo.dart';
import 'anim/curve_shower/curve_anim_shower.dart';
import 'anim/draw_path.dart';
import 'anim/dundun_path.dart';
import 'anim/rotate_by_point/rotate_by_point.dart';
import 'anim/spring_widget.dart';
import 'art/circle_packing.dart';
import 'art/cubic_disarray.dart';
import 'art/hypnotic_squares.dart';
import 'art/joy_division.dart';
import 'art/piet_mondrian.dart';
import 'art/tiled_lines.dart';
import 'art/triangular_mesh.dart';
import 'art/un_deux_trois.dart';
import 'base/clock_widget.dart';
import 'base/digital/digital_shower.dart';
import 'base/draw_grid_axis.dart';
import 'base/draw_path_fun.dart';
import 'base/draw_picture.dart';

import 'base/n_side/n_side_page.dart';
import 'base/polar/polar_painter_widget.dart';
import 'base/windmill.dart';
import 'fun/bufeng/bufeng_panel.dart';
import 'fun/dundun_view.dart';
import 'fun/random_portrait.dart';
import 'fun/stemp/stamp_paper.dart';
import 'particle/random/random_particle.dart';
import 'particle/split/particle_split.dart';
import 'particle/split_img/split_image.dart';
import 'picture_frame.dart';
import 'package:l10n/l10n.dart';
/// create by 张风捷特烈 on 2020/12/5
/// contact me by email 1981462002@qq.com
/// 说明:
///

enum GalleryType { base, anim, particle, fun, art }

class GalleryFactory {
  static List<Widget> getGalleryByName(GalleryType type,BuildContext context) {
    switch (type) {
      case GalleryType.base:
        return  [
          FrameShower(
              title: "The Chaos",
              author: "张风捷特烈",
              srcUrl: "/base/draw_picture.dart",
              info: context.l10n.drawingOfImages,
              content: DrawPicture()),
          FrameShower(
              title: "数字显示管",
              author: "张风捷特烈",
              srcUrl: "/base/digital",
              info: context.l10n.digitalDisplayTube,
              content: DigitalShower()),
          FrameShower(
              title: "旋转风车",
              author: "张风捷特烈",
              srcUrl: "/base/windmill.dart",
              info: context.l10n.pathDrawing,
              content: WindmillWidget()),
          FrameShower(
              title: "平面直角坐标系",
              author: "张风捷特烈",
              srcUrl: "/base/draw_grid_axis.dart",
              info: context.l10n.gridCoordinateSystem,
              content: DrawGridAxis()),
          FrameShower(
              title: "平面极坐标系",
              author: "张风捷特烈",
              srcUrl: "/base/polar",
              info: context.l10n.polarCoordinateSystemOfFaces,
              content: PolarPainterWidget()),
          FrameShower(
              title: "曲线拟合",
              author: "张风捷特烈",
              srcUrl: "/base/draw_path_fun.dart",
              info: context.l10n.drawFunctionCurvesForPathPairs,
              content: DrawPathFun()),
          FrameShower(
              title: "圆中取形",
              author: "张风捷特烈",
              srcUrl: "/base/n_side",
              info:  context.l10n.drawRegularPolygons,
              content: NSidePage()),
          FrameShower(
              title: "随机对称图",
              author: "张风捷特烈",
              srcUrl: '/fun/random_portrait.dart',
              info: context.l10n.randomNumberProcessing,
              content: RandomPortrait()),
          FrameShower(
              title: "简单时钟",
              author: "张风捷特烈",
              srcUrl: '/base/clock_widget.dart',
              info: context.l10n.clockDrawing,
              content: ClockWidget()),
        ];
      case GalleryType.anim:
        return  [
          FrameShower(
              title: "手势弹簧",
              author: "张风捷特烈",
              srcUrl: '/anim/spring_widget.dart',
              info: context.l10n.drawSprings,
              content: SpringWidget()),
          FrameShower(
              title: "绕定点旋转",
              author: "张风捷特烈",
              srcUrl: '/anim/rotate_by_point',
              info:  context.l10n.theApplicationOfAnglesInDrawing,
              content: RotateByPointWidget()),
          FrameShower(
              title: "流光",
              author: "张风捷特烈",
              srcUrl: '/anim/circle_halo.dart',
              info: context.l10n.usingShadersAndFilters,
              content: CircleHalo()),
          FrameShower(
              title: "曲线路径动画",
              author: "张风捷特烈",
              srcUrl: '/anim/draw_path.dart',
              info:  context.l10n.pathDrawingFunctionCurve,
              content: DrawPath()),
          FrameShower(
              title: "冰墩墩线条动画",
              author: "张风捷特烈",
              srcUrl: '/anim/dundun_path.dart',
              info:  context.l10n.thePathOfBingDwenDwen,
              content: DunDunPathPage()),
          FrameShower(
              title: "Bezier3 演示",
              author: "张风捷特烈",
              srcUrl: '/anim/bezier3_player',
              info:  context.l10n.drawCubicBesselCurve,
              content: Bezier3Player()),
          FrameShower(
              title: "动画曲线散点图",
              author: "张风捷特烈",
              srcUrl: '/anim/curve_shower',
              info: context.l10n.theEffectOfAnimationCurve,
              content: CurveAnimShower()),

        ];
      case GalleryType.particle:
        return  [
          FrameShower(
              title: "随机粒子生成器",
              author: "张风捷特烈",
              srcUrl: '/particle/random',
              info: context.l10n.randomParticlesAndBoundaryBouncing,
              content: RandomParticle()),
          FrameShower(
              title: "粒子分裂",
              author: "张风捷特烈",
              srcUrl: '/particle/split',
              info:  context.l10n.particleCollision,
              content: ParticleSplit()),
          FrameShower(
              title: "图片粒子分裂",
              author: "张风捷特烈",
              srcUrl: '/particle/split_img',
              info: context.l10n.particle,
              content: SplitImage()),
        ];
      case GalleryType.fun:
        return [
           FrameShower(
              title: "Random Portrait",
              author: "张风捷特烈",
               srcUrl: '/fun/random_portrait.dart',
               info: context.l10n.rectangleAndRandomNumbers,
              content: RandomPortrait()),
          FrameShower(
              title: "冰墩墩",
              author: "张风捷特烈",
              srcUrl: '/fun/dundun_view.dart',
              info: context.l10n.bingDwenDwen,
              content: DunDunView()),
          FrameShower(
              title: "蒲丰投针试验",
              author: "张风捷特烈",
              srcUrl: '/fun/bufeng',
              info: context.l10n.pufengInjectionTest,
              content: BufengPanel()),
          FrameShower(
              title: "井字棋",
              author: "张风捷特烈",
              srcUrl: '/fun/stemp',
              info: context.l10n.ticTacToe,
              content: StampPaper()),
        ];
      case GalleryType.art:
        return  [
          FrameShower(
            title: "Tiled Line",
            author: "generativeartistry.com",
            srcUrl: '/art/tiled_lines.dart',
            info: context.l10n.tiledLines,
            content: TiledLines(),
          ),
          FrameShower(
            title: "Joy Division",
            author: "generativeartistry.com",
            srcUrl: '/art/joy_division.dart',
            info: context.l10n.joyDivision,
            content: JoyDivision(),
          ),
          FrameShower(
            title: "Cubic Disarray",
            author: "generativeartistry.com",
            srcUrl: '/art/cubic_disarray.dart',
            info: context.l10n.cubicDisarray,  content: CubicDisarray(),
          ),
          FrameShower(
            title: "Triangular Mesh",
            author: "generativeartistry.com",
            srcUrl: '/art/triangular_mesh.dart',
            info: context.l10n.triangularMesh, content: TriangularMesh(),
          ),
          FrameShower(
            title: "Un Deux Trois",
            srcUrl: '/art/un_deux_trois.dart',
            author: "generativeartistry.com",
            info: context.l10n.unDeuxTrois,  content: UnDeuxTrois(),
          ),
          FrameShower(
            title: "Circle Packing",
            author: "generativeartistry.com",
            srcUrl: '/art/circle_packing.dart',
            info: context.l10n.circlePacking, content: CirclePacking(),
          ),
          FrameShower(
            title: "Hypnotic Squares",
            author: "generativeartistry.com",
            srcUrl: '/art/hypnotic_squares.dart',
            info: context.l10n.hypnoticSquares,    content: HypnoticSquares(),
          ),
          FrameShower(
            title: "Piet Mondrian",
            author: "generativeartistry.com",
            srcUrl: '/art/piet_mondrian.dart',
            info: context.l10n.pietMondrian, content: PietMondrian(),
          )
        ];
      default:
        return [];
    }
  }
}
