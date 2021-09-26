import 'package:flutter/material.dart';

class NotSearchPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 300,
      alignment: Alignment.center,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
           Icon(Icons.search, color: Colors.blue, size: 120.0),
           Container(
            padding:  EdgeInsets.only(top: 16.0),
            child:  Text(
              "哥们，搜点啥...≧◔◡◔≦",
              style:  TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
   );
  }
}
