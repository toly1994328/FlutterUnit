import 'dart:math';

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/3/31
/// contact me by email 1981462002@qq.com
///
/// 说明: 266 CompositedTransformTarget 2 合成变换目标，一般与 CompositedTransformFollower 组件联合使用，可以使 Overlay 伴随目标变换。
//    {
//      "widgetId": 266,
//      "name": "CompositedTransformTarget 使用",
//      "priority": 1,
//      "subtitle":
//          "【child】 : 子组件   【Widget】\n"
//          "【link】 : 链接   【LayerLink】",
//    }

class CompositedTransformTargetDemo extends StatelessWidget {

  const CompositedTransformTargetDemo({Key? key}) : super(key: key);

  static const  List<Color> colors =[Colors.red,Colors.yellow,Colors.blue,Colors.green];

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.rotationZ(-15/180*pi),
      height: 250,
      padding: const EdgeInsets.all(50.0),
      child:  ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_LogoTips(), const Text('点击图标\n显隐弹框')],
          ),
          ...colors.map((color) => Container(width: 80, color: color))
        ],
      ),
    );
  }

}

class _LogoTips extends StatefulWidget {
  @override
  _LogoTipsState createState() => _LogoTipsState();
}

class _LogoTipsState extends State<_LogoTips> {
  OverlayEntry? _overlayEntry;

  final LayerLink _layerLink = LayerLink();

  bool show = false;

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
        builder: (context) => Positioned(
              width: 150,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                targetAnchor: Alignment.topRight,
                child: const Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('我是一个 Overlay，目标组件为图标，当它变换时，我会伴随变换。'),
                  ),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _toggleOverlay,
        child: CompositedTransformTarget(
          link: _layerLink,
          child:
          const FlutterLogo(
            size: 80,
          ),
        ));
  }

  void _toggleOverlay() {
    if (!show) {
      _showOverlay();
    } else {
      _hideOverlay();
    }
    show = !show;
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
  }

  @override
  void dispose() {
    _hideOverlay();
    super.dispose();
  }
}
