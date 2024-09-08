import 'package:app/app.dart';
import 'package:dash_painter/dash_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrapper/wrapper.dart';

import 'model/time_node.dart';

class FlutterUnitTimeLine extends StatelessWidget {
  const FlutterUnitTimeLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('FlutterUnit 时光轴'),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 0),
        child: ListView(
          padding: const EdgeInsets.only(top: 0, bottom: 20),
          children: [
            TimeLineNode(
              timeNode: TimeNode(
                title: 'FlutterUnit 正式开源',
                year: '2020',
                content: 'V1.0 版本: 核心功能是组件集录，此时收录 213 组件的基本使用方式。',
                imageUrl: 'https://gitee.com/toly1994/res/raw/master/img3.webp',
                time: '2020-04-15',
              ),
            ),
            TimeLineNode(
              timeNode: TimeNode(
                title: '收藏夹功能完成',
                content: '通过收藏夹功能，使用者可以自由创建收藏夹，对组件进行自己的分类。',
                time: '2020-04-23',
              ),
            ),
            TimeLineNode(
              timeNode: TimeNode(
                title: 'FlutterUnit 支持 MacOS',
                content: '优化相关界面布局，在新分支中支持 MacOS 系统运行 FlutterUnit 程序。',
                imageUrl:
                    'https://gitee.com/toly1994/toly_blog_pic/raw/master/node4.webp',
                time: '2020-05-05',
              ),
            ),
            TimeLineNode(
              timeNode: TimeNode(
                title: 'FlutterUnit 支持 Windows',
                content: '优化相关界面布局，在新分支中支持 Windows 系统运行 FlutterUnit 程序。',
                time: '2020-07-09',
              ),
            ),
            TimeLineNode(
              timeNode: TimeNode(
                title: 'FlutterUnit 支持 web',
                content: '优化相关界面布局，在新分支中支持 Windows 系统运行 FlutterUnit 程序。',
                time: '2020-08-12',
              ),
            ),
            TimeLineNode(
              timeNode: TimeNode(
                title: ' Flutter 要点集录',
                imageUrl: 'https://gitee.com/toly1994/res/raw/master/img2.webp',
                content:
                    '要点集录会收集 FlutterUnit 中 point 标签的 issues，在应用中进行展示，从而达到对要点知识的收集。',
                time: '2020-09-04',
              ),
            ),
            TimeLineNode(
              timeNode: TimeNode(
                title: '组件集录收集数',
                content:
                    '收录组件数量从最初的 213 个增加到 306 个，已经涵盖了绝大多数 Flutter 框架中的原生组件。',
                time: '2020-12-22',
              ),
            ),
            TimeLineNode(
              timeNode: TimeNode(
                title: '个人页面的加入',
                content: '相比于侧滑菜单，通过个人页面，更方便进行一些应用的设置操作。',
                time: '2020-12-22',
              ),
            ),
            TimeLineNode(
              timeNode: TimeNode(
                year: '2021',
                title: '绘制集录正式加入',
                imageUrl:
                    'https://gitee.com/toly1994/res/raw/master/%E7%BB%98%E5%88%B6%E9%9B%86%E5%BD%95%E7%9A%84%E5%89%AF%E6%9C%AC.webp',
                content:
                    '绘制集录目的在于收录一些有意思的绘制案例，帮助对绘制感兴趣的朋友更好地学习，另一方面也可以反映出 Flutter 在绘制方面的强大能力。',
                time: '2021-01-22',
              ),
            ),
            TimeLineNode(
              timeNode: TimeNode(
                title: '后端服务计划启动',
                content:
                    '基于 SpringBoot 框架实现 Flutter Unit Server，打算实现用户系统，支持组件收藏的用户化及同步操作，以及应用中组件数据的线上化。(封测中)',
                time: '2021-03-28',
              ),
            ),
            TimeLineNode(
              timeNode: TimeNode(
                title: '用户登录测试',
                content: '后端完成基本的用户系统，基于邮箱校验，前端完成用户注册、登录等界面及交互逻辑。(封测中)',
                time: '2021-05-01',
              ),
            ),
            TimeLineNode(
              timeNode: TimeNode(
                title: '全面支持空安全',
                imageUrl:
                    'https://gitee.com/toly1994/res/raw/master/nullsafe.webp',
                content: '由于 FlutterUnit 中存在大量的组件示例，支持空安全是一个非常大的挑战。',
                time: '2021-08-29',
              ),
            ),
            TimeLineNode(
              timeNode: TimeNode(
                title: '绘制集录持续收集',
                content:
                    '根据绘制、手势、动画等小册中的案例，进行收录到 FlutterUnit 绘制集录中，桌面版本也同步更新中。',
                time: '2020-10-01',
              ),
            ),
            TimeLineNode(
              timeNode: TimeNode(
                title: '实现应用内升级',
                imageUrl: 'https://gitee.com/toly1994/res/raw/master/img.webp',
                content: '服务端完成应用版本检测接口，应用内升级的实现，方便大家更新版本，及时体验最新版功能。',
                time: '2021-12-18',
              ),
            ),
            TimeLineNode(
              timeNode: TimeNode(
                title: '项目及案例全面优化',
                year: '2022',
                imageUrl: 'https://gitee.com/toly1994/res/raw/master/img4.webp',
                content:
                    '由于代码案例代码比较老旧，为了给新手朋友一个规范的示例。针对 Dart Analysis 中代码的规范性问题进行优化。由于案例数量太多，这又是一个非常巨大的挑战。',
                time: '2021-03-26',
              ),
            ),
            TimeLineNode(
              timeNode: TimeNode(
                title: 'FlutterUnit 2.0 发布',
                content: '鉴于案例的优化完成、[绘制/组件]集录的收集情况、以及应用内更新的支持，FlutterUnit 正式进入 2.0 版本。',
                imageUrl: 'https://gitee.com/toly1994/res/raw/master/img3.webp',
                time: '2022-03-28',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeLineNode extends StatelessWidget {
  final TimeNode timeNode;

  const TimeLineNode({Key? key, required this.timeNode}) : super(key: key);

  final double dashLineWith = 20;
  final double marginTop = 10;
  final double offset = 20 + 10;
  final double lineWidth = 2;
  final double circleRadius = 5;

  @override
  Widget build(BuildContext context) {
    Color themeColor = BlocProvider.of<AppConfigBloc>(context).state.themeColor.color;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 65,
            child: Padding(
                padding: const EdgeInsets.only(top: 20 + 5, left: 10),
                child: timeNode.year != null
                    ? Text(
                        '${timeNode.year} 年',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    : const SizedBox.shrink()),
          ),
          _buildDecoration(themeColor),
          Expanded(flex: 8, child: _buildCenterWidget(themeColor)),
          const Spacer(flex: 1)
        ],
      ),
    );
  }

  Widget _buildDecoration(Color themeColor) => Container(
        margin: const EdgeInsets.only(left: 10),
        width: dashLineWith,
        decoration: DashDecoration(
            circleColor: themeColor,
            lineColor: Colors.white,
            circleRadius: circleRadius,
            color: Colors.white,
            circleOffset: Offset(lineWidth / 2, offset + 10 / 2)),
      );

  Widget _buildCenterWidget(Color themeColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Wrapper(
        color: Colors.white,
        offset: 20 + 10 / 2 - 6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              timeNode.title,
              style: TextStyle(fontWeight: FontWeight.bold, color: themeColor),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                timeNode.content,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    shadows: [
                      Shadow(color: Colors.blueAccent, blurRadius: .1)
                    ]),
              ),
            ),
            if (timeNode.imageUrl != null)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Image(
                  image: NetworkImage(
                    timeNode.imageUrl!,
                  ),
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(timeNode.time,
                  style: TextStyle(
                      color: themeColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}

class DashDecoration extends Decoration {
  final Color color;
  final Color circleColor;
  final Color lineColor;
  final Offset circleOffset;
  final double circleRadius;

  const DashDecoration(
      {required this.color,
      required this.circleColor,
      required this.lineColor,
      required this.circleOffset,
      required this.circleRadius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      DashBoxPainter(decoration: this);
}

class DashBoxPainter extends BoxPainter {
  final DashDecoration decoration;

  const DashBoxPainter({required this.decoration});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    canvas.save();
    final Paint paint = Paint()..style = PaintingStyle.stroke;
    final Path path = Path();
    canvas.translate(
      offset.dx,
      offset.dy,
    );
    // 绘制直线
    canvas.drawLine(
        Offset(-decoration.circleOffset.dx, 0),
        Offset(-decoration.circleOffset.dx, configuration.size!.height),
        paint
          ..color = decoration.lineColor
          ..strokeWidth = 2);

    // 绘制虚线
    path
      ..moveTo(0, decoration.circleOffset.dy)
      ..relativeLineTo(configuration.size!.width, 0);
    const DashPainter(span: 2, step: 3).paint(
        canvas,
        path,
        paint
          ..color = decoration.color
          ..strokeWidth = 1);

    //绘制圆点
    final Paint paint2 = Paint()..color = Colors.white;
    canvas.drawCircle(
        Offset(-decoration.circleOffset.dx, decoration.circleOffset.dy),
        decoration.circleRadius,
        paint2);
    canvas.drawCircle(
        Offset(-decoration.circleOffset.dx, decoration.circleOffset.dy),
        decoration.circleRadius * 0.6,
        paint2..color = decoration.circleColor);
    canvas.restore();
  }
}
