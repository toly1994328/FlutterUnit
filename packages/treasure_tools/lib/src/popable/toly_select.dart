import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../wrapper.dart';

typedef OnDropSelected = void Function(int index);

class TolySelectTapRegion extends TapRegion {
  /// Creates a const [TextFieldTapRegion].
  ///
  /// The [child] field is required.
  const TolySelectTapRegion({
    super.key,
    required super.child,
    super.enabled,
    super.onTapOutside,
    super.onTapInside,
    super.debugLabel,
  }) : super(groupId: TolySelect);
}


class TolySelect extends StatefulWidget {
  final List<String> data;
  final int activeIndex;
  final OnDropSelected change;
  final Color disableColor;
  final double iconSize;
  final double height;
  final double width;
  final double fontSize;

  const TolySelect(
      {Key? key,
        this.data = const [],
        required this.activeIndex,
        required this.change,
        this.disableColor = const Color(0xffdcdfe6),
        this.iconSize = 20,
        this.height = 40,
        this.width = 240,
        this.fontSize = 14,
      })
      : super(key: key);

  @override
  _TolySelectState createState() => _TolySelectState();
}

class _TolySelectState extends State<TolySelect>
    with SingleTickerProviderStateMixin {
  late FocusNode _node;
  bool _focused = false;
  late FocusAttachment _nodeAttachment;
  OverlayEntry? _overlayEntry;
  late AnimationController _ctrl;
  late Animation<double> animation;
  final LayerLink layerLink = LayerLink();

  // int _selectedIndex = 0;



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
    return TolySelectTapRegion(
      onTapOutside: (PointerDownEvent event){
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
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: _focused ? Color(0xff409eff) : widget.disableColor,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.data.isNotEmpty ? widget.data[widget.activeIndex] : "暂无数据",style: TextStyle(
              height: 1,
              fontSize: widget.fontSize,
            color: Color(0xff606266)
          ),),
          AnimatedBuilder(
            animation: animation,
            builder: (_, child) => Transform.rotate(
              angle: -animation.value,
              child: child,
            ),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xffc0c4cc),
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
            color: Colors.transparent,
            shape: const RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(4))),
            elevation: 0,
            child: Wrapper(
              padding: EdgeInsets.zero,
              spineType: SpineType.top,
              color: Colors.white,
              strokeWidth: 1,
              radius: 4,
              shadows: [
                BoxShadow(
                  offset: Offset(0,2),
                  blurRadius: 8,

                  color: Colors.black.withOpacity(0.1)
                )
              ],
              // elevation: 3,
              // shadowColor: Colors.black.withOpacity(0.1),
              child: Container(
                height: min(34.0*widget.data.length+10,150),
                // alignment: Alignment.center,
                // decoration: const BoxDecoration(
                //   color: Color(0xffDAE3FF),
                // ),
                width: widget.width,
                child: ListView.builder(
                  itemExtent: 34,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    // shrinkWrap: true,
                    itemCount: widget.data.length,
                    itemBuilder: _buildItem),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  Widget _buildItem(BuildContext context, int index) {
    return Material(
      // color: Colors.white,
      color: Colors.transparent,
      child: TolySelectTapRegion(
       child: InkWell(
          onTap: () {
            if (widget.activeIndex != index) widget.change.call(index);
            _overlayEntry?.markNeedsBuild();
            _node.unfocus();
          },
          hoverColor: Color(0xffF5F7FA),
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
              color: Colors.transparent,
              // color: index == _selectedIndex
              //     ? Colors.blue.withOpacity(0.2)
              //     : Colors.transparent,
              child:
              Text(widget.data[index],
                style: TextStyle(fontSize: widget.fontSize,
                fontWeight: index == widget.activeIndex?FontWeight.bold:null,
                color:  index == widget.activeIndex?Theme.of(context).primaryColor:null
                ),

              )),
        ),
      ),
    );
  }
}