import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-30
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 182,
//      "name": 'Overlay基本使用',
//      "priority": 1,
//      "subtitle":
//          "    Overlay.of(context).insert插入全局组件",
//    }


bool show = false;
Offset offset = Offset(200, 200);

final double radius = 60;
var entry = OverlayEntry(
    builder: (context) => Stack(
          children: <Widget>[
            Positioned(
              left: offset.dx,
              top: offset.dy,
              child: _buildFloating(),
            ),
          ],
        ));

///绘制悬浮控件
_buildFloating() => GestureDetector(
      onPanDown: (details) {
        offset = details.globalPosition - Offset(radius / 2, radius / 2);
        entry.markNeedsBuild();
      },
      onPanUpdate: (DragUpdateDetails details) {
        offset = offset + details.delta;
        entry.markNeedsBuild();
      },
      onLongPress: hideFloating,
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: radius,
          width: radius,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage('assets/images/icon_head.png')),
          ),
        ),
      ));

showFloating(BuildContext context) {
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

class CustomOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Container(
          height: 50,
          child: RawMaterialButton(
            elevation: 2,
            shape: CircleBorder(
              side: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
            ),
            fillColor: Colors.blue,
            splashColor: Colors.orange,
            textStyle: TextStyle(color: Colors.white),
            child: Icon(Icons.add),
            onPressed: ()=>showFloating(context),
          ),
        ),
        Container(
          height: 50,
          child: RawMaterialButton(
            elevation: 2,
            shape: CircleBorder(
              side: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
            ),
            fillColor: Colors.red,
            splashColor: Colors.orange,
            textStyle: TextStyle(color: Colors.white),
            child: Icon(Icons.remove),
            onPressed: hideFloating,
          ),
        ),
      ],
    );
  }
}
