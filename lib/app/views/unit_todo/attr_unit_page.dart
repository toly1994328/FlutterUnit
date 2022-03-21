import 'package:flutter/material.dart';
import 'package:flutter_unit/components/permanent/circle_image.dart';
import 'package:flutter_unit/components/permanent/text_typer.dart';

class AttrUnitPage extends StatelessWidget {
  final info = '【Flutter属性集录】是Unit项目计划的第二阶段的功能之一。'
      '会对所有Widget的所有属性进行收录整理到数据库，进行数据分析和组件关联。'
      '并且对一些重要属性，进行全面讲解。';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('属性集录'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 50,
            child: Column(
              children: <Widget>[
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
            padding: EdgeInsets.all(20),
            child: ShaderMask(
              shaderCallback: (rect) =>
                  _buildShader(rect, Theme.of(context).primaryColor),
              child: TextTyper(
                text:info,
                textStyle: TextStyle(
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

  Widget buildPower() {
    return Positioned(
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
