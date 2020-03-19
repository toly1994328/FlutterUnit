import 'package:flutter/material.dart';

class LoadMoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(28.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
