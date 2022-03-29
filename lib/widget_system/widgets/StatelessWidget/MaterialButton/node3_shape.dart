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
  const ShapeMaterialButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      children: <Widget>[
        SizedBox(
          width: 40,
          height: 40,
          child: MaterialButton(
              padding: const EdgeInsets.all(0),
              textColor: const Color(0xffFfffff),
              elevation: 3,
              color: Colors.blue,
              highlightColor: const Color(0xffF88B0A),
              splashColor: Colors.red,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              shape: const CircleBorder(
                side: BorderSide(width: 2.0, color: Color(0xFFDFDFDF)),
              ),
              onLongPress: () =>  Navigator.of(context).pushNamed('AboutMePage'),
              onPressed: () =>  Navigator.of(context).pushNamed('AboutMePage')),
        ),
        SizedBox(
          width: 100,
          height: 40,
          child: MaterialButton(
              padding: const EdgeInsets.all(0),
              textColor: const Color(0xffFfffff),
              elevation: 3,
              color: Colors.blue,
              highlightColor: const Color(0xffF88B0A),
              splashColor: Colors.red,
              child: const Icon(
                Icons.remove,
                color: Colors.white,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              onLongPress: () =>  Navigator.of(context).pushNamed('AboutMePage'),
              onPressed: () =>  Navigator.of(context).pushNamed('AboutMePage')),
        ),
      ],
    );
  }
}