import 'package:flutter/material.dart';

class NotSearchPage extends StatelessWidget {
  final String tips;
  const NotSearchPage({Key? key, required this.tips}):super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return Container(
      height: 300,
      alignment: Alignment.center,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
            Icon(Icons.search, color:color, size: 120.0),
           Container(
            padding:  const EdgeInsets.only(top: 16.0),
            child: Text(
              tips,
              style:  TextStyle(
                fontSize: 20,
                color: color,
              ),
            ),
          )
        ],
      ),
   );
  }
}
