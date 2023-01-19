import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 351,
//      "name": "变换控制器的使用",
//      "priority": 3,
//      "subtitle":  "【transformationController】 : 变换控制器   【TransformationController】",
//    }

class InteractiveViewerDemo3 extends StatefulWidget {
  const InteractiveViewerDemo3({Key? key}) : super(key: key);

  @override
  _InteractiveViewerDemo3State createState() => _InteractiveViewerDemo3State();
}

class _InteractiveViewerDemo3State extends State<InteractiveViewerDemo3>
    with SingleTickerProviderStateMixin {
  final TransformationController _transformationController =
      TransformationController();
  late Animation<Matrix4> _animationReset;
  late AnimationController _controllerReset;

  void _onAnimateReset() {
    _transformationController.value = _animationReset.value;
    if (!_controllerReset.isAnimating) {
      _animationReset.removeListener(_onAnimateReset);
      _controllerReset.reset();
    }
  }

  void _animateResetInitialize() {
    _controllerReset.reset();
    _animationReset = Matrix4Tween(
      begin: _transformationController.value,
      end: Matrix4.identity(),
    ).animate(_controllerReset);
    _animationReset.addListener(_onAnimateReset);
    _controllerReset.forward();
  }

  void _animateResetStop() {
    _controllerReset.stop();
    _animationReset.removeListener(_onAnimateReset);
    _controllerReset.reset();
  }

  void _onInteractionStart(ScaleStartDetails details) {
    if (_controllerReset.status == AnimationStatus.forward) {
      _animateResetStop();
    }
  }

  @override
  void initState() {
    super.initState();
    _controllerReset = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _controllerReset.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      spacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        Container(
          height: 150,
          color: Colors.grey.withAlpha(33),
          child: InteractiveViewer(
            boundaryMargin: const EdgeInsets.all(40),
            transformationController: _transformationController,
            minScale: 0.1,
            maxScale: 1.8,
            onInteractionStart: _onInteractionStart,
            child: Image.asset('assets/images/caver.webp'),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton(),
            _buildButton2(),
            _buildButton3(),
          ],
        )
      ],
    );
  }

  Widget _buildButton() {
    return MaterialButton(
        child: const Icon(
          Icons.refresh,
          color: Colors.white,
        ),
        color: Colors.green,
        shape: const CircleBorder(
          side: BorderSide(width: 2.0, color: Color(0xFFDFDFDF)),
        ),
        onPressed: _animateResetInitialize);
  }

  final double _x = 0.0;

  Widget _buildButton2() {
    return MaterialButton(
        child: const Icon(
          Icons.navigate_before,
          color: Colors.white,
        ),
        color: Colors.green,
        shape: const CircleBorder(
          side: BorderSide(width: 2.0, color: Color(0xFFDFDFDF)),
        ),
        onPressed: () {
          var temp = _transformationController.value.clone();
          temp.translate(_x - 4);
          _transformationController.value = temp;
        });
  }

  Widget _buildButton3() {
    return MaterialButton(
        child: const Icon(
          Icons.navigate_next,
          color: Colors.white,
        ),
        color: Colors.green,
        shape: const CircleBorder(
          side: BorderSide(width: 2.0, color: Color(0xFFDFDFDF)),
        ),
        onPressed: () {
          var temp = _transformationController.value.clone();
          temp.translate(_x + 4);
          _transformationController.value = temp;
        });
  }
}
