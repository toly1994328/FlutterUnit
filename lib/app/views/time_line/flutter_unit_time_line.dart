import 'package:dash_painter/dash_painter.dart';
import 'package:flutter/material.dart';
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
        title: Text('FlutterUnit 时光轴'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 0),
        child: ListView(
          padding: EdgeInsets.only(top: 0, bottom: 20),
          children: [
            TimeLineNode(
              timeNode: TimeNode(
                title: 'FlutterUnit 正式开源',
                year: '2020',
                content: 'V1.0 版本: 核心功能是组件集录，此时收录 200+ 组件的基本使用方式。',
                imageUrl:
                    'https://gitee.com/toly1994/toly_blog_pic/raw/master/node1.webp',
                time: '2020-04-15',
              ),
            ),
            TimeLineNode(
              timeNode: TimeNode(
                title: '收藏夹功能完成',
                content: '通过收藏夹功能，使用者可以自由创建收藏夹，对组件进行自己的分类。',
                imageUrl:
                    'https://gitee.com/toly1994/toly_blog_pic/raw/master/node2.webp',
                time: '2020-04-23',
              ),
            ),
            TimeLineNode(
              timeNode: TimeNode(
                title: 'FlutterUnit 支持 MacOS',
                content: '通过收藏夹功能，使用者可以自由创建收藏夹，对组件进行自己的分类。',
                imageUrl:
                    'https://gitee.com/toly1994/toly_blog_pic/raw/master/node4.webp',
                time: '2020-05-05',
              ),
            ),
            TimeLineNode(
              timeNode: TimeNode(
                title: ' Flutter 要点集录',
                content:
                    '要点集录会收集 FlutterUnit 中 point 标签的 issues，在应用中进行展示，从而达到对要点知识的收集',
                imageUrl:
                    'https://gitee.com/toly1994/toly_blog_pic/raw/master/node3.webp',
                time: '2020-09-04',
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
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 20 + 5, left: 10),
              child: timeNode.year != null
                  ? Text(
                      '${timeNode.year} 年',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  : Visibility(
                      visible: false,
                      maintainState: true,
                      maintainSize: true,
                      maintainAnimation: true,
                      child: const Text(
                        '2020 年',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ))),
          _buildDecoration(),
          Expanded(flex: 8, child: _buildCenterWidget()),
          const Spacer(flex: 1)
        ],
      ),
    );
  }

  Widget _buildDecoration() => Container(
        margin: const EdgeInsets.only(left: 10),
        width: dashLineWith,
        decoration: DashDecoration(
            circleColor: Colors.blueAccent,
            lineColor: Colors.white,
            circleRadius: circleRadius,
            color: Colors.white,
            circleOffset: Offset(lineWidth / 2, offset + 10 / 2)),
      );

  Widget _buildCenterWidget() {
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
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.purple),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                timeNode.content,
                style: const TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 12,
                    shadows: [
                      Shadow(color: Colors.blueAccent, blurRadius: .1)
                    ]),
              ),
            ),
            if (timeNode.imageUrl != null)
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 5),
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
                  style: const TextStyle(
                      color: Colors.grey,
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
