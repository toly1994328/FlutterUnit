import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnDropSelected = void Function(int index);

class DropSelectableWidget extends StatefulWidget {
  final List<String> data;
  final OnDropSelected? onDropSelected;
  final Color disableColor;
  final double iconSize;
  final double height;
  final double width;
  final double fontSize;

  const DropSelectableWidget(
      {Key? key,
        this.data = const [],
        this.onDropSelected,
        this.disableColor = Colors.black,
        this.iconSize = 24,
        this.height = 30,
        this.width = 200,
        this.fontSize = 14,
      })
      : super(key: key);

  @override
  _DropSelectableWidgetState createState() => _DropSelectableWidgetState();
}

class _DropSelectableWidgetState extends State<DropSelectableWidget>
    with SingleTickerProviderStateMixin {
  late FocusNode _node;
  bool _focused = false;
  late FocusAttachment _nodeAttachment;
  OverlayEntry? _overlayEntry;
  late AnimationController _ctrl;
  late Animation<double> animation;
  final LayerLink layerLink = LayerLink();

  int _selectedIndex = 0;

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
      onTapOutside: (_){
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
          child: buildTarget(),
        ),
      ),
    );
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
  }

  Widget buildTarget() {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _focused ? Colors.blue : widget.disableColor,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.data.isNotEmpty ? widget.data[_selectedIndex] : "暂无数据",style: TextStyle(
              height: 1,
              fontSize: widget.fontSize
          ),),
          AnimatedBuilder(
            animation: animation,
            builder: (_, child) => Transform.rotate(
              angle: animation.value,
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
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            elevation: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 200,
                // alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xffDAE3FF),
                ),
                // padding: const EdgeInsets.only(top: 5),
                width: widget.width,
                child: CupertinoScrollbar(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      // shrinkWrap: true,
                      itemCount: widget.data.length,
                      itemBuilder: _buildItem),
                ),
              ),
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
        child: InkWell(
          onTap: () {
            if (_selectedIndex != index) widget.onDropSelected?.call(index);
            _selectedIndex = index;
            _overlayEntry?.markNeedsBuild();
            _node.unfocus();
          },
          child: Container(
              padding: const EdgeInsets.all(8),
              color: index == _selectedIndex
                  ? Colors.blue.withOpacity(0.2)
                  : Colors.transparent,
              child: Text(widget.data[index],style: TextStyle(fontSize: widget.fontSize),)),
        ),
      ),
    );
  }
}