import 'package:flutter/material.dart';


class CustomPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100*0.618,
      child:  Placeholder(
          color: Colors.orangeAccent,
          strokeWidth: 2,
        ),
    );
  }
}
class FallbackPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child:  Placeholder(
        color: Colors.blue,
        strokeWidth: 2,
          fallbackHeight: 100,
          fallbackWidth: 150,
      ),
    );
  }
}
