import 'package:flutter/material.dart';
import 'package:flutter_unit/views/components/permanent/circle.dart';


class TolyAppBar extends StatefulWidget {
  final double maxHeight;
  final Function(int) onItemClick;

  @override
  _TolyAppBarState createState() => _TolyAppBarState();

  final int defaultIndex;

  TolyAppBar({this.maxHeight, this.onItemClick, this.defaultIndex = 0});
}

const BorderRadius _kBorderRadius = BorderRadius.only(
  bottomLeft: Radius.circular(15),
  bottomRight: Radius.circular(15),
);

const _kTabTextStyle = TextStyle(color: Colors.white, shadows: [
  const Shadow(color: Colors.black, offset: Offset(0.5, 0.5), blurRadius: 0.5)
]);

class _TolyAppBarState extends State<TolyAppBar>
    with SingleTickerProviderStateMixin {
  double _width = 0;
  int _selectIndex = 0;
  int _prevSelectIndex = 0;

  static const List<int> colors = [
    0xff44D1FD,
    0xffFD4F43,
    0xffB375FF,
    0xFF4CAF50,
    0xFFFF9800,
    0xFF00F1F1,
    0xFFDBD83F
  ];

  static const List<String> info = [
    'Stles',
    'Stful',
    'Scrow',
    'Mcrow',
    'Sliver',
    'Proxy',
    'Other'
  ];

  AnimationController _controller;
  Animation<double> circleAnim;
  Animation<double> heightAnim;
  Animation<double> backCircleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 1,
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    circleAnim = circleTween.animate(_controller);
    heightAnim = CurveTween(curve: Curves.ease).animate(_controller);
    backCircleAnim = ReverseAnimation(circleAnim);
    _selectIndex = widget.defaultIndex;
  }

  int get nextIndex => (_selectIndex + 1) % colors.length;

  Tween<double> circleTween = Tween(begin: 1, end: 0);

  @override
  Widget build(BuildContext context) {
    return Center(
      child:Flow(
          delegate: TolyAppBarDelegate(
            _selectIndex,
            _prevSelectIndex,
            widget.maxHeight,
            repaint: heightAnim,
          ),
          children: [
            ...colors
                .map((e) => GestureDetector(
                      onTap: () => _onTap(e),
                      child: _buildChild(e),
                    ))
                .toList(),
            ...colors.map((e) {
              Widget child = Circle(
                color: Color(e),
                radius: 6,
              );
              if (e == colors[_selectIndex]) {
                return ScaleTransition(scale: circleAnim, child: child);
              }
              if (e == colors[_prevSelectIndex]) {
                return ScaleTransition(scale: backCircleAnim, child: child);
              }
              return child;
            })
          ]),
    );
  }

  Widget _buildChild(int color) => Container(
    alignment: const Alignment(0, 0.4),
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
          color: _selectIndex == colors.indexOf(color)
              ? Colors.transparent
              : Color(colors[_selectIndex]),
          offset: const Offset(1, 1),
          blurRadius: 2)
    ], color: Color(color), borderRadius: _kBorderRadius),
    height: widget.maxHeight + 20,
    width: _width,
    child: Text(
      info[colors.indexOf(color)],
      style: _kTabTextStyle,
    ),
  );

  void _onTap(int color) {
    if (_selectIndex == colors.indexOf(color)) return;
    setState(() {
      _controller.reset();
      _controller.forward();
      _prevSelectIndex = _selectIndex;
      _selectIndex = colors.indexOf(color);
      if (widget.onItemClick != null) widget.onItemClick(_selectIndex);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class TolyAppBarDelegate extends FlowDelegate {
  final int selectIndex;
  final int prevSelectIndex;
  final double height;
  final Animation<double> repaint;

  TolyAppBarDelegate(this.selectIndex, this.prevSelectIndex, this.height,
      {this.repaint})
      : super(repaint: repaint);

  double get factor => repaint.value;

  @override
  void paintChildren(FlowPaintingContext context) {
    double ox = 0;
    double obx = 0;

    for (int i = 0; i < context.childCount / 2; i++) {
      Size cSize = context.getChildSize(i);
      if (i == selectIndex) {
        context.paintChild(i,
            transform: Matrix4.translationValues(ox, 20.0 * factor - 20, 0.0));
        ox += cSize.width;
      } else if (i == prevSelectIndex) {
        context.paintChild(i,
            transform:
                Matrix4.translationValues(ox, 20.0 * (1 - factor) - 20, 0.0));
        ox += cSize.width;
      } else {
        context.paintChild(i,
            transform: Matrix4.translationValues(ox, -20, 0.0));
        ox += cSize.width;
      }
    }

    // 绘制小点
    for (int i = (context.childCount / 2).floor(); i < context.childCount; i++) {
      context.paintChild(i,
          transform: Matrix4.translationValues(
              obx + context.getChildSize(0).width / 2 - 5, height + 5, 0));
      obx += context.getChildSize(0).width;
    }
  }

  @override
  bool shouldRepaint(TolyAppBarDelegate oldDelegate) =>
      oldDelegate.selectIndex != selectIndex ||
      oldDelegate.height != height ||
      oldDelegate.repaint != repaint;
}
