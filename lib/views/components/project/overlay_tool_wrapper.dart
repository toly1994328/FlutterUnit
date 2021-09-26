import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/res/toly_icon.dart';
import 'package:flutter_unit/app/router/unit_router.dart';
import 'package:flutter_unit/point_system/blocs/point_system_bloc.dart';


import '../permanent/burst_menu.dart';
import '../permanent/color_wrapper.dart';

/// create by 张风捷特烈 on 2020/10/21
/// contact me by email 1981462002@qq.com
/// 说明:

class OverlayToolWrapper extends StatefulWidget {
  final Widget child;

  OverlayToolWrapper({Key? key,required this.child}) : super(key: key);

  @override
  OverlayToolWrapperState createState() => OverlayToolWrapperState();

  static OverlayToolWrapperState of(BuildContext context,
      {bool nullOk = false}) {

    final OverlayToolWrapperState? result =
        context.findAncestorStateOfType<OverlayToolWrapperState>();
    if (result != null) return result;
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary(
          'OverlayToolWrapper.of() called with a context that does not contain a OverlayToolWrapper.'),
    ]);
  }
}

class OverlayToolWrapperState extends State<OverlayToolWrapper>
    with SingleTickerProviderStateMixin {
  bool show = false;
  Offset offset = Offset(200, 200);

  late AnimationController _ctrl;

  final double width = 200;
  final double height = 30;
  final double outWidth = 35;
  final double boxHeight = 110;

  final double radius = 60;
  OverlayEntry? entry;
  double showWidth = 0;

  bool out = false;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    )..addListener(_listenAnimate);

    WidgetsBinding.instance?.addPostFrameCallback((callback) {
      var px = MediaQuery.of(context).size.width - 100;
      var py = 250.0;
      offset = Offset(px, py);

      entry = OverlayEntry(
          builder: (context) => Stack(
                children: <Widget>[
                  Positioned(
                    left: offset.dx,
                    top: offset.dy,
                    child: _buildFloating(),
                  ),
                ],
              ));
    });
  }

  final double circleRadius = 80;
  final double menuSize = 36;

  Widget _buildFloating() {
    Color wrapColor = Colors.blue.withOpacity(0.6);
    bool left = offset.dx < 100;

    return Container(
      width: circleRadius * 2,
      height: circleRadius * 2,
      alignment: Alignment.center,
      // color: Colors.orangeAccent,
      child: IconTheme(
        data: IconTheme.of(context).copyWith(color: Colors.white, size: 18),
        child: BurstMenu(
            startAngle: !left ? 90.0 + 15 : -90 - 15.0 + 180,
            swapAngle: !left ? 180.0 - 15 * 2 : -(180.0 - 15 * 2),
            center: _buildCenter(),
            burstMenuItemClick: _burstMenuItemClick,
            menus: _buildMenuItems(wrapColor)),
      ),
    );
  }

  Widget _buildCenter() => GestureDetector(
        onPanEnd: _onPanEnd,
        onPanUpdate: _updatePosition,
        child: Opacity(
          opacity: 0.9,
          child: Container(
            width: menuSize,
            height: menuSize,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(menuSize / 2)),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                      image: const AssetImage('assets/images/icon_head.webp')),
                  borderRadius: BorderRadius.circular(menuSize / 2)),
            ),
          ),
        ),
      );

  // 构建 菜单 item
  List<Widget> _buildMenuItems(Color wrapColor) => [
        Circled(color: wrapColor, child: const Icon(Icons.close)),
        Circled(color: wrapColor, radius: 15, child: const Icon(TolyIcon.icon_bug)),
        Circled(color: wrapColor, radius: 15, child: const Icon(Icons.palette)),
        Circled(color: wrapColor, child: const Icon(Icons.widgets)),
        Circled(color: wrapColor, child: const Icon(Icons.settings)),
      ];

  bool _burstMenuItemClick(int index) {
    print(index);
    switch (index) {
      case 0:
        _doClose();
        return true;
        break;
      case 1:
        _toPoint();
        break;
      case 2:
        _toGalley();
        break;
      case 3:
        _toWidget();
        break;
      case 4:
        _toSetting();
        break;
    }

    return true;
  }

  // 处理 菜单 item 点击事件
  void _toSetting() {
    Navigator.of(context).pushNamed(UnitRouter.setting);
  }

  void _toWidget() {}

  void _toGalley() {
    Navigator.of(context).pushNamed(UnitRouter.galley);
  }

  void _toPoint() {
    BlocProvider.of<PointBloc>(context).add(EventLoadPoint());
    Navigator.of(context).pushNamed(UnitRouter.point);
  }

  void _doClose() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  double endX=0;

  void _onPanEnd(details) {
    endX = offset.dx;
    _ctrl.reset();
    _ctrl.forward();
  }

  void _listenAnimate() {
    // var px = MediaQuery.of(context).size.width - (outWidth);
    // offset = Offset(px - (_ctrl.value), offset.dy);
    double px;
    // print(offset.dx);
    if (offset.dx > MediaQuery.of(context).size.width / 2 - circleRadius) {

      double begin = endX;
      double end = MediaQuery.of(context).size.width -
          menuSize / 2 -
          circleRadius;
      double t =  _ctrl.value;
      px = begin + (end - begin) * t; // x = menuSize / 2 - circleRadius;

    } else {
    double begin = endX;
    double end = menuSize / 2 - circleRadius;
    double t =  _ctrl.value;
    px = begin + (end - begin) * t; // x = menuSize / 2 - circleRadius;
    }

    offset = Offset(px, offset.dy);
    entry?.markNeedsBuild();
  }

  void _updatePosition(DragUpdateDetails details) {
    double y = details.globalPosition.dy - circleRadius;
    double x = details.globalPosition.dx - circleRadius;
    if (x < menuSize / 2 - circleRadius) {
      x = menuSize / 2 - circleRadius;
    }

    if (y < menuSize / 2 - circleRadius) {
      y = menuSize / 2 - circleRadius;
    }

    if (x > MediaQuery.of(context).size.width - menuSize / 2 - circleRadius) {
      x = MediaQuery.of(context).size.width - menuSize / 2 - circleRadius;
    }

    if (y > MediaQuery.of(context).size.height - menuSize / 2 - circleRadius) {
      y = MediaQuery.of(context).size.height - menuSize / 2 - circleRadius;
    }
    offset = Offset(x, y);
    entry?.markNeedsBuild();
  }

  void showFloating() {
    if (!show&&entry!=null) {
      Overlay.of(context)?.insert(entry!);
      show = true;
    }
  }

  void hideFloating() {
    if (show) {
      entry?.remove();
      show = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
