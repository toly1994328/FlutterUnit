import 'package:flutter/material.dart';
import 'package:flutter_unit/views/widgets/StatefulWidget/Image.dart';

class TempShower extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: LoadImage()),
    );
  }
}
