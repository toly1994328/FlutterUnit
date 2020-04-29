import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 300,
      alignment: Alignment.center,
      child: CircularProgressIndicator(backgroundColor: Colors.blue,valueColor:AlwaysStoppedAnimation<Color>(Colors.orangeAccent) ,),
    );
  }
}
