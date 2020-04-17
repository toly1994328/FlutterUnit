import 'package:flutter/material.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/components/permanent/circle.dart';

class TolyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(int, Color) onItemClick;

  @override
  _TolyAppBarState createState() => _TolyAppBarState();

  final Size preferredSize;

  final int selectIndex;
  TolyAppBar({this.onItemClick, this.preferredSize,this.selectIndex=0});
}

class _TolyAppBarState extends State<TolyAppBar>
    with SingleTickerProviderStateMixin {
  double _width = 0;
  int _selectIndex = 0;
  double factor = 1.0;

  List<int> colors = Cons.tabColors;
  List info = Cons.tabs;

  AnimationController _controller;



  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this)
          ..addListener(() => setState(() => factor = _controller.value))
          ..addStatusListener((s) {
            if (s == AnimationStatus.completed) {
              setState(() {});
            }
          });
    _selectIndex=widget.selectIndex;
    super.initState();
  }

  int get nextIndex => (_selectIndex + 1) % colors.length;

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width / colors.length;

    return Container(
      alignment: Alignment.center,
      child: Flow(
          delegate: TolyAppBarDelegate(
              _selectIndex, factor, widget.preferredSize.height),
          children: [
            ...colors.map((e) {
              var isSelected = _selectIndex == colors.indexOf(e);
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      _controller.reset();
                      _controller.forward();
                      _selectIndex = colors.indexOf(e);
                      if (widget.onItemClick != null)
                        widget.onItemClick(_selectIndex, Color(e));
                    });
                  },
                  child: Container(
                    alignment: Alignment(0, 0.4),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: isSelected
                                  ? Colors.transparent
                                  : Color(colors[_selectIndex]),
                              offset: Offset(1, 1),
                              blurRadius: 2)
                        ],
                        color: Color(e),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        )),
                    height: widget.preferredSize.height + 20,
                    width: _width,
                    child: Text(
                      info[colors.indexOf(e)],
                      style: TextStyle(color: Colors.white, shadows: [
                        Shadow(
                            color: Colors.black,
                            offset: Offset(0.5, 0.5),
                            blurRadius: 0.5)
                      ]),
                    ),
                  ));
            }).toList(),
            ...colors.map((e) => Circle(
                  color: Color(e),
                  radius: 6,
                ))
          ]),
    );
  }
}

class TolyAppBarDelegate extends FlowDelegate {
  final int selectIndex;
  final double factor;
  final double height;

  TolyAppBarDelegate(this.selectIndex, this.factor, this.height);

  @override
  void paintChildren(FlowPaintingContext context) {
    double ox = 0;
    double obx = 0;

    for (int i = 0; i < context.childCount / 2; i++) {
      var cSize = context.getChildSize(i);
      if (i == selectIndex) {
        context.paintChild(i,
            transform: Matrix4.translationValues(ox, 20.0 * factor - 20, 0.0));
        ox += cSize.width;
      } else {
        context.paintChild(i,
            transform: Matrix4.translationValues(ox, -20, 0.0));
        ox += cSize.width;
      }
    }
    for (int i = (context.childCount / 2).floor();
        i < context.childCount;
        i++) {
      if (i - (context.childCount / 2).floor() == selectIndex) {
        obx += context.getChildSize(0).width;
      } else {
        context.paintChild(i,
            transform: Matrix4.translationValues(
                obx + context.getChildSize(0).width / 2 - 5, height + 5, 0));
        obx += context.getChildSize(0).width;
      }
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return true;
  }
}
