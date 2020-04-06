import 'package:flutter/material.dart';
import 'package:flutter_unit/views/dialogs/dialog_about.dart';


class CustomButtonBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
            color: Colors.blue,
            child: Text("Raised"),
            onPressed: () => DialogAbout.show(context)),
        OutlineButton(
            child: Text("Outline"),
            onPressed: () => DialogAbout.show(context)),
        FlatButton(
          color: Colors.blue,
          onPressed: () => DialogAbout.show(context),
          child: Text("Flat"),
        )
      ],
    );
  }
}

class PaddingButtonBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      buttonHeight: 40,
      buttonPadding: EdgeInsets.only(left: 15,right: 15),
      children: <Widget>[
        RaisedButton(
            color: Colors.blue,
            child: Text("Raised"),
            onPressed: () => DialogAbout.show(context)),
        OutlineButton(
            child: Text("Outline"),
            onPressed: () => DialogAbout.show(context)),
        FlatButton(
          color: Colors.blue,
          onPressed: () => DialogAbout.show(context),
          child: Text("Flat"),
        )
      ],
    );
  }
}

//class AxisSizeButtonBar extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return ButtonBar(
//      alignment: MainAxisAlignment.center,
//      buttonHeight: 40,
//      mainAxisSize: MainAxisSize.min,
//      buttonPadding: EdgeInsets.only(left: 15,right: 15),
//      children: <Widget>[
//        RaisedButton(
//            color: Colors.blue,
//            child: Text("Raised"),
//            onPressed: () => DialogAbout.show(context)),
//        OutlineButton(
//            child: Text("Outline"),
//            onPressed: () => DialogAbout.show(context)),
//        FlatButton(
//          color: Colors.blue,
//          onPressed: () => DialogAbout.show(context),
//          child: Text("Flat"),
//        )
//      ],
//    );
//  }
//}

//class ButtonBarPage extends StatelessWidget {
//  ButtonBarPage({Key key}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    var btnBar = ButtonBar(
//      alignment: MainAxisAlignment.center,
//      children: <Widget>[RaisedButtonPage(), FloatingActionButtonPage(), CupertinoButtonPage()],
//    );
//    return btnBar;
//  }
//}
