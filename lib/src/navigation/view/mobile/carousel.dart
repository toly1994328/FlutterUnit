import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:app/app.dart';
import 'news.dart';

typedef TypeWidgetBuilder<T> = Widget Function(BuildContext context, T data);

class Carousel<T> extends StatefulWidget {
  final List<T> data;
  final TypeWidgetBuilder<T> itemBuilder;

  const Carousel({
    super.key,
    required this.data,
    required this.itemBuilder,
  });

  @override
  State createState() => _CarouselState<T>();
}

class _CarouselState<T> extends State<Carousel<T>> {
  final ValueNotifier<double> factor = ValueNotifier<double>(0);

  late PageController _ctrl;

  final int _firstOffset = 1000; //初始偏移
  int _position = 0; //页面位置

  @override
  void initState() {
    super.initState();
    _position = _position + _firstOffset;

    double value = ((_position - _firstOffset + 1) % 5) / 5;
    factor.value = value == 0 ? 1 : value;
    _ctrl = PageController(
      viewportFraction: kAppEnv.isDesktopUI ? 0.38 : 0.8,
      initialPage: _position,
    )..addListener(() {
        if (_ctrl.page != null) {
          double value = (_ctrl.page! - _firstOffset + 1) % 5 / 5;
          factor.value = value == 0 ? 1 : value;
        }
      });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    factor.dispose();
    super.dispose();
  }

  Color get color => Colors.blue;

  Color get nextColor => Colors.orangeAccent;

  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    List<T> data = widget.data;
    if (data.isEmpty) return const SizedBox();
    Widget child = PageView.builder(
      controller: _ctrl, // itemCount: 7,
      itemBuilder: (_, index) {
        int realIndex = _fixPosition(index, _firstOffset, data.length);
        return GestureDetector(
          child: AnimatedBuilder(
            animation: _ctrl,
            builder: (context, child) => _buildAnimItemByIndex(
              context,
              child,
              index,
            ),
            child: widget.itemBuilder(context, data[realIndex]),
          ),
        );
      },
      onPageChanged: (index) {
        _position = index;
        setState(() {});
      },
    );

    int realIndex = _fixPosition(_position, _firstOffset, data.length);

    child = Stack(
      alignment: Alignment.bottomCenter,
      children: [
        child,
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Wrap(
            spacing: 6,
            children: widget.data.asMap().keys.map((int index) {
              return GestureDetector(
                onTap: () {
                  int deta = index - realIndex;
                  _position += deta;
                  print('$_position,$realIndex');
                  _ctrl.animateToPage(_position,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                },
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      color: realIndex == index
                          ? Colors.white
                          : Colors.black.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white.withValues(alpha: 0.3),
                            spreadRadius: 1,
                            blurRadius: 10,
                            blurStyle: BlurStyle.outer)
                      ]),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );

    if (!kIsDesk) {
      return child;
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
            right: 0,
            child: HoverIndicator(
              onTap: () {
                _position += 1;
                _ctrl.animateToPage(_position,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },
              icon: Icons.navigate_next_outlined,
            )),
        Positioned(
            left: 0,
            child: HoverIndicator(
                onTap: () {
                  _position -= 1;
                  _ctrl.animateToPage(_position,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                },
                icon: Icons.navigate_before)),
      ],
    );
  }

  Widget _buildAnimItemByIndex(BuildContext context, Widget? child, int index) {
    double value;
    if (_ctrl.position.haveDimensions && _ctrl.page != null) {
      value = _ctrl.page! - index;
    } else {
      value = (_position - index).toDouble();
    }
    value = (1 - ((value.abs()) * 0.2)).clamp(0, 1).toDouble();
    value = Curves.easeOut.transform(value);

    return Transform(
      transform: Matrix4.diagonal3Values(value, value, 1.0),
      alignment: Alignment.center,
      child: child,
    );
  }

  int _fixPosition(int realPos, int initPos, int length) {
    if (length == 0) return 0;
    final int offset = realPos - initPos;
    int result = offset % length;
    return result < 0 ? length + result : result;
  }
}

class HoverIndicator extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const HoverIndicator({super.key, required this.icon, required this.onTap});

  @override
  State<HoverIndicator> createState() => _HoverIndicatorState();
}

class _HoverIndicatorState extends State<HoverIndicator> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: _onEnter,
        onExit: _onExit,
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            width: 36,
            height: 260,
            child: !_hover
                ? null
                : Icon(
                    widget.icon,
                    color: Colors.white,
                  ),
            color: _hover
                ? Colors.blue.withValues(alpha: 0.2)
                : Colors.transparent,
          ),
        ));
  }

  bool _hover = false;

  void _onEnter(PointerEnterEvent event) {
    setState(() {
      _hover = true;
    });
  }

  void _onExit(PointerExitEvent event) {
    setState(() {
      _hover = false;
    });
  }
}
