import 'package:flutter/material.dart';
import 'package:flutter_unit/app/utils/pather.dart';
import 'package:flutter_unit/components/panel/panel.dart';
import 'package:flutter_unit/views/dialogs/dialog_about.dart';


class CustomMaterialButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40,
        elevation: 5,
        color: Colors.orangeAccent,
        textColor: Colors.white,
        splashColor: Colors.blue,
        padding: EdgeInsets.all(8),
        child: Text("MaterialButton"),
        onPressed: () => DialogAbout.show(context));
  }
}
class LongPressMaterialButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialButton(
        height: 40,
        elevation: 5,
        color: Colors.blue,
        highlightColor: Colors.green,
        textColor: Colors.white,
        padding: EdgeInsets.all(8),
        child: Text("MaterialButton"),
        onLongPress: () => DialogAbout.show(context),
        onPressed: () => DialogAbout.show(context));
  }
}

class ShapeMaterialButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 80,
      height: 80,
      child: MaterialButton(
          textColor: Color(0xffFfffff),
          elevation: 3,
          color: Colors.blue,
          highlightColor: Color(0xffF88B0A),
          splashColor: Colors.red,
          child: Text(
            "MaterialButton",
            style: TextStyle(fontSize: 12),
          ),
          shape: _StarShapeBorder(),
          onLongPress: () => DialogAbout.show(context),
          onPressed: () => DialogAbout.show(context)),
    );
  }
}

class _StarShapeBorder extends ShapeBorder {
  @override
  // TODO: implement dimensions
  EdgeInsetsGeometry get dimensions => null;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    // TODO: implement getInnerPath
    return null;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) =>
      Pather.create.nStarPath(20, 40, 35, dx: 40, dy: 40);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    // TODO: implement paint
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    return null;
  }
}
