import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 23,
//      "priority": 3,
//      "name": "MaterialButton的自定义形状",
//      "subtitle": "【shape】: 形状   【ShapeBorder】",
//    }

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
              onLongPress: () =>  Navigator.of(context).pushNamed('AboutMePage'),
              onPressed: () =>  Navigator.of(context).pushNamed('AboutMePage')),
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
              onLongPress: () =>  Navigator.of(context).pushNamed('AboutMePage'),
              onPressed: () =>  Navigator.of(context).pushNamed('AboutMePage')),
        ),
      ],
    );
  }
}