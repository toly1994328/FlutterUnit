import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {

  const ErrorPage({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 300,
      alignment: Alignment.center,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
           Icon(Icons.error_outline, color: Colors.red[300], size: 120.0),
           Container(
            padding:  const EdgeInsets.only(top: 16.0),
            child:  Text(
              "好像有些小错误，ε＝(#>д<)ﾉ",
              style:  TextStyle(
                fontSize: 20,
                color: Colors.red[300],
              ),
            ),
          )
        ],
      ),
    );
  }
}
