
import 'package:flutter/material.dart';

import '../../notifier/progress_value_notifier.dart';

class DetailProgressView extends StatefulWidget {

  const DetailProgressView({super.key});

  @override
  State<DetailProgressView> createState() => _DetailProgressViewState();
}

class _DetailProgressViewState extends State<DetailProgressView> {

  @override
  void initState() {
    super.initState();
    progress.addListener(_update);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children:[
        SizedBox(
          width: 200,
          height: 50,
          child: LinearProgressIndicator(
            value: progress.value,
            backgroundColor: Colors.grey,
          ),
        ),
        Text(progress.valueStr,style: TextStyle(color: Colors.white),)
      ],
    );
  }

  void _update() {
    setState(() {});
  }

  @override
  void dispose() {
    progress.removeListener(_update);
    super.dispose();
  }
}
