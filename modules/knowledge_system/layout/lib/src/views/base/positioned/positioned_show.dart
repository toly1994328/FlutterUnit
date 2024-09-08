import 'package:flutter/material.dart';

class PositionedShow extends StatefulWidget {
  const PositionedShow({super.key});

  @override
  State<PositionedShow> createState() => _PositionedShowState();
}

class _PositionedShowState extends State<PositionedShow> {
  @override
  Widget build(BuildContext context) {
    Widget yellowBox = Container(
      color: Colors.yellow,
      height: 100,
      width: 100,
    );

    Widget redBox = Container(
      color: Colors.red,
      height: 90,
      width: 90,
    );

    Widget greenBox = DraggedBox(
      onPanUpdate: _onPanUpdate,
    );

    Widget cyanBox = Container(
      color: Colors.cyanAccent,
      height: 70,
      width: 70,
    );

    return Container(
        color: Colors.grey.withAlpha(33),
        child: Stack(
          children: [
            yellowBox,
            redBox,
            Positioned(top: _top, left: _left, child: greenBox),
            Positioned(bottom: 20, right: 20, child: cyanBox)
          ],
        ));
  }

  double _top = 20;
  double _left = 20;
  void _onPanUpdate(DragUpdateDetails details) {
   setState(() {
     _top += details.delta.dy;
     _left += details.delta.dx;
   });
  }
}

class DraggedBox extends StatelessWidget {
  final GestureDragUpdateCallback? onPanUpdate;

  const DraggedBox({super.key, this.onPanUpdate});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onPanUpdate: onPanUpdate,
        child: Container(
          color: Colors.green,
          height: 80,
          width: 80,
        ),
      ),
    );
  }


}

