
import 'package:flutter/material.dart';

import '../../notifier/progress_value_notifier.dart';

class HomeProgressView extends StatefulWidget {

  const HomeProgressView({super.key});

  @override
  State<HomeProgressView> createState() => _HomeProgressViewState();
}

class _HomeProgressViewState extends State<HomeProgressView> {

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
          width: 100,
          height: 100,
          child: CircularProgressIndicator(
            value: progress.value,
            backgroundColor: Colors.grey,
          ),
        ),
        Text(progress.valueStr)
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
