import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(backgroundColor: Colors.blue,valueColor:AlwaysStoppedAnimation<Color>(Colors.orangeAccent) ,),
    );
  }
}
