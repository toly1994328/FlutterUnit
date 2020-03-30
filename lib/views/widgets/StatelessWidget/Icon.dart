import 'package:flutter/material.dart';
import 'package:flutter_unit/app/style/TolyIcon.dart';

class CustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Icon(
          Icons.send,
          color: Colors.orange,
          size: 60,
        ),
        Icon(
          Icons.android,
          color: Colors.green,
          size: 100,
        ),
      ],
    );
  }
}

class MyIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        TolyIcon.icon_search,
        TolyIcon.icon_star,
        TolyIcon.icon_widgit,
        TolyIcon.icon_star_ok
      ]
          .map((e) => Icon(
                e,
                color: Colors.green,
                size: 60,
              ))
          .toList(),
    );
  }
}
