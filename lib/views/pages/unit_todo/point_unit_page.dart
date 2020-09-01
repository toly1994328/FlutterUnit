

import 'package:flutter/material.dart';
import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/components/permanent/animated_text.dart';
import 'package:flutter_unit/components/permanent/circle_image.dart';
import 'package:flutter_unit/components/permanent/feedback_widget.dart';


class BugUnitPage extends StatelessWidget {
  final info = '【Flutter要点集录】是Unit项目计划的第二阶段的功能之一。'
      '将收录Flutter的常见异常及解决方案，也可以是Flutter中的特点或注意点，'
      '以供学习参考。本集录将支持异常/特色征集，愿开发者共同集录。';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('要点集录'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 50,
            child: Column(
              children: <Widget>[
                FeedbackWidget(
                  onPressed: (){
                    Navigator.of(context).pushNamed(UnitRouter.issues_point);
                  },
                  child: CircleImage(
                    image: AssetImage('assets/images/icon_head.webp'),
                    size: 80,
                  ),
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
              child: AnimatedText(
                info,
                0,
                durationInMilliseconds: 10000,
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
    return Positioned(
      bottom: 80,
      child:
      Text("Flutter Unit 异常/特色 征集方案(待完成)",
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