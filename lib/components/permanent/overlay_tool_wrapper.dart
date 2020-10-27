import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/res/toly_icon.dart';
import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/blocs/bloc_exp.dart';
import 'package:flutter_unit/components/permanent/circle.dart';
import 'package:flutter_unit/components/permanent/feedback_widget.dart';
import 'package:flutter_unit/views/pages/gallery/picture_frame.dart';

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
      var px = MediaQuery.of(context).size.width - (outWidth);
      var py = 120.0;
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

  ///绘制悬浮控件
  _buildFloating() => Material(
        color: Colors.transparent,
        child: Row(
          children: [
            GestureDetector(
                onTap: () async {
                  if (out) {
                    close();
                  } else {
                    open();
                  }
                },
                onPanUpdate: (DragUpdateDetails details) {
                  // offset = offset + details.delta;
                  double y = details.globalPosition.dy;
                  double x = details.globalPosition.dx;
                  if (y < 50) {
                    y = 50;
                  }
                  var px = MediaQuery.of(context).size.width - (outWidth);

                  if (x < px - (width - outWidth)) {
                    x = px - (width - outWidth);
                    out = true;
                  }

                  if (x > px) {
                    out = false;

                    x = px;
                  }

                  if (y > MediaQuery.of(context).size.height - 50) {
                    y = MediaQuery.of(context).size.height - 50;
                  }

                  offset = Offset(x, y - boxHeight / 2);
                  entry.markNeedsBuild();
                },
                child: Container(
                  width: outWidth,
                  height: outWidth,
                  padding: EdgeInsets.all(4),
                  child: Image.asset('assets/images/icon_head.webp'),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                            color:
                                Theme.of(context).primaryColor.withAlpha(128),
                            offset: Offset(.5, .5),
                            spreadRadius: .5,
                            blurRadius: .5)
                      ],
                      borderRadius:
                          BorderRadius.all(Radius.circular(outWidth / 2))),
                )),
            PictureFrame(
              alignment: Alignment.center,
              marge: EdgeInsets.only(left: 8),
              height: boxHeight,
              width: width - outWidth + 15,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    buildItem(TolyIcon.icon_bug, () {
                      BlocProvider.of<PointBloc>(context).add(EventLoadPoint());
                      Navigator.of(context).pushNamed(UnitRouter.point);
                    }),
                    buildItem(Icons.palette, () {
                      Navigator.of(context).pushNamed(UnitRouter.galley);
                    }),
                    buildItem(Icons.widgets, () {
                      // Navigator.of(context).pushNamed(UnitRouter.galley);
                    }),
                    buildItem(TolyIcon.icon_tag, () {
                      // Navigator.of(context).pushNamed(UnitRouter.galley);
                    }),
                    buildItem(Icons.arrow_forward_outlined, () {
                      Scaffold.of(context).openDrawer();
                    }),
                    buildItem(Icons.settings, () {
                      Navigator.of(context).pushNamed(UnitRouter.setting);
                    }),
                    buildItem(Icons.arrow_back, () {
                      Scaffold.of(context).openEndDrawer();
                    }),
                    buildItem(Icons.close, () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

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
