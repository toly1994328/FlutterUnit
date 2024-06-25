import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnDropSelected = void Function(int index);

class TolySelect extends StatefulWidget {
  final List<String> data;
  final int selectIndex;
  final OnDropSelected? onSelected;
  final Color disableColor;
  final double iconSize;
  final double height;
  final double width;
  final double fontSize;

  const TolySelect({
    super.key,
    this.data = const [],
    required this.selectIndex,
    this.onSelected,
    this.disableColor = const Color(0xffcccccc),
    this.iconSize = 24,
    this.height = 30,
    this.width = 200,
    this.fontSize = 14,
  });

  @override
  _TolySelectState createState() => _TolySelectState();
}

class _TolySelectState extends State<TolySelect> with SingleTickerProviderStateMixin {
  late FocusNode _node;
  bool _focused = false;
  late FocusAttachment _nodeAttachment;
  OverlayEntry? _overlayEntry;
  late AnimationController _ctrl;
  late Animation<double> animation;
  final LayerLink layerLink = LayerLink();

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    animation = Tween<double>(begin: 0, end: pi).animate(_ctrl);
    _node = FocusNode()
      ..addListener(() {
        if (_node.hasFocus != _focused) {
          if (!_focused) {
            _ctrl.forward();
            _showOverlay();
          } else {
            _hideOverlay();
            _ctrl.reverse();
          }
          setState(() {
            _focused = _node.hasFocus;
          });
        }
      });
    _nodeAttachment = _node.attach(context);
  }

  @override
  void dispose() {
    _node.dispose();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _nodeAttachment.reparent();
    return TapRegion(
      groupId: 'selector',
      onTapOutside: (_) {
        _node.unfocus();
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (_focused) {
            _node.unfocus();
          } else {
            _node.requestFocus();
          }
        },
        child: CompositedTransformTarget(
          link: layerLink,
          child: _SelectTarget(
            constraints: BoxConstraints.tight(Size(widget.width,widget.height)),
            focused: _focused,
            label: widget.data.isNotEmpty ? widget.data[widget.selectIndex] : "暂无数据",
            fontSize: widget.fontSize,
            disableColor: widget.disableColor,
            animation: animation,
            iconSize: widget.iconSize,
          ),
        ),
      ),
    );
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
  }

  OverlayEntry _createOverlayEntry() => OverlayEntry(
        builder: (BuildContext context) => UnconstrainedBox(
          child: CompositedTransformFollower(
            link: layerLink,
            targetAnchor: Alignment.bottomCenter,
            followerAnchor: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Material(
                shape: const RoundedRectangleBorder(
                    side: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(4))),
                elevation: 0,
                child: Container(
                  // height: 200,
                  // alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color: Color(0xffe4e7ed), width: 1 / window.devicePixelRatio),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(0, 2),
                          blurRadius: 6,
                          spreadRadius: 0,
                        )
                      ]),
                  // padding: const EdgeInsets.only(top: 5),
                  width: widget.width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      // shrinkWrap: true,
                      itemCount: widget.data.length,
                      itemBuilder: _buildItem),
                ),
              ),
            ),
          ),
        ),
      );

  Widget _buildItem(BuildContext context, int index) {
    return TapRegion(
      groupId: 'selector',
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            if (widget.selectIndex != index) widget.onSelected?.call(index);
            _overlayEntry?.markNeedsBuild();
            _node.unfocus();
          },
          child: Container(
              padding: const EdgeInsets.all(8),
              color: index == widget.selectIndex ? Color(0xfff5f7fa) : Colors.transparent,
              child: Text(
                widget.data[index],
                style: TextStyle(fontSize: widget.fontSize),
              )),
        ),
      ),
    );
  }
}

class _SelectTarget extends StatefulWidget {
  final BoxConstraints? constraints;
  final bool focused;
  final String label;
  final double fontSize;
  final double iconSize;
  final Color disableColor;
  final Animation<double> animation;

  const _SelectTarget({
    super.key,
    this.constraints,
    required this.focused,
    required this.label,
    required this.fontSize,
    required this.disableColor,
    required this.animation,
    required this.iconSize,
  });

  @override
  State<_SelectTarget> createState() => _SelectTargetState();
}

class _SelectTargetState extends State<_SelectTarget> {
  Color get borderColor {
    if (widget.focused) {
      return Colors.blue;
    }
    return widget.disableColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: widget.constraints,
      padding: const EdgeInsets.only(left: 6, right: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: borderColor,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.label,
            style: TextStyle(height: 1, fontSize: widget.fontSize),
          ),
          AnimatedBuilder(
            animation: widget.animation,
            builder: (_, child) => Transform.rotate(
              angle: widget.animation.value,
              child: child,
            ),
            child: Icon(
              Icons.keyboard_arrow_down,
              size: widget.iconSize,
            ),
          ),
        ],
      ),
    );
  }
}
