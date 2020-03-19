import 'package:flutter/material.dart';

class SpacerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      width: 200,
      child: Row(
        children: <Widget>[
          Text('Begin'),
          Spacer(flex: 3,), // Defaults to a flex of one.
          Icon(Icons.ac_unit),
          // Gives twice the space between Middle and End than Begin and Middle.
          Spacer(flex: 2),
          Text('End'),
        ],
      ),
    );
  }
}
