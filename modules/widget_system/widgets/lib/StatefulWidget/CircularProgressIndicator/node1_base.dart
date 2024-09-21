import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com

class CustomCircularProgressIndicator extends StatefulWidget {
  const CustomCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  _CustomCircularProgressIndicatorState createState() =>
      _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState
    extends State<CustomCircularProgressIndicator> {

  List<double?> data = [0.2,0.4,0.6,0.8,null];

  @override
  Widget build(BuildContext context) {

    return Wrap(
      spacing: 10,
      children:data.map((e)=>SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(
          value: e,
          backgroundColor: Colors.grey.withAlpha(33),
          valueColor: const AlwaysStoppedAnimation(Colors.orange),
          strokeWidth: 5,
        ),
      )).toList(),
    );
  }
}
