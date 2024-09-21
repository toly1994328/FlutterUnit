import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/21
/// contact me by email 1981462002@qq.com

class OrientationBuilderDemo extends StatefulWidget {
  const OrientationBuilderDemo({Key? key}) : super(key: key);

  @override
  _OrientationBuilderDemoState createState() => _OrientationBuilderDemoState();
}

class _OrientationBuilderDemoState extends State<OrientationBuilderDemo> {
  double _width = 200;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: _width,
          height: 200,
          child: OrientationBuilder(builder: _builder),
          color: Colors.orange,
        ),
        _buildSlider()
      ],
    );
  }

  //根据回调的orientation返回组件
  Widget _builder(BuildContext context, Orientation orientation) {
    switch(orientation){
      case Orientation.portrait:
        return const Icon(Icons.phone_android,size: 60,);
      case Orientation.landscape:
        return const RotatedBox(
          quarterTurns: 1,
            child: Icon(Icons.phone_android,size: 60,));
      default: return Container();
    }
  }

  Widget _buildSlider() =>Slider(
    value: _width,
    max: 350.0,
    min: 80.0,
    divisions: 17,
    onChanged: (v)=> setState(() => _width= v),
  );
}
