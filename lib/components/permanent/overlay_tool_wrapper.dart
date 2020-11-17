import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/res/toly_icon.dart';
import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/blocs/bloc_exp.dart';
import 'package:flutter_unit/components/permanent/circle.dart';
import 'package:flutter_unit/components/permanent/feedback_widget.dart';
import 'package:flutter_unit/views/pages/gallery/picture_frame.dart';

import 'burst_flow.dart';
import 'color_wrapper.dart';

/// create by 张风捷特烈 on 2020/10/21
/// contact me by email 1981462002@qq.com
/// 说明:

class OverlayToolWrapper extends StatefulWidget {
  final Widget child;

  OverlayToolWrapper({Key key, this.child}) : super(key: key);

  @override
  OverlayToolWrapperState createState() => OverlayToolWrapperState();

  static OverlayToolWrapperState of(BuildContext context,
      {bool nullOk = false}) {
    assert(nullOk != null);
    assert(context != null);
    final OverlayToolWrapperState result =
        context.findAncestorStateOfType<OverlayToolWrapperState>();
    if (nullOk || result != null) return result;
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

  AnimationController _ctrl;

  final double width = 200;
  final double height = 30;
  final double outWidth = 35;
  final double boxHeight = 110;

  final double radius = 60;
  OverlayEntry entry;
  double showWidth = 0;

  bool out = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((callback) {
      var px = MediaQuery.of(context).size.width - 100;
      var py = 40.0;
      offset = Offset(px, py);

      _ctrl = AnimationController(
          duration: Duration(milliseconds: 400),
          vsync: this,
          lowerBound: 0,
          upperBound: width - outWidth)
        ..addListener(_listenAnimate);

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

  void _listenAnimate() {
    var px = MediaQuery.of(context).size.width - (outWidth);
    offset = Offset(px - (_ctrl.value), offset.dy);
    entry.markNeedsBuild();
  }

  final double circleRadius = 80;
  final double menuSize = 36;

  GlobalKey<BurstFlowState> burstFlowKey = GlobalKey<BurstFlowState>();

  _buildFloating() {
    Color wrapColor = Colors.blue.withOpacity(0.6);

    bool left = offset.dx < 100;
    print('-----left----${offset.dx}----');

    return Container(
      width: circleRadius * 2,
      height: circleRadius * 2,
      alignment: Alignment.center,
      child: IconTheme(
        data: IconTheme.of(context).copyWith(color: Colors.white, size: 18),
        child: BurstFlow(
          key:burstFlowKey,
            startAngle: !left ? 90.0 + 15 : -90 + 15.0,
            swapAngle: !left ? 180.0 - 15 * 2 : 180.0 - 15 * 2.0,
            menu: GestureDetector(
              onPanEnd: (details) {
                double y = offset.dy;
                double x = offset.dx;

                if (offset.dx >
                    MediaQuery.of(context).size.width / 2 - circleRadius) {
                  x = MediaQuery.of(context).size.width -
                      menuSize / 2 -
                      circleRadius;
                } else {
                  x = menuSize / 2 - circleRadius;
                }

                offset = Offset(x, y);
                entry.markNeedsBuild();
              },
              onPanUpdate: (DragUpdateDetails details) {
                double y = details.globalPosition.dy - circleRadius;
                double x = details.globalPosition.dx - circleRadius;
                if (x < menuSize / 2 - circleRadius) {
                  x = menuSize / 2 - circleRadius;
                }

                if (y < menuSize / 2 - circleRadius) {
                  y = menuSize / 2 - circleRadius;
                }

                if (x >
                    MediaQuery.of(context).size.width -
                        menuSize / 2 -
                        circleRadius) {
                  x = MediaQuery.of(context).size.width -
                      menuSize / 2 -
                      circleRadius;
                }

                if (y >
                    MediaQuery.of(context).size.height -
                        menuSize / 2 -
                        circleRadius) {
                  y = MediaQuery.of(context).size.height -
                      menuSize / 2 -
                      circleRadius;
                }
                offset = Offset(x, y);
                entry.markNeedsBuild();
              },
              child: Opacity(
                opacity: 0.9,
                child: Container(
                  width: menuSize,
                  height: menuSize,
                  padding: EdgeInsets.all(1.5),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(menuSize / 2)),

                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                            image: AssetImage('assets/images/icon_head.webp')),
                        borderRadius: BorderRadius.circular(menuSize / 2)),
                  ),
                ),
              ),
            ),
            children: [
              FeedbackWidget(
                  onPressed: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();


                    }
                    burstFlowKey.currentState.toggle();
                  },
                  child: Circled(color: wrapColor, child: Icon(Icons.close))),
              FeedbackWidget(
                  onPressed: () {
                    BlocProvider.of<PointBloc>(context).add(EventLoadPoint());
                    Navigator.of(context).pushNamed(UnitRouter.point);
                    burstFlowKey.currentState.toggle();

                  },
                  child: Circled(
                      color: wrapColor,
                      radius: 15,
                      child: Icon(TolyIcon.icon_bug))),
              FeedbackWidget(
                  onPressed: () {
                    Navigator.of(context).pushNamed(UnitRouter.galley);
                    burstFlowKey.currentState.toggle();

                  },
                  child: Circled(
                      color: wrapColor,
                      radius: 15,
                      child: Icon(Icons.palette))),
              FeedbackWidget(
                  onPressed: () {
                    burstFlowKey.currentState.toggle();
                  },
                  child: Circled(color: wrapColor, child: Icon(Icons.widgets))),
              FeedbackWidget(
                  onPressed: () {
                    Navigator.of(context).pushNamed(UnitRouter.setting);
                    burstFlowKey.currentState.toggle();

                  },
                  child: Circled(color: wrapColor, child: Icon(Icons.settings))),
            ]),
      ),
    );
  }

  Widget buildItem(IconData icon, Function onPress) {
    return FeedbackWidget(
      onPressed: () {
        onPress();
        close();
      },
      child: Circle(
        radius: 12,
        color: Theme.of(context).primaryColor,
        child: Icon(
          icon,
          size: 15,
          color: Colors.white,
        ),
      ),
    );
  }

  void open() {
    if (out) return;
    // _ctrl.forward();
    var px = MediaQuery.of(context).size.width - (outWidth);
    offset = Offset(px - (width - outWidth), offset.dy);
    entry.markNeedsBuild();
    out = true;
  }

  void close() {
    if (!out) return;
    var px = MediaQuery.of(context).size.width - (outWidth);
    offset = Offset(px, offset.dy);
    entry.markNeedsBuild();
    out = false;
  }

  // void toggle() {
  //   print('=====$out============');
  //   if (out) {
  //     _ctrl.reverse();
  //   } else {
  //     _ctrl.forward();
  //   }
  //   out = !out;
  //   // entry.markNeedsBuild();
  // }

  showFloating() {
    if (!show) {
      Overlay.of(context).insert(entry);
      show = true;
    }
  }

  hideFloating() {
    if (show) {
      entry.remove();
      show = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
