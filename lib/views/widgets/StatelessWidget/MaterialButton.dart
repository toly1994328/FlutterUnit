import 'package:flutter/material.dart';
import 'package:flutter_unit/app/utils/pather.dart';
import 'package:flutter_unit/components/permanent/panel.dart';
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
    return MaterialButton(
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
    return Wrap(
      spacing: 20,
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          child: MaterialButton(
              padding: EdgeInsets.all(0),
              textColor: Color(0xffFfffff),
              elevation: 3,
              color: Colors.blue,
              highlightColor: Color(0xffF88B0A),
              splashColor: Colors.red,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              shape: CircleBorder(
                side: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
              ),
              onLongPress: () => DialogAbout.show(context),
              onPressed: () => DialogAbout.show(context)),
        ),
        Container(
          width: 100,
          height: 40,
          child: MaterialButton(
              padding: EdgeInsets.all(0),
              textColor: Color(0xffFfffff),
              elevation: 3,
              color: Colors.blue,
              highlightColor: Color(0xffF88B0A),
              splashColor: Colors.red,
              child: Icon(
                Icons.remove,
                color: Colors.white,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              onLongPress: () => DialogAbout.show(context),
              onPressed: () => DialogAbout.show(context)),
        ),
      ],
    );
  }
}
