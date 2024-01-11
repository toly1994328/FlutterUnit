import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';


class PaintUnitPage extends StatelessWidget {
  final String info = '【Flutter绘制集录】是Unit项目计划的第二阶段的功能之一。'
      '将收录大量绘制作品，展现Flutter强大的绘制表现力,'
      '以供学习绘制技能。本集录将支持绘制征集，愿开发者共同集录。';

  const PaintUnitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('绘制集录'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 50,
            child: Column(
              children: const [
                CircleImage(
                  image: AssetImage('assets/images/icon_head.webp'),
                  size: 80,
                ),
                SizedBox(height: 10,),
                Text(
                  'Flutter Unit 2.0 计划',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: ShaderMask(
              shaderCallback: (rect) =>
                  _buildShader(rect, Theme.of(context).primaryColor),
              child: TextTyper(
                text:info,
                textStyle: const TextStyle(
                  shadows: [
                    Shadow(
                        color: Colors.black,
                        offset: Offset(1, 1),
                        blurRadius: 1)
                  ],
                  color: Colors.white,
//              color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          buildPlan(),
          buildPower()
        ],
      ),
    );
  }

  Shader _buildShader(Rect bounds, Color color) => RadialGradient(
      center: Alignment.topLeft,
      radius: 1.0,
      tileMode: TileMode.mirror,
      colors: [color.withAlpha(88), color.withAlpha(136), color])
      .createShader(bounds);

  Widget buildPlan() {
    return const Positioned(
      bottom: 80,
      child:
      Text("Flutter Unit 绘制征集方案(待完成)",
          style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
              shadows: [
                Shadow(
                    color: Colors.black,
                    blurRadius: .5,
                    offset: Offset(0.3, 0.3))
              ],
              fontSize: 16)),
    );
  }

  Widget buildPower() {
    return const Positioned(
      bottom: 30,
      right: 30,
      child:
      Text("Power By 张风捷特烈",
          style: TextStyle(
              color: Colors.grey,
              shadows: [
                Shadow(
                    color: Colors.black,
                    blurRadius: 1,
                    offset: Offset(0.3, 0.3))
              ],
              fontSize: 16)),
    );
  }
}