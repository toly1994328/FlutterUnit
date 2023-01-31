import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-20
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 100,
//      "name": 'AnimatedCrossFade动画曲线',
//      "priority": 2,
//      "subtitle":
//          "【firstCurve】 : 第一曲线   【Curve】\n"
//          "【secondCurve】 : 第二曲线   【Curve】\n"
//          "【sizeCurve】 : 尺寸变化曲线   【CrossFadeState】",
//    }
class CurveAnimatedCrossFade extends StatefulWidget {
  const CurveAnimatedCrossFade({Key? key}) : super(key: key);

  @override
  _CurveAnimatedCrossFadeState createState() => _CurveAnimatedCrossFadeState();
}

class _CurveAnimatedCrossFadeState extends State<CurveAnimatedCrossFade> {
  var _crossFadeState = CrossFadeState.showFirst;

  bool get isFirst=> _crossFadeState == CrossFadeState.showFirst;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        AnimatedCrossFade(
          firstCurve: Curves.easeInCirc,
          secondCurve: Curves.easeInToLinear,
          sizeCurve: Curves.bounceOut,
          firstChild: Container(
            alignment: Alignment.center,
            width: 200,
            height: 80,
            color: Colors.orange  ,
            child: const FlutterLogo(textColor: Colors.blue,size: 50,),
          ),
          secondChild: Container(
            width: 200,
            height: 150,
            alignment: Alignment.center,
            color: Colors.blue,
            child: const FlutterLogo(
              textColor: Colors.white,
//                colors: Colors.orange,
              size: 100,style: FlutterLogoStyle.stacked,),
          ),
          duration: const Duration(milliseconds: 1000),
          crossFadeState: _crossFadeState,
        ),
        _buildSwitch(),
      ],
    );
  }

  Widget _buildSwitch() => Switch(value: isFirst, onChanged: (v){
    setState(() {
      _crossFadeState= v?CrossFadeState.showFirst:CrossFadeState.showSecond;
    });
  });
}
